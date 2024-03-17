function Start-SimonSays {
    #Initialization parameters
    $colorsArray = @("Red", "Green", "Yellow", "Blue")
    [System.Collections.ArrayList]$simonArray = @()
    [System.Collections.ArrayList]$playerArray = @()
    $gameRunning = $false

    #Welcome messages and start menu
    Write-Host "Welcome to Simon Says: PWSH Edition!"
        Start-Sleep 1
    Write-Host "Created by Alex Matthews"
        Start-Sleep 1
    Write-Host "Find me on GitHub at " -NoNewLine
    Write-Host "https://github.com/DOTaleckx" -ForegroundColor Magenta
        Start-Sleep 1
    Write-Host "Press any key to start!"
        Start-Sleep 1
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    [System.Console]::Clear()

    #Game program
    $gameRunning = $true
        do {
            #Quick screen wipe
            [System.Console]::Clear()

            #Get random color, add it to Simon's array, then print each color with a delay and erase after each line.
            $randomIndex = Get-Random -Minimum 0 -Maximum 3
            [void]$simonArray.Add($colorsArray[$randomIndex])
                foreach ($color in $simonArray) {
                    Write-Host -ForegroundColor $color "Simon says... $color"
                    Start-Sleep 1
                    [System.Console]::Clear()
                    Start-Sleep 1
                }

            #Clear player array, prompt to guess w/ instructions, then for each of simon's colors, allow host entry and append to player array.
            $playerArray.Clear()
            Write-Host "Enter your guess, one color at a time, and try to replicate Simon's colors!"

                do {
                    $playerGuess = Read-Host -Prompt "Your guess: "
                        if ($colorsArray -contains $playerGuess) {
                            [void]$playerArray.Add($playerGuess)
                        } else {
                            Write-Host "Invalid guess. Your options are Red, Green, Yellow, or Blue."
                            
                        }
                } while ($playerArray.count -lt $simonArray.count)
            
            #Check to see if player's guesses are equal to Simon's array
            if ((Compare-Object -ReferenceObject $playerArray -DifferenceObject $simonArray) -ne $null) {
                
                $playerScore = (($simonArray.count - 1) * 50)

                Write-Host -ForegroundColor Red "You lose."
                    Start-Sleep 1

                    "-"*50
                
                #Display Simon's colors
                Write-Host "Simon's colors were..."
                    Start-Sleep 1
                foreach ($simonColor in $simonArray) {
                    Write-Host -ForegroundColor $simonColor "$simonColor"
                    Start-Sleep 1
                }
                
                    "-"*50

                #Display player's colors
                Write-Host -ForegroundColor Yellow "Your colors were..."
                        foreach ($playerColor in $playerArray) {
                    Write-Host -ForegroundColor $playerColor "$playerColor"
                    Start-Sleep 1
                }
                    "-"*50

                Write-Host "Your score: $playerScore"
                Start-Sleep 1

                Write-Host "Thanks for playing!"
                Start-Sleep 3
                Return
            } 

        } while ($gameRunning)
    }

Write-Host -ForegroundColor Yellow "simonSays.ps1 has been loaded. Run command " -NoNewline
Write-Host -ForegroundColor Magenta "Start-SimonSays " -NoNewline
Write-Host -ForegroundColor Yellow "to play!"
