#Jonathan Mai
#Mod 11 Homework

$Global:name_list = @('Constance Castillo', 'Kerry Goodwin',
 'Dorothy Carson', 'Craig Williams', 'Daryl Guzman', 'Sherman Stewart',
 'Marvin Collier', 'Javier Wilkerson', 'Lena Olson', 'Claudia George',
 'Erik Elliott', 'Traci Peters', 'Jack Burke', 'Jody Turner',
 'Kristy Jenkins', 'Melissa Griffin', 'Shelia Ballard', 'Armando Weaver',
 'Elsie Fitzgerald', 'Ben Evans', 'Lucy Baker', 'Kerry Anderson',
 'Kendra Tran', 'Arnold Wells', 'Anita Aguilar', 'Earnest Reeves',
 'Irving Stone', 'Alice Moore', 'Leigh Parsons', 'Mandy Perez',
 'Rolando Paul', 'Delores Pierce', 'Zachary Webster', 'Eddie Ward',
 'Alvin Soto', 'Ross Welch', 'Tanya Padilla', 'Rachel Logan',
 'Angelica Richards', 'Shelley Lucas', 'Alison Porter', 'Lionel Buchanan',
 'Luis Norman', 'Milton Robinson', 'Ervin Bryant', 'Tabitha Reid',
 'Randal Graves', 'Calvin Murphy', 'Blanca Bell', 'Dean Walters',
 'Elias Klein', 'Madeline White', 'Marty Lewis', 'Beatrice Santiago',
 'Willis Tucker', 'Diane Lloyd', 'Al Harrison', 'Barbara Lawson',
 'Jamie Page', 'Conrad Reynolds', 'Darnell Goodman', 'Derrick Mckenzie',
 'Erika Miller', 'Tasha Todd', 'Aaron Nunez', 'Julio Gomez',
 'Tommie Hunter', 'Darlene Russell', 'Monica Abbott', 'Cassandra Vargas',
 'Gail Obrien', 'Doug Morales', 'Ian James', 'Jean Moran',
 'Carla Ross', 'Marjorie Hanson', 'Clark Sullivan', 'Rick Torres',
 'Byron Hardy', 'Ken Chandler', 'Brendan Carr', 'Richard Francis',
 'Tyler Mitchell', 'Edwin Stevens', 'Paul Santos', 'Jesus Griffith',
 'Maggie Maldonado', 'Isaac Allen', 'Vanessa Thompson', 'Jeremy Barton',
 'Joey Butler', 'Randy Holmes', 'Loretta Pittman', 'Essie Johnston',
 'Felix Weber', 'Gary Hawkins', 'Vivian Bowers', 'Dennis Jefferson',
 'Dale Arnold', 'Joseph Christensen', 'Billie Norton', 'Darla Pope',
 'Tommie Dixon', 'Toby Beck', 'Jodi Payne', 'Marjorie Lowe',
 'Fernando Ballard', 'Jesse Maldonado', 'Elsa Burke', 'Jeanne Vargas',
 'Alton Francis', 'Donald Mitchell', 'Dianna Perry', 'Kristi Stephens',
 'Virgil Goodwin', 'Edmund Newton', 'Luther Huff', 'Hannah Anderson',
 'Emmett Gill', 'Clayton Wallace', 'Tracy Mendez', 'Connie Reeves',
 'Jeanette Hansen', 'Carole Fox', 'Carmen Fowler', 'Alex Diaz',
 'Rick Waters', 'Willis Warren', 'Krista Ferguson', 'Debra Russell',
 'Ellis Christensen', 'Freda Johnston', 'Janis Carpenter', 'Rosemary Sherman',
 'Earnest Peters', 'Kelly West', 'Jorge Caldwell', 'Moses Norris',
 'Erica Riley', 'Ray Gordon', 'Abel Poole', 'Cary Boone',
 'Grant Gomez', 'Denise Chapman', 'Vernon Moran', 'Ben Walker',
 'Francis Benson', 'Andrea Sullivan', 'Wayne Rice', 'Jamie Mason',
 'Jane Figueroa', 'Pat Wade', 'Rudy Bates', 'Clyde Harris',
 'Andre Mathis', 'Carlton Oliver', 'Merle Lee', 'Amber Wright',
 'Russell Becker', 'Natalie Wheeler', 'Maryann Miller', 'Lucia Byrd',
 'Jenny Zimmerman', 'Kari Mccarthy', 'Jeannette Cain', 'Ian Walsh',
 'Herman Martin', 'Ginger Farmer', 'Catherine Williamson', 'Lorena Henderson',
 'Molly Watkins', 'Sherman Ford', 'Adam Gross', 'Alfred Padilla',
 'Dwayne Gibson', 'Shawn Hall', 'Anthony Rios', 'Kelly Thomas',
 'Allan Owens', 'Duane Malone', 'Chris George', 'Dana Holt',
 'Muriel Santiago', 'Shelley Osborne', 'Clinton Ross', 'Kelley Parsons',
 'Sophia Lewis', 'Sylvia Cooper', 'Regina Aguilar', 'Sheila Castillo',
 'Sheri Mcdonald', 'Lynn Hodges', 'Patrick Medina', 'Arlene Tate',
 'Minnie Weber', 'Geneva Pena', 'Byron Collier', 'Veronica Higgins',
 'Leo Roy', 'Nelson Lopez')

