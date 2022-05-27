#Jonathan Mai
#Mod 10 Homework

$spades = @(
'Ace of Spades', 'King of Spades',
'Queen of Spades', 'Jack of Spades',
'10 of Spades', '9 of Spades',
'8 of Spades', '7 of Spades',
'6 of Spades', '5 of Spades',
'4 of Spades', '3 of Spades',
'2 of Spades')

$diamonds = @(
'Ace of Diamonds', 'King of Diamonds',
'Queen of Diamonds', 'Jack of Diamonds',
'10 of Diamonds', '9 of Diamonds',
'8 of Diamonds', '7 of Diamonds',
'6 of Diamonds', '5 of Diamonds',
'4 of Diamonds', '3 of Diamonds',
'2 of Diamonds')

$clubs = @(
'Ace of Clubs', 'King of Clubs',
'Queen of Clubs', 'Jack of Clubs',
'10 of Clubs', '9 of Clubs',
'8 of Clubs', '7 of Clubs',
'6 of Clubs', '5 of Clubs',
'4 of Clubs', '3 of Clubs',
'2 of Clubs')


$hearts = @(
'Ace of Hearts', 'King of Hearts',
'Queen of Hearts', 'Jack of Hearts',
'10 of Hearts', '9 of Hearts',
'8 of Hearts', '7 of Hearts',
'6 of Hearts', '5 of Hearts',
'4 of Hearts', '3 of Hearts',
'2 of Hearts')

$deckSpades = @()
$deckDiamonds = @()
$deckClubs = @()
$deckHearts = @()
$counterSpades = 0
$counterDiamonds = 0
$counterClubs = 0
$counterHearts = 0



function newDeck()
{
    #Copy the original card array and make a new game deck. Set counters to 0.
    foreach ($i in $spades)
    {
        $Global:deckSpades += $i
    }
    foreach ($i in $diamonds)
    {
        $Global:deckDiamonds += $i
    }
    foreach ($i in $clubs)
    {
        $Global:deckClubs += $i
    }
    foreach ($i in $hearts)
    {
        $Global:deckHearts += $i
    }
    $Global:counterSpades = 0
    $Global:counterDiamonds = 0
    $Global:counterClubs = 0
    $Global:counterHearts = 0
}

#Removing a card from the game deck.
function removeCard($cardArray, $itemToRemove)
{
    #Make a temporary array to hold cards.
    $tempDeck = @()

    #Copy all of the suit minus the chosen card to the temp array.
    for ($i = 0; $i -le $cardArray.Count; $i++)
    {
        if ($i -eq $itemToRemove)
        {
            continue
        }
        else
        {
            $tempDeck += $cardArray[$i]
        }
    }
    #Return deck to the original array.
    return $tempDeck
}

