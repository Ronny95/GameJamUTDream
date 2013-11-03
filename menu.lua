
local instructions
local instructions
local success
local x
local y
local speed
local s
local m
local t
local i
local twidth
local theight
local width
local height
local iwidth
local iheight
local ewidth
local eheight
local instructWidth

function love.load()
	
	instructions = false;
	instructionsText = "Controls \n\n Movement: ArrowKeys OR WASD \n Enter dream mode: E(Must be near a bed) \n Wake up:F \n  Quit:esc \n\n Instructions \n\n Solve puzzles and get to the star"
	success = love.graphics.setMode( 640, 640, false, false, 0 )
	x = love.graphics.getWidth()
	y = love.graphics.getHeight()
	speed = 100
	s="START"
	mFont=love.graphics.newFont(40)
	tFont=love.graphics.newFont(60)
	iFont=love.graphics.newFont(20)
	twidth = tFont:getWidth(s)/2
	theight = tFont:getHeight(s)/2
	width = mFont:getWidth(s)/2
	height = mFont:getHeight(s)/2
	iwidth = mFont:getWidth("INSTRUCTIONS")/2
	iheight = mFont:getHeight("INSTRUCTIONS")/2
	ewidth = mFont:getWidth("QUIT")/2
	eheight = mFont:getHeight("QUIT")/2
	instructWidth = iFont:getWidth(instructionsText)/2
	--love.graphics.setBackgroundColor(125,125,255)
	love.graphics.setFont(mFont)
	background = love.graphics.newImage("assets/images/dreambg.png")
	--music = love.audio.newSource("assets/audio/dream.mp3")
	--music:setLooping(true)
	--love.audio.play(music)
end

function love.mousepressed(x, y, button)
	--	love.graphics.printf("PRESSED", x/2-width,y/2, 125,"center")
	--if button==1 --[[and (x>x/2-width) and (x<x/2+width) and (y>y-height) and (y<y/2+height) ]]then
	--	love.event.quit()
	--end
end
function love.update(dt)
	if love.keyboard.isDown("right") then
		x = x + (speed * dt)
	end
	if love.keyboard.isDown("left") then
		x = x - (speed * dt)
	end

	if love.keyboard.isDown("down") then
		y = y + (speed * dt)
	end
	if love.keyboard.isDown("up") then
		y = y - (speed * dt)
	end
end

function love.draw()
	-- love.graphics.draw(hamster, x, y)
	-- love.graphics.rectangle("fill", x/2 - 150, y/2, 300, 100)
	for i = 0, love.graphics.getWidth() / background:getWidth() do
		for j = 0, love.graphics.getHeight() / background:getHeight() do
			love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
		end
	end
	if instructions==false then
		love.graphics.setColor(125,125,255)
		-- love.graphics.rectangle("fill",x/2-width,y/2,width*2,height*2 )


		love.graphics.setColor(125,125,255)
		-- love.graphics.rectangle("fill",x/2-iwidth,y/2+80,iwidth*2,iheight*2 )

		love.graphics.setColor(125,125,255)
		--  love.graphics.rectangle("fill",x/2-ewidth,y/2+160,ewidth*2,eheight*2 )

		--Ugly button1
		if love.mouse.isDown("l") and (love.mouse.getX()>x/2-width) and (love.mouse.getX()<x/2+width) and (love.mouse.getY()>y/2) and (love.mouse.getY()<y/2 + height *2) then
			include("game.lua")
		end
		if (love.mouse.getX()>x/2-width) and (love.mouse.getX()<x/2+width) and (love.mouse.getY()>y/2) and (love.mouse.getY()<y/2 + height *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",x/2-width,y/2,width*2,height*2 )
		end
		--Ugly button2
		if love.mouse.isDown("l") and (love.mouse.getX()>x/2-iwidth) and (love.mouse.getX()<x/2+iwidth) and (love.mouse.getY()>y/2+80) and (love.mouse.getY()<y/2+80 + iheight *2) then
			instructions=true
		end
		if (love.mouse.getX()>x/2-iwidth) and (love.mouse.getX()<x/2+iwidth) and (love.mouse.getY()>y/2 + 80) and (love.mouse.getY()<y/2 + 80+ iheight *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",x/2-iwidth,y/2 +80 ,iwidth*2,iheight*2 )
		end
		--Ugly button3
		if love.mouse.isDown("l") and (love.mouse.getX()>x/2-ewidth) and (love.mouse.getX()<x/2+ewidth) and (love.mouse.getY()>y/2+160) and (love.mouse.getY()<y/2+160 + eheight *2) then
			love.event.quit()
		end
		if (love.mouse.getX()>x/2-ewidth) and (love.mouse.getX()<x/2+ewidth) and (love.mouse.getY()>y/2 + 160) and (love.mouse.getY()<y/2 + 160+ eheight *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",x/2-ewidth,y/2+160,ewidth*2,eheight*2 )
		end

		love.graphics.setColor(255, 255,255)
		love.graphics.setFont(tFont)
		love.graphics.printf("HALF-LIFE 3",x/2-width, y/2 - 6*theight, 125, "center")
		love.graphics.setFont(mFont)
		love.graphics.printf(s, x/2-width,y/2, 125,"center")
		love.graphics.printf("INSTRUCTIONS", x/2-iwidth, y/2 + 80, 295, "center")
		love.graphics.printf("QUIT", x/2-ewidth, y/2 +160, 95, "center")
	else
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(iFont)
		love.graphics.printf(instructionsText, 20, 50,640, "left")
		love.graphics.printf("Press backspace to return to the main menu", 20 ,y/1.2,600,"center")
		if love.keyboard.isDown("backspace") then
			instructions = false;
		end
	end

	-- love.graphics.rectangle("fill", x/2-100, y/2-150, 300, 100)
end