function option1()
{
    clear
    $found = 0
    
    #Take one or more letters that begin a first name
    $search = Read-Host "Enter the first name, or a partial start of the first name"

    #Convert $search into title case
    $search = (Get-Culture).TextInfo.ToTitleCase($search.ToLower())

    #Compare $search to each item in $name_list
    foreach ($i in $name_list)
    {
        if ($i.StartsWith($search))
        {
            Write-Host $i
            $found += 1
        }
    }

    #If no names are found
    if ($found -eq 0)
    {
        Write-Host ("No first names were found starting with $search")
    }
}

function option2()
{
    clear
    $found = 0
    $splitName = @()
    $lastName = @()
    
    #Take one or more letters that begin a last name
    $search = Read-Host "Enter the last name, or a partial start of the last name"

    #Convert $search into title case
    $search = (Get-Culture).TextInfo.ToTitleCase($search.ToLower())

    #Split up the last names and set them into an array
    foreach ($i in $name_list)
    {
        $splitName += $i.Split(" ")
    }

    #Add the last name to an array for comparison
    for ($i=0; $i -lt $splitName.length; $i +=2)
    {
        $lastName += $splitName[$i+1]
    }

    for ($i=0; $i -lt $lastName.length; $i +=1)
    {
        if ($lastName[$i].StartsWith($search))
        {
            Write-Host $name_List[$i]
            $found += 1
        }
    }

    #If no names are found
    if ($found -eq 0)
    {
        Write-Host ("No first names were found starting with $search")
    }
    Read-Host
}

function option3()
{
    clear
    $tempArray = @()

    #Get the first name
    $userFirstName = Read-Host "Enter the new first name"
    $userLastName = Read-Host "Enter the last name"

    #Join strings
    $addName = $userFirstName + " " + $userLastName

    #Insert $addName to the array
    $indexPosition = Get-Random -Minimum 0 -Maximum ($name_list.Length + 1)
    if($indexPosition -eq 0)
    {
        $tempArray += $addName
        for($i = 0;$i -lt $name_list.Length;$i++)
        {
            $myNewArray += $name_list[$i]
        }        
    }
    elseif($indexPosition -ge $name_list.Length)
    {
        for($i = 0;$i -lt $name_list.Length;$i++)
        {
            $tempArray += $name_list[$i]
        }
        $tempArray += $addName
    }
    else
    {
        for($i = 0;$i -lt $indexPosition;$i++)
        {
            $tempArray += $name_list[$i]
        }
        $tempArray += $addName
        for($i = $indexPosition;$i -lt $name_list.Length;$i++)
        {
            $tempArray += $name_list[$i]
        }
    }
    $Global:name_list = $tempArray
}

function option4()
{
    #Variables to manage deletion
    $deleteCounter = 0
    $deleteArray = @()
    while ($true)
    {
        clear

        #Option to delete name, view names, or quit
        $option4Choice = Read-Host "Enter the full name. `"`1`" to view names or `"`Q`" to quit"

        #Run search function
        if ($option4Choice -eq 1)
        {
            option1
            Read-Host "`r`nPress Enter to return to the previous menu"
            continue
        }

        #End function
        elseif ($option4Choice -eq "Q" -or $option4Choice -eq "q")
        {
            break
        }

        #Attempt to delete a name
        else
        {
            
            #Step through the original list
            foreach ($i in $name_list)
            {
                
                #If matched name is found, skip adding the name to the array
                if ($i -eq $option4Choice)
                {
                    $deleteCounter += 1
                    continue
                }

                #Add name to array
                else
                {
                    $deleteArray += $i
                }
            }

            #If the requested name was not found
            if ($deleteCounter -eq 0)
            {
                Write-Host "$option4Choice was not found"
                Read-Host "Press Enter to return to the previous menu"
            }

            #If the requested name was found and deleted
            else
            {
                Write-Host "$option4Choice has been deleted"
                Read-Host "Press Enter to return to the previous menu"
            }
            #Reform array
                $Global:name_list = $deleteArray              
        }
        break
    }
}


while ($true)
{
    clear
    Write-Host ("Please select from the following options:
    
        1. List all names starting with one or more letters of the first name
        2. List all names starting with one or more letters of the last name
        3. Add a name
        4. Delete a name
        5. Exit`r`n")

    $userChoice = Read-Host "Option"

    if ($userChoice -eq 1)
    {
        option1
        Read-Host
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
        option4
    }
    elseif ($userChoice -eq 5)
    {
        exit
    }
    else
    {
        continue
    }
}