function drawCard()
{
    clear
    
    #Get user input and verify a valid input is provided
    $cardRequest = Read-Host "How many cards would you like to draw from this deck?"
    try
    {
        $cardRequest -eq $cardRequest/1 | Out-Null       
    }
    catch
    {
        clear
        Read-Host "Invalid Option. Press Enter to return to the main menu"
        clear
        continue
    }
    $cardsRemaining = ($Global:deckSpades.Count + $Global:deckDiamonds.Count + $Global:deckClubs.Count + $Global:deckHearts.Count)
    if ($cardsRemaining -lt $cardRequest)
    {
        Write-Host "There are only $cardsRemaining cards left in the deck but you have requested $cardRequest."
        Read-Host "`r`nPress the Enter key to return to the main menu"
        clear
        continue
    }
    
    
    #If all inputs are valid
    if (($cardRequest/1 -is [int]) -and ($cardRequest -ne ""))
    {
        while ($cardRequest -ne 0)
        {
            #Request a random suit
            $variableSuit = (Get-Random -Minimum 0 -Maximum 4)

            #Draw Spades
            if ($variableSuit -eq 0)
            {
                $suitLength = $Global:deckSpades.Count

                #If there are no spades
                if ($suitLength -eq 0)
                {
                    $counterSpades = 1
                    continue
                }
                
                #Draw a card from spades
                else
                {
                    $card = (Get-Random -Minimum 0 -Maximum $suitLength)
                    if ($suitLength -eq 1)
                    {
                        Write-Host $Global:deckSpades[$card]
                        $Global:deckSpades = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    elseif ($suitLength -gt 1)
                    {
                       Write-Host $Global:deckSpades[$card]
                       $Global:deckSpades = removeCard -cardArray $Global:deckSpades -itemToRemove $card
                       $cardRequest = $cardRequest - 1
                    }
                }
            }

            #Draw Diamonds
            elseif ($variableSuit -eq 1)
            {
                $suitLength = $Global:deckDiamonds.Count

                #If there are no diamonds
                if ($suitLength -eq 0)
                {
                    $counterDiamonds = 1
                    continue
                }
                
                #Draw a card from diamonds
                else
                {
                    $card = (Get-Random -Minimum 0 -Maximum $suitLength)
                    if ($suitLength -eq 1)
                    {
                        Write-Host $Global:deckDiamonds[$card]
                        $Global:deckDiamonds = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    elseif ($suitLength -gt 1)
                    {
                       Write-Host $Global:deckDiamonds[$card]
                       $Global:deckDiamonds = removeCard -cardArray $Global:deckDiamonds -itemToRemove $card
                       $cardRequest = $cardRequest - 1
                    }
                }
            }

            #Draw Clubs
            elseif ($variableSuit -eq 2)
            {
                $suitLength = $Global:deckClubs.Count

                #If there are no clubs
                if ($suitLength -eq 0)
                {
                    $counterClubs = 1
                    continue
                }
                
                #Draw a card from clubs
                else
                {
                    $card = (Get-Random -Minimum 0 -Maximum $suitLength)
                    if ($suitLength -eq 1)
                    {
                        Write-Host $Global:deckClubs[$card]
                        $Global:deckClubs = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    elseif ($suitLength -gt 1)
                    {
                       Write-Host $Global:deckClubs[$card]
                       $Global:deckClubs = removeCard -cardArray $Global:deckClubs -itemToRemove $card
                       $cardRequest = $cardRequest - 1
                    }
                }
            }
            
            #Draw Hearts
            elseif ($variableSuit -eq 3)
            {
                $suitLength = $Global:deckHearts.Count

                #If there are no hearts
                if ($suitLength -eq 0)
                {
                    $counterHearts = 1
                    continue
                }
                
                #Draw a card from hearts
                else
                {
                    $card = (Get-Random -Minimum 0 -Maximum $suitLength)
                    if ($suitLength -eq 1)
                    {
                        Write-Host $Global:deckHearts[$card]
                        $Global:deckHearts = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    elseif ($suitLength -gt 1)
                    {
                       Write-Host $Global:deckHearts[$card]
                       $Global:deckHearts = removeCard -cardArray $Global:deckHearts -itemToRemove $card
                       $cardRequest = $cardRequest - 1
                    }
                }
            }
        }
        Read-Host
    }
    else
    {
        clear
        Read-Host "Invalid Option. Press Enter to return to the main menu"
        clear
        continue
    }
}
    










newDeck
while ($true)
{
    clear
    Write-Host "Welcome to the card deck simulator.
    
Please select from the following options:

    1. Draw a selected number of cards from the current deck
    2. Get a new deck of cards
    3. Exit`r`n"

    $userOption = Read-Host "Option#"

    if ($userOption -eq 1)
    {
        drawCard
    }
    elseif ($userOption -eq 2)
    {
        clear
        newDeck
    }
    elseif ($userOption -eq 3)
    {
        exit
    }
    else
    {
        clear
        Write-Host "That is not a valid selection. Press Enter to continue"
        Read-Host
    }
}