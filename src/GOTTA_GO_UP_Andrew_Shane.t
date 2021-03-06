%GOTTA GO UP -FINAL PROJECT
%ANDREW WU AND SHANE CHEN

%SCREEN SIZE FOR GAME
View.Set ("graphics:1000;700,position:center;center,nobuttonbar,title:Gotta Go Up")

%DECLARATIONS:
%fonts:
var font1 : int := Font.New ("Comic Sans MS:40:Bold")
var font2 : int := Font.New ("Arial:36:bold")
var font3 : int := Font.New ("Arial:24:bold")
var fontTITLE : int := Font.New ("Times New Roman:56:bold")
%for buttonwait
var x, y, notused1, notused2 : int
%counters:
var counter : int := 0
var score : int := 0
var scoreAdder : int
%for key input
var chars : array char of boolean
%x/y values for jump proc
var jx : int := 300
var jy : int := 700
var gy : int := 675
var yy : int := 0
var speed : int := 7
%SPRITES:
%menu background:
var background : int := Pic.FileNew ("Pics/Background.bmp")
%character:
var picC : int := Pic.FileNew ("Pics/Character_Left.bmp")
var picD : int := Pic.FileNew ("Pics/Character_Right.bmp")
picC := Pic.Scale (picC, 150, 100)
picD := Pic.Scale (picD, 150, 100)
var spriteC : int := Sprite.New (picC)
var spriteD : int := Sprite.New (picD)
%death counter
var death : int := 0
%color detection
var ColorPick : int := 12

/*draws background (grid paper)
 for menu and actual game*/
Pic.Draw (background, 0, 0, picMerge)
%title screen music
Music.PlayFileLoop ("Sounds/TitleMusic.mp3")

%menu
proc menu
    loop
	%buttons: "play", "how to play", "options"
	%title:
	Font.Draw ("Gotta   Go   Up!", 250, 650, fontTITLE, 2)
	%play:
	drawfillbox (298, 588, 706, 488, 46)
	Font.Draw ("PLAY", 430, 525, font1, black)
	%how to play:
	drawfillbox (298, 384, 706, 284, 46)
	Font.Draw ("HOW TO PLAY", 307, 315, font1, black)
	%options
	drawfillbox (298, 180, 706, 80, 46)
	Font.Draw ("OPTIONS", 365, 115, font1, black)
	%allows user to select a button
	buttonwait ("down", x, y, notused1, notused2)
	%if user clicks "PLAY" exit menu
	if x > 298 and x < 706 and y > 488 and y < 588 then
	    %stop menu music
	    Music.PlayFileStop
	    cls
	    exit
	    %INSTRUCTIONS SCREEN
	elsif x > 298 and x < 706 and y > 284 and y < 384 then
	    cls
	    Pic.Draw (background, 0, 0, picMerge)
	    %box for "instruction"
	    drawfillbox (345, 640, 710, 695, brightgreen)
	    Font.Draw ("INSTRUCTIONS", 350, 650, font2, black)
	    %box for actual instructions
	    drawfillbox (145, 230, 870, 540, brightgreen)
	    Font.Draw ("Try to jump onto the falling platforms", 160, 500, font3, black)
	    Font.Draw ("Use left/right arrows keys to move", 160, 450, font3, black)
	    Font.Draw ("You lose if your character hits the bottom", 160, 400, font3, black)
	    Font.Draw ("Touching mushrooms will give random effects", 160, 350, font3, black)
	    Font.Draw ("Stay at the top, you get 10x score", 160, 300, font3, black)
	    Font.Draw ("Reaching the top removes mushroom effects", 160, 250, font3, black)
	    %back to menu button
	    drawfillbox (40, 30, 200, 80, brightgreen)
	    Font.Draw ("BACK", 68, 43, font3, black)
	    loop
		buttonwait ("down", x, y, notused1, notused2)
		if x > 20 and x < 200 and y > 20 and y < 80 then
		    cls
		    Pic.Draw (background, 0, 0, picMerge)
		    exit
		end if
	    end loop
	    %OPTIONS SCREEN
	elsif x > 298 and x < 706 and y > 80 and y < 180 then
	    loop
		cls
		Pic.Draw (background, 0, 0, picMerge)
		%box for options
		drawfillbox (348, 640, 655, 690, brightgreen)
		Font.Draw ("OPTIONS", 380, 650, font2, black)
		drawfillbox (145, 127, 910, 540, brightgreen)
		%different platform color options in rectangles
		Font.Draw ("Platform color: ", 180, 500, font3, black)
		drawfillbox (450, 495, 490, 520, 12)
		drawfillbox (530, 495, 570, 520, 80)
		drawfillbox (610, 495, 650, 520, 11)
		drawfillbox (690, 495, 730, 520, 14)
		drawfillbox (770, 495, 810, 520, 54)
		drawfillbox (850, 495, 890, 520, 42)
		%a current rectangle to show currently selected color
		Font.Draw ("Current:", 180, 440, font3, black)
		drawfillbox (350, 440, 470, 465, ColorPick)
		%back to menu button
		drawfillbox (40, 30, 200, 80, brightgreen)
		Font.Draw ("BACK", 68, 43, font3, black)
		loop
		    buttonwait ("down", x, y, notused1, notused2)
		    if x > 20 and x < 200 and y > 20 and y < 80 then
			cls
			Pic.Draw (background, 0, 0, picMerge)
			exit
		    end if
		    %for platform color
		    if x > 450 and x < 490 and y > 495 and y < 520 then
			%red
			ColorPick := 12
			exit
		    elsif x > 530 and x < 570 and y > 495 and y < 520 then
			%purple
			ColorPick := 80
			exit
		    elsif x > 610 and x < 650 and y > 495 and y < 520 then
			%blue
			ColorPick := 11
			exit
		    elsif x > 690 and x < 730 and y > 495 and y < 520 then
			%yellow
			ColorPick := 14
			exit
		    elsif x > 770 and x < 810 and y > 495 and y < 520 then
			%darker blue
			ColorPick := 54
			exit
		    elsif x > 850 and x < 890 and y > 495 and y < 520 then
			%orange
			ColorPick := 42
			exit
		    end if
		end loop
		exit when x > 20 and x < 200 and y > 20 and y < 80
	    end loop
	end if
    end loop
