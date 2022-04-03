#Jonathan Mai
#Mod 09 Homework
clear

#Variables
$sodaPrice = (100 + ((Get-Random -Minimum 0 -Maximum 4) * 5))
$balance = $sodaPrice

#Ask for user input for soda machine
Write-Host ("Welcome to the soda machine. You can enter values of 5, 10 or 25 in payment")
$soda = Read-Host("`r`nWhat type of soda would you like?")
clear

#Write the current price of the soda 
Write-Host ("The current price of $soda is $sodaPrice cents")

#Prompt the user to enter a coin. Check for invalid inputs
while ($balance -gt 0)
{
    $payment = Read-Host("`r`nEnter a coin")
    if ($payment -eq 5)
    {
        clear
        Write-Host ("You have entered a nickel")
        $balance = $balance - 5
    }
    elseif ($payment -eq 10)
    {
        clear
        Write-Host ("You have entered a dime")
        $balance = $balance - 10
    }
    elseif ($payment -eq 25)
    {
        clear
        Write-Host ("You have entered a quarter")
        $balance = $balance - 25
    }
    else
    {
        clear
        Write-Host ("That is not a valid amount")
    }

    #Check how much money is still owed or needs to be refunded
    if ($balance -gt 0)
    {
        Write-Host ("`r`nYou still owe $balance")
    }
    elseif ($balance -lt 0)
    {
        Write-Host ("`r`nYou have been refunded " + ($balance * -1) + " cents")
    }
}

#Script close.
Write-Host ("`r`nEnjoy your $soda!")
Read-Host ("`r`nPress enter to close the program")
clear