
function love.load()
   --hamster = love.graphics.newImage("hamster.png")
   instructions = false;
   instructionsText = "Controls \n\n Movement: ArrowKeys OR WASD \n Enter dream mode: E(Must be near a bed) \n Wake up:F \n  Quit:esc \n\n Instructions \n\n Solve puzzles and get to the star"
   success = love.graphics.setMode( 640, 640, false, false, 0 )
   X = love.graphics.getWidth()
   Y = love.graphics.getHeight()
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
   music = love.audio.newSource("assets/audio/dream.mp3")
   music:setLooping(true)
   love.audio.play(music)
end

function love.mousepressed(x, y, button)
--	love.graphics.printf("PRESSED", X/2-width,Y/2, 125,"center")
	--if button==1 --[[and (x>X/2-width) and (x<X/2+width) and (y>Y-height) and (y<Y/2+height) ]]then
	--	love.event.quit()
	--end
end
function love.update(dt)
   if love.keyboard.isDown("right") then
      X = X + (speed * dt)
   end
   if love.keyboard.isDown("left") then
      X = X - (speed * dt)
   end

   if love.keyboard.isDown("down") then
      Y = Y + (speed * dt)
   end
   if love.keyboard.isDown("up") then
      Y = Y - (speed * dt)
   end
end

function HSL(h, s, l)
   if s == 0 then return l,l,l end
   h, s, l = h/256*6, s/255, l/255
   local c = (1-math.abs(2*l-1))*s
   local x = (1-math.abs(h%2-1))*c
   local m,r,g,b = (l-.5*c), 0,0,0
   if h < 1     then r,g,b = c,x,0
   elseif h < 2 then r,g,b = x,c,0
   elseif h < 3 then r,g,b = 0,c,x
   elseif h < 4 then r,g,b = 0,x,c
   elseif h < 5 then r,g,b = x,0,c
   else              r,g,b = c,0,x
   end
   return math.ceil((r+m)*256),math.ceil((g+m)*256),math.ceil((b+m)*256)
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
	   -- love.graphics.rectangle("fill",X/2-width,Y/2,width*2,height*2 )


	    love.graphics.setColor(125,125,255)
	   -- love.graphics.rectangle("fill",X/2-iwidth,Y/2+80,iwidth*2,iheight*2 )

	    love.graphics.setColor(125,125,255)
	  --  love.graphics.rectangle("fill",X/2-ewidth,Y/2+160,ewidth*2,eheight*2 )

	    --Ugly button1
	    if love.mouse.isDown("l") and (love.mouse.getX()>X/2-width) and (love.mouse.getX()<X/2+width) and (love.mouse.getY()>Y/2) and (love.mouse.getY()<Y/2 + height *2) then
	   		love.event.quit()
		end
		if (love.mouse.getX()>X/2-width) and (love.mouse.getX()<X/2+width) and (love.mouse.getY()>Y/2) and (love.mouse.getY()<Y/2 + height *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",X/2-width,Y/2,width*2,height*2 )
		end
		--Ugly button2
		if love.mouse.isDown("l") and (love.mouse.getX()>X/2-iwidth) and (love.mouse.getX()<X/2+iwidth) and (love.mouse.getY()>Y/2+80) and (love.mouse.getY()<Y/2+80 + iheight *2) then
	   		instructions=true;
		end
		if (love.mouse.getX()>X/2-iwidth) and (love.mouse.getX()<X/2+iwidth) and (love.mouse.getY()>Y/2 + 80) and (love.mouse.getY()<Y/2 + 80+ iheight *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",X/2-iwidth,Y/2 +80 ,iwidth*2,iheight*2 )
		end
		--Ugly button3
		if love.mouse.isDown("l") and (love.mouse.getX()>X/2-ewidth) and (love.mouse.getX()<X/2+ewidth) and (love.mouse.getY()>Y/2+160) and (love.mouse.getY()<Y/2+160 + eheight *2) then
	   		love.event.quit()
		end
		if (love.mouse.getX()>X/2-ewidth) and (love.mouse.getX()<X/2+ewidth) and (love.mouse.getY()>Y/2 + 160) and (love.mouse.getY()<Y/2 + 160+ eheight *2) then
			love.graphics.setColor(244,61,217)
			love.graphics.rectangle("fill",X/2-ewidth,Y/2+160,ewidth*2,eheight*2 )
		end

		love.graphics.setColor(255, 255,255)
		love.graphics.setFont(tFont)
	    love.graphics.printf("PLACEHOLDER TITLE",X/2-width, Y/2 - 6*theight, 125, "center")
	    love.graphics.setFont(mFont)
	    love.graphics.printf(s, X/2-width,Y/2, 125,"center")
	 	love.graphics.printf("INSTRUCTIONS", X/2-iwidth, Y/2 + 80, 295, "center")
	 	love.graphics.printf("QUIT", X/2-ewidth, Y/2 +160, 95, "center")
	else
		love.graphics.setColor(255,255,255)
		love.graphics.setFont(iFont)
		love.graphics.printf(instructionsText, 20, 50,640, "left")
		love.graphics.printf("Press backspace to return to the main menu", 20 ,Y/1.2,600,"center")
		if love.keyboard.isDown("backspace") then
			instructions = false;
		end
	end

  -- love.graphics.rectangle("fill", x/2-100, y/2-150, 300, 100)
end