end menu

%music for main game
process GameMusic
    Music.PlayFileLoop ("Sounds/GameMusic.mp3")
    if death = 1 then
	Music.PlayFileStop
    end if
end GameMusic

%sound for when user touches a mushroom
process SoundEffect
    Music.PlayFile ("Sounds/MushroomEffect.wav")
end SoundEffect

%creating platforms
process platform (px : int)
    var py : int := 800
    %random number to decide when the platform occurs
    var r : int := Rand.Int (1, 100)
    loop
	delay (20)
	%clears platform
	drawfillbox (px, py, px + 120, py + 20, 98)
	%clears fast mushroom
	drawfillarc (px + 40, py + 40, 20, 20, 0, 180, 98)
	drawfillbox (px + 35, py + 20, px + 46, py + 40, 98)
	%clears slow mushroom
	drawfillarc (px + 40, py + 40, 20, 20, 0, 180, 98)
	drawfillbox (px + 35, py + 20, px + 46, py + 40, 98)
	%lower hight
	py -= 2
	%draws platform
	drawfillbox (px, py, px + 120, py + 20, ColorPick)
	%occurence of fast mushroom
	if r > 1 and r < 10 then
	    drawfillarc (px + 40, py + 40, 20, 20, 0, 180, 37)
	    drawfillbox (px + 35, py + 20, px + 46, py + 40, 90)
	    %occurence for slow mushroom
	elsif r > 10 and r < 20 then
	    drawfillarc (px + 40, py + 40, 20, 20, 0, 180, 79)
	    drawfillbox (px + 35, py + 20, px + 46, py + 40, 24)
	end if
	View.Update
	%fast mushroom effects
	if whatdotcolor (jx, jy - 15) = 37 and Math.Distance (jx - 20, jy - 10, px, py) < 100 then
	    speed := 30
	    r := 0
	    fork SoundEffect
	end if
	%slow mushroom effects
	if whatdotcolor (jx, jy - 10) = 79 and Math.Distance (jx - 20, jy - 10, px, py) < 100 then
	    %inverse controls
	    speed := speed * (-1)
	    r := 0
	    fork SoundEffect
	end if
	exit when py < -140 or death = 1
	%when user touches the bottom of screen
	if jy < 20 then
	    cls
	    exit
	end if
    end loop
end platform

