#Joanthan Mai
#Mod 12 Homework

$user_path = "C:\Users\" + $env:USERNAME + "\Desktop"
Set-Location $user_path

#Write the header
Write-Output ("Date,Time,Priority,Classification,Description,Source IP,Destination IP") | Out-File "alert_data.csv" -Encoding ascii

#Read fast_short.pcap line by line and extract data for each column
$file = ".\fast_short.pcap"
$data = @()

#Insert pcap data into data array
foreach ($line in Get-Content $file)
{
    
    #Date and Time
    $dateTime = $line.Split("[**]")[0]
    $date = $dateTime.Split("-")[0]
    $time = $dateTime.Split("-")[1]
    $date = $date.Trim(" ")
    $time = $time.Trim(" ")

    #Priority
    $priority = $line.Split("[**]",[System.StringSplitOptions]::RemoveEmptyEntries)[7]
    $priority = $priority.Split("Priority: ",[System.StringSplitOptions]::RemoveEmptyEntries)[0]
    $priority = $priority.Trim(" ")
    
    #Classification
    $classification = $line.Split("[**]",[System.StringSplitOptions]::RemoveEmptyEntries)[5]
    $classification = $classification.Split(":")[1]
    $classification = $classification.Trim(" ")

    #Description
    $description = $line.Split("[**]",[System.StringSplitOptions]::RemoveEmptyEntries)[3]
    $description = $description.Trim(" ")
    
    #Source IP
    $sourceIP = $line.Split("[**]",[System.StringSplitOptions]::RemoveEmptyEntries)[8]
    $sourceIP = $sourceIP.Split(" ")[2]
    $sourceIP = $sourceIP.Trim(" ")

    #Destination IP
    $destinationIP = $line.Split("[**]",[System.StringSplitOptions]::RemoveEmptyEntries)[8]
    $destinationIP = $destinationIP.Split(" ")[4]
    $destinationIP = $destinationIP.Trim(" ")

    Write-Output ($date + "," + $time + "," + $priority + "," + $classification + "," + $description + "," + 
    $sourceIP + "," + $destinationIP) | Out-File "alert_data.csv" -Encoding ascii -Append
}

Read-Host "Processing is done. Press enter to close the script"