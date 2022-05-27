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
    $cardsRemaining = ($deckSpades.Length + $deckDiamonds.Length + $deckClubs.Length + $deckHearts.Length)
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
                $suitLength = $deckSpades.Length

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
                        Write-Host $deckSpades[$card]
                        $deckSpades = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    else
                    {
                       Write-Host $deckSpades[$card]
                       removeCard($deckSpades, $card)
                       $cardRequest = $cardRequest - 1
                    }
                }
            }

            #Draw Diamonds
            elseif ($variableSuit -eq 1)
            {
                $suitLength = $deckDiamonds.Length

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
                        Write-Host $deckDiamonds[$card]
                        $deckDiamonds = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    else
                    {
                       Write-Host $deckDiamonds[$card]
                       removeCard($deckDiamonds, $card)
                       $cardRequest = $cardRequest - 1
                    }
                }
            }

            #Draw Clubs
            elseif ($variableSuit -eq 2)
            {
                $suitLength = $deckClubs.Length

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
                        Write-Host $deckClubs[$card]
                        $deckClubs = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    else
                    {
                       Write-Host $deckClubs[$card]
                       removeCard($deckClubs, $card)
                       $cardRequest = $cardRequest - 1
                    }
                }
            }
            
            #Draw Hearts
            elseif ($variableSuit -eq 3)
            {
                $suitLength = $deckHearts.Length

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
                        Write-Host $deckHearts[$card]
                        $deckHearts = @()
                        $cardRequest = $cardRequest - 1
                        continue
                    }
                    else
                    {
                       Write-Host $deckHearts[$card]
                       removeCard($deckHearts, $card)
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