%algorithim for jumping
proc jump
    for angle : 0 .. 360 by 5
	%this is the starting/initial platform
	drawfillbox (0, gy, 650, gy + 50, ColorPick)
	%calculates score, x10 when user is above screen
	if jy > 700 then
	    scoreAdder := 10
	else
	    scoreAdder := 1
	end if
	score += scoreAdder
	%time it takes to for the next platform to be generated
	counter += 1
	if counter = 70 then
	    counter := 0
	    fork platform (Rand.Int (10, 500))
	end if
	%move right
	Input.KeyDown (chars)
	if chars (KEY_RIGHT_ARROW) then
	    Sprite.Hide (spriteC)
	    Sprite.Show (spriteD)
	    jx += speed
	end if
	%move left
	if chars (KEY_LEFT_ARROW) then
	    Sprite.Hide (spriteD)
	    Sprite.Show (spriteC)
	    jx -= speed
	end if
	%jump height
	if angle < 150 then
	    jy += 2 * (round (90 * sind (angle)) - round (90 * sind (angle - 5)))
	else
	%allows user to fall after jump
	    jy -= 15
	end if
	%detects platform collision on left side of sprite
	if whatdotcolor (jx - 20, jy - 10) = ColorPick and angle > 90 then
	    jump
	end if
	%detects platform collision on right side of sprite
	if whatdotcolor (jx + 20, jy - 10) = ColorPick and angle > 90 then
	    jump
	end if
	%exits procedure when user dies
	if jy < 10 then
	    jy := 0
	    exit
	end if
	%prevents sprite from going off screen
	if jx < 0 then
	    jx := 620
	elsif jx > 630 then
	    jx := 10
	end if
	%erase mushroom effects if user reaches top of screen
	if jy > 700 then
	    speed := 7
	end if
	%display/set position sprites
	Sprite.SetPosition (spriteC, jx, jy, true)
	Sprite.SetPosition (spriteD, jx, jy, true)
	%score number
	Font.Draw (intstr (score), 800, 640, font2, white)
	View.Update
	delay (20)
	%clears score number in order to show new score number, avoids giant white box made from overlapping numbers
	drawfillbox (800, 640, maxx, 700, black)
	%draws a white initial platform, used to animate
	drawfillbox (0, gy, 650, gy + 50, 98)
	gy -= 2
    end for
    %detects for death
    if jy < 0 then
	death += 1
    end if
end jump

%--------BEGIN-GAME-----------------%

%displays menu
menu

%once user click play:
fork GameMusic
%background
drawfillbox (0, 0, 1000, 700, 98)
Sprite.Show (spriteC)
%scoreboard
drawfillbox (650, 0, 1000, 700, black)
Font.Draw ("SCORE: ", 670, 640, font3, white)
jump

%loops game
loop
    Music.PlayFileStop
    %background
    drawfillbox (0, 0, 1000, 700, 98)
    %loser message
    delay (400)
    %background
    drawfillbox (0, 0, 1000, 700, 98)
    %score box
    drawfillbox (650, 0, 1000, 700, black)
    Font.Draw ("YOU DIED", 720, 450, font3, white)
    Font.Draw ("SCORE: ", 670, 400, font3, white)
    Font.Draw (intstr (score), 800, 400, font2, white)
    %loser music
    Music.PlayFile ("Sounds/loser.mp3")
    %buttons to prompt for another cycle or bac to menu
    Font.Draw ("Play Again?", 700, 300, font3, white)
    drawfillbox (680, 240, 760, 280, white)
    drawfillbox (800, 240, 880, 280, white)
    Font.Draw ("Yes", 685, 250, font3, black)
    Font.Draw ("No", 815, 250, font3, black)
    drawfillbox (660, 10, 750, 40, brightgreen)
    Font.Draw ("Menu", 665, 15, font3, black)
    loop
	buttonwait ("down", x, y, notused1, notused2)
	%"yes" button
	if x > 680 and x < 760 and y > 240 and y < 280 then
	    %reset death counter
	    death := 0
	    exit
	    %"no" button
	elsif x > 800 and x < 880 and y > 240 and y < 280 then
	    cls
	    Sprite.Free (spriteC)
	    Sprite.Free (spriteD)
	    %exit background
	    drawfillbox (0, 0, 1000, 700, 10)
	    Font.Draw ("THANKS FOR PLAYING", 240, 350, font2, black)
	    %menu button
	elsif x > 660 and x < 750 and y > 10 and y < 40 then
	    cls
	    Sprite.Hide (spriteC)
	    Sprite.Hide (spriteD)
	    Pic.Draw (background, 0, 0, picMerge)
	    Music.PlayFileLoop("Sounds/TitleMusic.mp3")
	    menu
	    %redraws character sprite when user exits menu
	    Sprite.Show (spriteC)
	    exit
	end if
    end loop
    %loop for resetting game so user can play again
    loop
	%redraw background
	drawfillbox (0, 0, 1000, 700, 98)
	%redraws scoreboard
	drawfillbox (650, 0, 1000, 700, black)
	Font.Draw ("SCORE: ", 670, 640, font3, white)
	%resets game
	score := 0
	jx := 300
	jy := 700
	gy := 675
	yy := 0
	fork GameMusic
	jump
	%exits when user dies
	exit when death = 1 or jy < 20
    end loop
end loop
