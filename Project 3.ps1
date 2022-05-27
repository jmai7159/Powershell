#Jonathan Mai
#Project 3

$user_path = "C:\Users\" + $env:USERNAME + "\Desktop"
Set-Location $user_path
$MIXED_URLS_FILE = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\Mixed URLs\Mixed URLs.txt"
$PROCESSED_MIXED_URLS = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\Mixed URLs\Processed Mixed URLs"
$PROCESSED_BAD_URLS = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\Bad URLs\Processed Bad URLs"
$TEMP_FILE = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\Temp"
$BAD_URLS = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\Bad URLs\Bad URLs.txt"
$MASTER_URLS = "C:\Users\" + $env:USERNAME + "\Desktop\URLs\URL Master File.txt"

$processedFile = (Get-Date -f yyyyMMddTHHmmssffff)


function startup()
{
    clear
    #Check to see if the URLs directory is available
    if (Test-Path ("C:\Users\" + $env:USERNAME + "\Desktop\URLs"))
    {
        #Remove URLs Directory recursively
        Remove-Item ("C:\Users\" + $env:USERNAME + "\Desktop\URLs") -Recurse
    }

    #Check to see if the Project Files is available
    if (-not(Test-Path ("C:\Users\" + $env:USERNAME + "\Desktop\Project Files.zip")))
    {
        Write-Host "Place Project_Files.zip on the desktop then run this script again."
        Read-Host "`r`nPress Enter to exit the script"
        exit
    }
    else
    {
        #Unpack the Project Files into a new URLs directory
        Expand-Archive -Path ("C:\Users\" + $env:USERNAME + "\Desktop\Project Files.zip") -DestinationPath .\URLs -Force
    }
}

#Process Mixed URLs
function option1()
{
    clear

    #Check to see if Mixed URLs File in Mixed URLs folders
    if (-not(Test-Path $MIXED_URLS_FILE))
    {
        Read-Host "There are no more mixed URL files. Press Enter to the main menu"
        return
    }

    Write-Host "Processing...please be patient"

    #Create temp file for good and bad URLs tempxurls
    New-Item -Path $TEMP_FILE -ItemType File -Name tempgoodurls | Out-Null
    New-Item -Path $TEMP_FILE -ItemType File -Name tempbadurls | Out-Null
    
    #Read Mixed URLs File. Test URLs and sort into temp files
    foreach ($line in Get-Content $MIXED_URLS_FILE)
    {
        
        #Read from mixed URLs file to get URLs.
        $url = $line.Split("`t",[System.StringSplitOptions]::RemoveEmptyEntries)[3]
        
        #Write the Good URLs to the temp good URL file
        try
        {
            $req = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 2 -MaximumRedirection 1
            Write-Output $line | Out-File ($TEMP_FILE + "\tempgoodurls") -Append
        }

        #Write the Bad URLs to the temp bad URL file
        catch
        {
            Write-Output $line | Out-File ($TEMP_FILE + "\tempbadurls") -Append
        }
    }

    #Read tempbadurls and append to the bad url file. Delete the tempbadurls file
    $tempBadURLs = ($TEMP_FILE + "\tempbadurls")
    foreach ($line in Get-Content $tempBadURLs)
    {
        Write-Output $line | Out-File $BAD_URLS -Encoding ascii -Append
    }
    Remove-Item $tempBadURLs

    #Read tempgoodurls and append to the master url file. Delete the tempgoodurls file
    $tempGoodURLs = ($TEMP_FILE + "\tempgoodurls")
    foreach ($line in Get-Content $tempGoodURLs)
    {
        Write-Output $line | Out-File $MASTER_URLS -Encoding ascii -Append
    }
    Remove-Item $tempGoodURLs

    #Move mixed URL file to processed Mixed URL folder
    Move-Item $MIXED_URLS_FILE ("$PROCESSED_MIXED_URLS/$(Get-Date -f yyyyMMddTHHmmssffff) mixed urls.txt")
}

#Process Bad URLs
function option2()
{
    clear

    #Check to see if Mixed URLs File in Mixed URLs folders
    if (-not(Test-Path $BAD_URLS))
    {
        Read-Host "There are no more Bad URL files. Press Enter to the main menu"
        return
    }

    Write-Host "Processing...please be patient"

    #Build an array of bad urls from the bad URL file
    $badURLArray = @()
    foreach ($line in Get-Content $BAD_URLS)
    {
        $badURLArray += $line
    }

    #Build an array of master urls from the master URL file
    $masterURLArray = @()
    foreach ($line in Get-Content $MASTER_URLS)
    {
        if ($line.ReadCount -eq 1)
        {
            continue
        }
        $masterURLArray += $line
    }

    #Remove the bad urls from the master url file
    $badFlag = 0
    $tempURLArray = @()
    foreach ($i in $masterURLArray)
    {
        foreach($j in $badURLArray)
        {
            if ($j -eq $i)
            {
                $badFlag = 1
                break
            }
        }

        if ($badFlag -ne 1)
        {
            $tempURLArray += $i
        }
        $badFlag = 0
    }

    #Write the header
    Write-Output ("Primary Category`tSecondary Category`tTitle`tURL") | Out-File $MASTER_URLS

    #Write temp array to master URL file
    foreach ($k in $tempURLArray)
    {
        Write-Output $k | Out-File $MASTER_URLS -Append
    }
    Move-Item $BAD_URLS ("$PROCESSED_BAD_URLS/$(Get-Date -f yyyyMMddTHHmmssffff) bad urls.txt")
}

function option3()
{
    clear
    $matchFlag = 0
    $matchMaster = @()
    $titleMatch = @()

    #Build Master URL Array from Master URL File
    foreach ($line in Get-Content $MASTER_URLS)
    {
        if ($line.ReadCount -eq 1)
        {
            continue
        }
        $matchMaster += $line
    }
    
    #Get user input for matching
    $userMatch = Read-Host "Enter all or part of a title"

    #Find matches
    foreach ($i in $matchMaster)
    {
        $title = $i.Split("`t",[System.StringSplitOptions]::RemoveEmptyEntries)[2]
        $url = $i.Split("`t",[System.StringSplitOptions]::RemoveEmptyEntries)[3]

        if ($title.Contains($userMatch))
        {
            $matchFlag = 1
            $titleMatch += "$title|$url"
        }
    }

    #Sort array and remove duplicates
    if ($matchFlag -eq 1)
    {
        $titleMatch = $titleMatch | sort -Unique

        #Split on the |
        foreach ($x in $titleMatch)
        {
            $printTitle = $x.Split("|",[System.StringSplitOptions]::RemoveEmptyEntries)[0]
            $printURL = $x.Split("|",[System.StringSplitOptions]::RemoveEmptyEntries)[1]
            Write-Host "Title: "$printTitle
            Write-Host "URL: "$printURL
            Write-Host
        }
        $matchFlag = 0
    }
    else
    {
        Write-Host "No titles matched $userMatch.`r`n"
    }
    Read-Host "Press Enter to return to the main menu"
}



startup

while ($true)
{
    clear
    Write-Host ("----- MAIN MENU -----

Please select from the following options:
    
1. Process Mixed URLs
2. Process Bad URLs
3. Look up URLs by Title
4. Exit`r`n")

    $userChoice = Read-Host "Option#"

    if ($userChoice -eq 1)
    {
        option1
    }
    elseif ($userChoice -eq 2)
    {
        option2
    }
    elseif ($userChoice -eq 3)
    {
        option3
    }
    elseif ($userChoice -eq 4)
    {
        clear
        exit
    }
    else
    {
        clear
        Read-Host "That is not a valid option. Please press Enter to try again"
        continue
    }
}