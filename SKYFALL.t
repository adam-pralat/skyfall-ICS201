%<><><><><><><><><><><><><><><><><><> SKYFALL Game <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
%------------------------------------ By Adam Pralat and Noah Black -------------------------------------------------------------------
%++++++++++++++++++++++++++++++++++++ Both did Coding and Documentation +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Variables >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

var characterX : int := maxx div 2 %X-Coordinate of the character
var characterY : int := maxy div 2 %Y-Coordinate of the character
var key : array char of boolean %Key input for moving the character
var drawing : boolean := false %True/False value depending on if obstacle has finished drawing
var obstacleX, obstacleY : int %Obstacle X and Y coordinates
var speed : int := 6 %Delay between each frame (Lower value = Faster Speed)
var cScore, hScore : int := 0 %Current score and high score for the user
var titlefont : int := Font.New ("serif:50:bold") %Font for headings on the title page
var titlefontsmall : int := Font.New ("serif:15:bold") %Font for smaller writing on the title page
var startkey : string := 'a' %Key input to check if user wants to start the game
var gamestart : boolean := false %True/False value depending on if user has started game
var mousex, mousey, button, ud : int %Getting mouse coordinates and current button to see if user pressed a button
var explosionX, explosionY : int %X and Y corrdinates of the explosion when the user crashes
var exitKey : boolean := false %True/False value depending on if user has exited from the Manuel/Customization/Biographies
var charactercolKey : char %Key input to see what part of character user has decided to select and what colour they are changing it to
var colorselector : int := 1 %Int to see what part of the character the user has selected for customization
var parachuteCol : int := red %Colour of the parachute
var parachutecolorpicker : int := 1 %Int to see what colour the user has selected for the parachute (Increases/Decreases based on user input)
var helmetcolorpicker : int := 1 %Int to see what colour the user has selected for the helmet(Increases/Decreases based on user input)
var helmetCol : int := 115 %Colour of the helmet
var shirtCol : int := 244 %Colour of the shirt
var shirtcolorpicker : int := 1 %Int to see what colour the user has selected for the shirt (Increases/Decreases based on user input)
var pantsCol : int := 244 %Colour of the pants
var pantscolorpicker : int := 1 %Int to see what colour the user has selected for the pants (Increases/Decreases based on user input)
var shoesCol : int := black %Colour of the shoes
var shoescolorpicker : int := 1 %Int to see what colour the user has selected for the shoes (Increases/Decreases based on user input)
var exitChar : char %Key input to see if user wants to exit back to the main menu


%************************************* Procedures *************************************************************************************

procedure drawCharacter (helmetCol : int, shirtCol : int, pantsCol : int, shoesCol : int)
    for i : 0 .. 20
	drawfilloval (characterX - i, characterY + 20 - i, 7, 7, pantsCol)      % Left leg
	drawfilloval (characterX + i, characterY + 20 - i, 7, 7, pantsCol)      % Right leg
	drawfilloval (characterX - 5 - i, characterY + 30 + i, 8, 8, shirtCol)  % Left arm
	drawfilloval (characterX + 5 + i, characterY + 30 + i, 8, 8, shirtCol)  % Right arm
	if i = 20 then
	    drawfilloval (characterX - i, characterY + 20 - i, 9, 9, shoesCol)  % Left boot
	    drawfilloval (characterX + i, characterY + 20 - i, 9, 9, shoesCol)  % Right boot
	    drawfilloval (characterX - 5 - i, characterY + 30 + i, 8, 8, 90)    % Left hand
	    drawfilloval (characterX + 5 + i, characterY + 30 + i, 8, 8, 90)    % Right hand
	end if
    end for
    drawfilloval (characterX, characterY + 30, 15, 22, shirtCol)                % Body
    drawfilloval (characterX, characterY + 15, 15, 7, pantsCol)                 % Pants
    drawfilloval (characterX, characterY + 60, 20, 20, helmetCol)               % Hat
    drawfilloval (characterX, characterY + 55, 15, 15, 90)                      % Face
    drawfillbox (characterX - 15, characterY + 60, characterX + 15, characterY + 70, helmetCol) % Shapes hat
    drawoval (characterX - 8, characterY + 60, 11, 6, black)                    % Left goggle outline
    drawoval (characterX + 8, characterY + 60, 11, 6, black)                    % Right goggle outline
    drawfilloval (characterX - 8, characterY + 60, 10, 5, 102)                  % Left goggle
    drawfilloval (characterX + 8, characterY + 60, 10, 5, 102)                  % Right goggle
    drawfilloval (characterX, characterY + 47, 10, 5, 64)                       % Mouth
    drawfillbox (characterX - 10, characterY + 47, characterX + 10, characterY + 52, white)     % Teeth
    drawfillbox (characterX - 10, characterY + 51, characterX + 10, characterY + 52, 90)        % Shapes mouth
end drawCharacter

procedure drawParachute (parachuteCol : int)
    drawfilloval (characterX, characterY + 100, 30, 50, parachuteCol)   % Parachute top
    drawfillbox (characterX - 30, characterY + 100, characterX + 30, characterY, 77)    % Makes parachute into semicircle
    for i : 0 .. 3
	if i not= 3 then
	    drawfilloval (characterX - 20 + 20 * i, characterY + 100, 7, 7, 77) % Shapes the parachute
	end if
	drawline (characterX, characterY + 50, characterX - 30 + 20 * i, characterY + 100, black)   % Draws parachute strings
    end for
end drawParachute

procedure resetVars % Resets all variables to their original value
    characterX := maxx div 2
    drawing := false
    speed := 6
    cScore := 0
    startkey := 'a'
    exitKey := false
    charactercolKey := 'a'
    exitChar := 'a'
end resetVars

%/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/ Set Screen \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
setscreen ("graphics:500;600")
colorback (77)


loop
    %///////////////////////////////// Title Screen \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

    if gamestart = false then   % If the user has not pressed play, then you go to the loading screen

	resetVars
	setscreen ("nooffscreenonly")
	drawfill (1, 1, 77, black)  % Background

	% Cloud and Title
	drawfilloval (250, 430, 200, 100, white)
	drawfilloval (200, 400, 100, 100, white)
	drawfilloval (300, 410, 100, 100, white)
	drawfilloval (170, 450, 100, 100, white)
	drawfilloval (320, 440, 100, 100, white)
	Font.Draw ("Welcome to ", maxx div 2 - 120, maxy div 5 * 4, titlefontsmall, black)
	Font.Draw ("SKY FALL", maxx div 4 - 20, maxy div 6 * 4, titlefont, black)

	% Draws Buttons
	drawfillbox (15, 50, 165, 125, black)
	drawfillbox (25, 60, 155, 115, 29)
	Font.Draw ("USER'S", 55, 90, titlefontsmall, black)
	Font.Draw ("MANUAL", 48, 65, titlefontsmall, black)
	drawfillbox (175, 50, 325, 125, black)
	drawfillbox (185, 60, 315, 115, 29)
	Font.Draw ("CUSTOMIZE", 190, 90, titlefontsmall, black)
	Font.Draw ("CHARACTER", 188, 65, titlefontsmall, black)
	drawfillbox (maxx - 15, 50, maxx - 165, 125, black)
	drawfillbox (maxx - 25, 60, maxx - 155, 115, 29)
	Font.Draw ("ABOUT THE", 350, 90, titlefontsmall, black)
	Font.Draw ("CREATORS", 355, 65, titlefontsmall, black)
	drawfillbox (145, 165, 355, 260, black)
	drawfillbox (155, 175, 345, 250, 29)
	Font.Draw ("PLAY", 160, 190, titlefont, black)

	delay (500)

	loop
	    Mouse.ButtonWait ("down", mousex, mousey, button, ud)   % Waits for user to click button
	    if mousey > 50 and mousey < 125 then
		if mousex > 15 and mousex < 165 then    % If this button is pressed, it opens the User's Manual
		    cls

		    %Draws Cloud
		    drawfilloval (180, 500, 300, 150, white)
		    drawfilloval (370, 520, 100, 100, white)
		    drawfilloval (80, 450, 100, 100, white)
		    drawfilloval (190, 420, 100, 100, white)
		    drawfilloval (320, 450, 100, 100, white)

		    % Draws Character
		    characterY := 200
		    drawParachute (parachuteCol)
		    drawCharacter (helmetCol, shirtCol, pantsCol, shoesCol)

		    % Writes out User's Manual
		    Font.Draw ("Welcome to SKYFALL!", 10, maxy - 30, titlefontsmall, black)
		    Font.Draw ("The rules are simple.", 10, maxy - 60, titlefontsmall, black)
		    Font.Draw ("Try to skydive for as long as you can by avoiding clouds.", 10, maxy - 90, titlefontsmall, black)
		    Font.Draw ("The longer you skydive, the more points you aquire", 10, maxy - 120, titlefontsmall, black)
		    Font.Draw ("and the faster you fall!", 10, maxy - 140, titlefontsmall, black)
		    Font.Draw ("Use A & D or Arrow Keys to move Left and Right!", 10, maxy - 180, titlefontsmall, black)
		    Font.Draw ("Press the Space Bar to return to Home", 0, 10, titlefontsmall, black)

		    % Exits User's Manual when the Space Bar is pressed
		    loop
			if hasch then
			    exitChar := getchar
			end if
			exit when exitChar = ' '
			gamestart := false
			exitKey := true
		    end loop

		elsif mousex > 175 and mousex < 325 then % If this button is pressed, it opens the Character Customizer
		    setscreen ("offscreenonly")
		    loop
			if colorselector > 5 then
			    colorselector := 1
			end if
			if colorselector < 1 then
			    colorselector := 5
			end if
			if colorselector = 1 then %User selected parachute to customize
			    drawline (characterX - 70, characterY + 110, characterX - 70, characterY + 120, black)
			    drawline (characterX - 70, characterY + 120, characterX - 50, characterY + 115, black)
			    drawline (characterX - 50, characterY + 115, characterX - 70, characterY + 110, black)
			    drawfill (characterX - 68, characterY + 112, black, black)
			    if charactercolKey = KEY_RIGHT_ARROW or charactercolKey = KEY_LEFT_ARROW then      %If user presses the left or right arrow keys, it changes the colour
				if charactercolKey = KEY_RIGHT_ARROW then
				    parachutecolorpicker := parachutecolorpicker + 1     %Increases colour value
				    if parachutecolorpicker > 4 then
					parachutecolorpicker := 1
				    end if
				end if
				if charactercolKey = KEY_LEFT_ARROW then
				    parachutecolorpicker := parachutecolorpicker - 1     %Decreases colour value
				    if parachutecolorpicker < 1 then
					parachutecolorpicker := 4
				    end if
				end if
				case parachutecolorpicker of %Based on current int value from user input, the parachute is assigned a colour
				    label 1 :
					parachuteCol := red
				    label 2 :
					parachuteCol := blue
				    label 3 :
					parachuteCol := green
				    label 4 :
					parachuteCol := yellow
				end case
				charactercolKey := 'a'
			    end if
			end if

			if colorselector = 2 then %User selected helmet to customize
			    drawline (characterX - 70, characterY + 65, characterX - 70, characterY + 75, black)
			    drawline (characterX - 70, characterY + 75, characterX - 50, characterY + 70, black)
			    drawline (characterX - 50, characterY + 70, characterX - 70, characterY + 65, black)
			    drawfill (characterX - 68, characterY + 67, black, black)
			    if charactercolKey = KEY_RIGHT_ARROW or charactercolKey = KEY_LEFT_ARROW then   %User can change colour of helmet by using left and right arrow keys
				if charactercolKey = KEY_RIGHT_ARROW then
				    helmetcolorpicker := helmetcolorpicker + 1
				    if charactercolKey = KEY_RIGHT_ARROW and helmetcolorpicker > 4 then
					helmetcolorpicker := 1
				    end if
				end if

				if charactercolKey = KEY_LEFT_ARROW then
				    helmetcolorpicker := helmetcolorpicker - 1
				    if charactercolKey = KEY_LEFT_ARROW and helmetcolorpicker < 1 then
					helmetcolorpicker := 4
				    end if
				end if

				case helmetcolorpicker of %helmet colour is changed based on suer choice
				    label 1 :
					helmetCol := 115
				    label 2 :
					helmetCol := blue
				    label 3 :
					helmetCol := green
				    label 4 :
					helmetCol := yellow
				end case
				charactercolKey := 'a'
			    end if
			end if

			if colorselector = 3 then %User selected to change colour of the shirt
			    drawline (characterX - 70, characterY + 20, characterX - 70, characterY + 30, black)
			    drawline (characterX - 70, characterY + 30, characterX - 50, characterY + 25, black)
			    drawline (characterX - 50, characterY + 25, characterX - 70, characterY + 20, black)
			    drawfill (characterX - 68, characterY + 22, black, black)
			    if charactercolKey = KEY_RIGHT_ARROW or charactercolKey = KEY_LEFT_ARROW then     %User changes colour with left and right arrow keys
				if charactercolKey = KEY_RIGHT_ARROW then
				    shirtcolorpicker := shirtcolorpicker + 1
				    if shirtcolorpicker > 4 then
					shirtcolorpicker := 1
				    end if
				end if
				if charactercolKey = KEY_LEFT_ARROW then
				    shirtcolorpicker := shirtcolorpicker - 1
				    if shirtcolorpicker < 1 then
					shirtcolorpicker := 4
				    end if
				end if
				case shirtcolorpicker of %Shirt changes colour based on user choice
				    label 1 :
					shirtCol := 244
				    label 2 :
					shirtCol := blue
				    label 3 :
					shirtCol := green
				    label 4 :
					shirtCol := yellow
				end case
				charactercolKey := 'a'
			    end if
			end if

			if colorselector = 4 then %User selected to change the pants colour
			    drawline (characterX - 70, characterY + 10, characterX - 70, characterY + 20, black)
			    drawline (characterX - 70, characterY + 20, characterX - 50, characterY + 15, black)
			    drawline (characterX - 50, characterY + 15, characterX - 70, characterY + 10, black)
			    drawfill (characterX - 68, characterY + 12, black, black)
			    if charactercolKey = KEY_RIGHT_ARROW or charactercolKey = KEY_LEFT_ARROW then     %Changes colour with left and right arrow keys
				if charactercolKey = KEY_RIGHT_ARROW then
				    pantscolorpicker := pantscolorpicker + 1
				    if pantscolorpicker > 4 then
					pantscolorpicker := 1
				    end if
				end if
				if charactercolKey = KEY_LEFT_ARROW then
				    pantscolorpicker := pantscolorpicker - 1
				    if pantscolorpicker < 1 then
					pantscolorpicker := 4
				    end if
				end if
				case pantscolorpicker of %Changes colour of pants based on user choice
				    label 1 :
					pantsCol := 114
				    label 2 :
					pantsCol := blue
				    label 3 :
					pantsCol := green
				    label 4 :
					pantsCol := yellow
				end case
				charactercolKey := 'a'
			    end if
			end if

			if colorselector = 5 then %User selected to change the shoes colour
			    drawline (characterX - 70, characterY, characterX - 70, characterY + 10, black)
			    drawline (characterX - 70, characterY + 10, characterX - 50, characterY + 5, black)
			    drawline (characterX - 50, characterY + 5, characterX - 70, characterY, black)
			    drawfill (characterX - 68, characterY + 2, black, black)
			    if charactercolKey = KEY_RIGHT_ARROW or charactercolKey = KEY_LEFT_ARROW then     %User can change colour with left and right arrow keys
				if charactercolKey = KEY_RIGHT_ARROW then
				    shoescolorpicker := shoescolorpicker + 1
				    if shoescolorpicker > 4 then
					shoescolorpicker := 1
				    end if
				end if
				if charactercolKey = KEY_LEFT_ARROW then
				    shoescolorpicker := shoescolorpicker - 1
				    if shoescolorpicker < 1 then
					shoescolorpicker := 4
				    end if
				end if
				case shoescolorpicker of %The shoes change colour based on user choice
				    label 1 :
					shoesCol := 114
				    label 2 :
					shoesCol := blue
				    label 3 :
					shoesCol := green
				    label 4 :
					shoesCol := yellow
				end case
				charactercolKey := 'a'
			    end if
			end if

			if hasch then
			    charactercolKey := getchar     %Get user input for selecting area to change colour and changing colour of specific area
			end if

			if charactercolKey = KEY_DOWN_ARROW and colorselector < 6 then
			    colorselector := colorselector + 1
			    charactercolKey := 'a'
			elsif charactercolKey = KEY_UP_ARROW and colorselector > 0 then
			    colorselector := colorselector - 1
			    charactercolKey := 'a'
			elsif charactercolKey = KEY_UP_ARROW and colorselector > 5 then
			    colorselector := 1
			    charactercolKey := 'a'
			end if
			exit when charactercolKey = ' '

			% Draws Cloud
			drawfilloval (maxx - 220, 600, 300, 150, white)
			drawfilloval (maxx - 420, 620, 100, 100, white)
			drawfilloval (maxx - 120, 550, 100, 100, white)
			drawfilloval (maxx - 230, 520, 100, 100, white)
			drawfilloval (maxx - 370, 550, 100, 100, white)

			% Writes Instructions
			Font.Draw ("Press the Space Bar to to return to Home", 0, 10, titlefontsmall, black)
			Font.Draw ("Use the up and down arrow keys to select a different area!", 5, maxy - 30, titlefontsmall, black)
			Font.Draw ("Use the left and right arrow keys to change the colour!", 15, maxy - 60, titlefontsmall, black)

			% Draws Character
			drawParachute (parachuteCol)
			drawCharacter (helmetCol, shirtCol, pantsCol, shoesCol)
			View.Update
			delay (10)
			cls
		    end loop
		    setscreen ("offscreenonly")
		    View.Update
		    gamestart := false
		    exitKey := true

		elsif mousex > 335 and mousex < 485 then    % If this button is pressed, it opens the Creator's Biographies
		    cls

		    % Biography Page
		    drawfilloval (maxx div 2, maxy - 30, 125, 30, white)
		    drawfilloval (150, maxy - 205, 145, 145, white)
		    drawfilloval (maxx - 150, 175, 145, 145, white)
		    Font.Draw ("Press the Space Bar to to return to Home", 0, 10, titlefontsmall, black)
		    Font.Draw ("ABOUT THE CREATORS", 135, maxy - 35, titlefontsmall, black)
		    Font.Draw ("Noah Black", 100, maxy - 85, titlefontsmall, black)
		    drawbox (98, maxy - 90, 198, maxy - 70, black)
		    Font.Draw ("Adam Pralat", maxx - 205, 295, titlefontsmall, black)
		    drawbox (maxx - 207, 292, maxx - 98, 310, black)

		    % Noah Black Biography
		    Font.Draw ("Noah Black began", 60, maxy - 105, titlefontsmall, black)
		    Font.Draw ("programming in the fall of", 35, maxy - 125, titlefontsmall, black)
		    Font.Draw ("2019 by learning the Turing", 25, maxy - 145, titlefontsmall, black)
		    Font.Draw ("programming language. Since", 15, maxy - 165, titlefontsmall, black)
		    Font.Draw ("   then, he has developed many", 5, maxy - 185, titlefontsmall, black)
		    Font.Draw ("different varieties of games and", 5, maxy - 205, titlefontsmall, black)
		    Font.Draw ("other types of programs. He plans", 5, maxy - 225, titlefontsmall, black)
		    Font.Draw ("to keep learning programming", 15, maxy - 245, titlefontsmall, black)
		    Font.Draw ("   in many different areas.", 25, maxy - 265, titlefontsmall, black)

		    % Adam Pralat Biography
		    Font.Draw ("Adam Pralat is a", maxx - 245, 277, titlefontsmall, black)
		    Font.Draw ("student at North Toronto.", maxx - 265, 260, titlefontsmall, black)
		    Font.Draw ("He enjoys doing math and", maxx - 275, 240, titlefontsmall, black)
		    Font.Draw (" computer programming. In his", maxx - 285, 220, titlefontsmall, black)
		    Font.Draw ("spare time, Adam likes to watch", maxx - 295, 200, titlefontsmall, black)
		    Font.Draw ("movies, play games, and spend", maxx - 295, 180, titlefontsmall, black)
		    Font.Draw ("time with friends. Adam is always", maxx - 295, 160, titlefontsmall, black)
		    Font.Draw ("trying improve his coding", maxx - 285, 140, titlefontsmall, black)
		    Font.Draw ("skills, and looks forwards to", maxx - 275, 120, titlefontsmall, black)
		    Font.Draw ("learning new commands and", maxx - 265, 100, titlefontsmall, black)
		    Font.Draw ("programming languages.", maxx - 245, 80, titlefontsmall, black)

		    % Exits Biographies when the Space Bar is pressed
		    loop
			if hasch then
			    exitChar := getchar
			end if
			exit when exitChar = ' '
			gamestart := false
			exitKey := true
		    end loop

		end if
	    elsif mousex > 145 and mousex < 355 and mousey > 165 and mousey < 260 then  % If this button is pressed, the game starts
		gamestart := true
		exitKey := true
	    end if
	    exit when exitKey = true    % Only exits Homescreen after a button has been pressed
	end loop
    end if

    resetVars
    %:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:| Gameplay |:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:|:

    if gamestart = true then    % If the play button was pressed, the game starts
	setscreen ("offscreenonly")

	% Dropping animation
	characterY := maxy
	loop
	    drawParachute (parachuteCol)
	    drawCharacter (helmetCol, shirtCol, pantsCol, shoesCol)
	    exit when characterY = maxy div 2
	    characterY := characterY - 1
	    View.Update
	    delay (5)
	    cls
	end loop

	loop
	    put "Current Score:", cScore, "\nHigh Score:", hScore   % Displays Scores

	    % Draws Character
	    drawParachute (parachuteCol)
	    drawCharacter (helmetCol, shirtCol, pantsCol, shoesCol)

	    % Moves character left or right based on user input (unless next to border)
	    Input.KeyDown (key)
	    if key ('a') or key (KEY_LEFT_ARROW) and characterX > 20 then
		characterX := characterX - 1
	    elsif key ('d') or key (KEY_RIGHT_ARROW) and characterX < maxx - 20 then
		characterX := characterX + 1
	    end if

	    % Generates Obstacle(clouds) Gap
	    if not drawing then
		randint (obstacleX, 50, maxx - 50)
		obstacleY := 0
		drawing := true
	    end if

	    % Draws and Moves Obstacle (clouds)
	    if drawing then
		for i : 70 .. 800 by 20
		    drawfilloval (obstacleX - i, obstacleY, 20, 20, white)
		    drawfilloval (obstacleX + i, obstacleY, 20, 20, white)
		end for
		obstacleY := obstacleY + 1
	    end if

	    % If obstacle reaches top, it creates a new obstacle at the bottom
	    if obstacleY > maxy then
		drawing := false
	    end if

	    % Exits when the character hits the obstacle
	    exit when characterY < obstacleY + 20 and characterY > obstacleY - 150 and sqrt ((characterX - obstacleX) ** 2) > 25

	    cScore := cScore + 1
	    speed := 6 - cScore div 2000    % Game speeds up every 2000 points

	    View.Update
	    delay (speed)
	    cls
	end loop

	if cScore > hScore then
	    hScore := cScore    % Remembers Highest Score
	end if

	%============================== Losing Screen =================================================================================

	% Explosion Drawing
	for decreasing i : 150 .. 1
	    for a : 1 .. i
		randint (explosionX, -i, i)
		randint (explosionY, -i, i)
		if sqrt (explosionX ** 2 + explosionY ** 2) < i then    % Makes Explosion circular
		    drawfilloval (characterX + explosionX, characterY + 20 + explosionY, 30, 30, 44 - i div 35)
		end if
	    end for
	end for

	setscreen ("nooffscreenonly")
	delay (1000)
	Font.Draw ("GAME OVER", maxx div 2 - 210, characterY, titlefont, black)

	% Draws buttons
	drawfillbox (50, 50, 230, 150, black)
	drawfillbox (60, 60, 220, 140, 29)
	Font.Draw ("PLAY AGAIN", 80, 90, titlefontsmall, black)
	drawfillbox (maxx - 50, 50, maxx - 230, 150, black)
	drawfillbox (maxx - 60, 60, maxx - 220, 140, 29)
	Font.Draw ("BACK TO HOME", maxx - 218, 90, titlefontsmall, black)

	loop
	    Mouse.ButtonWait ("down", mousex, mousey, button, ud)   % Waits for User to click
	    if mousey > 50 and mousey < 150 then
		if mousex > 50 and mousex < 230 then % Clicking this button starts the game again
		    gamestart := true
		    exitKey := true
		elsif mousex < maxx - 50 and mousex > maxx - 230 then % Clicking this button takes you to the homescreen
		    gamestart := false
		    exitKey := true
		end if
	    end if
	    exit when exitKey = true    % Exits when a button is pressed
	end loop
    end if
    cls
end loop
