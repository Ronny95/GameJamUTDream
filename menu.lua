
function love.load()
   --hamster = love.graphics.newImage("hamster.png")
   X = love.graphics.getWidth()
   Y = love.graphics.getHeight()
   speed = 100
   s="START"
   mFont=love.graphics.newFont(40)
   tFont=love.graphics.newFont(60)
   twidth = tFont:getWidth(s)/2
   theight = tFont:getHeight(s)/2
   width = mFont:getWidth(s)/2
   height = mFont:getHeight(s)/2
   iwidth = mFont:getWidth("INSTRUCTIONS")/2
   iheight = mFont:getHeight("INSTRUCTIONS")/2
   ewidth = mFont:getWidth("QUIT")/2
   eheight = mFont:getHeight("QUIT")/2

   love.graphics.setFont(mFont)
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

function love.draw()
  -- love.graphics.draw(hamster, x, y)
  -- love.graphics.rectangle("fill", x/2 - 150, y/2, 300, 100)
    love.graphics.setColor(125,125,255)
    love.graphics.rectangle("fill",X/2-width,Y/2,width*2,height*2 )


    love.graphics.setColor(125,125,255)
    love.graphics.rectangle("fill",X/2-iwidth,Y/2+80,iwidth*2,iheight*2 )

    love.graphics.setColor(125,125,255)
    love.graphics.rectangle("fill",X/2-ewidth,Y/2+160,ewidth*2,eheight*2 )

    --Ugly button1
    if love.mouse.isDown("l") and (love.mouse.getX()>X/2-width) and (love.mouse.getX()<X/2+width) and (love.mouse.getY()>Y/2) and (love.mouse.getY()<Y/2 + height *2) then
   		love.event.quit()
	end
	if (love.mouse.getX()>X/2-width) and (love.mouse.getX()<X/2+width) and (love.mouse.getY()>Y/2) and (love.mouse.getY()<Y/2 + height *2) then
		love.graphics.setColor(150,100,200)
		love.graphics.rectangle("fill",X/2-width,Y/2,width*2,height*2 )
	end
	--Ugly button2
	if love.mouse.isDown("l") and (love.mouse.getX()>X/2-iwidth) and (love.mouse.getX()<X/2+iwidth) and (love.mouse.getY()>Y/2+80) and (love.mouse.getY()<Y/2+80 + iheight *2) then
   		love.event.quit()
	end
	if (love.mouse.getX()>X/2-iwidth) and (love.mouse.getX()<X/2+iwidth) and (love.mouse.getY()>Y/2 + 80) and (love.mouse.getY()<Y/2 + 80+ iheight *2) then
		love.graphics.setColor(150,100,200)
		love.graphics.rectangle("fill",X/2-iwidth,Y/2 +80 ,iwidth*2,iheight*2 )
		
	end
	--Ugly button3
	if love.mouse.isDown("l") and (love.mouse.getX()>X/2-ewidth) and (love.mouse.getX()<X/2+ewidth) and (love.mouse.getY()>Y/2+160) and (love.mouse.getY()<Y/2+160 + eheight *2) then
   		love.graphics.clear()
	end
	if (love.mouse.getX()>X/2-ewidth) and (love.mouse.getX()<X/2+ewidth) and (love.mouse.getY()>Y/2 + 160) and (love.mouse.getY()<Y/2 + 160+ eheight *2) then
		love.graphics.setColor(150,100,200)
		love.graphics.rectangle("fill",X/2-ewidth,Y/2+160,ewidth*2,eheight*2 )
	end

	love.graphics.setColor(255, 255,255)
	love.graphics.setFont(tFont)
    love.graphics.printf("PLACEHOLDER TITLE",X/2-width, Y/2 - 6*theight, 125, "center")
    love.graphics.setFont(mFont)
    love.graphics.printf(s, X/2-width,Y/2, 125,"center")
 	love.graphics.printf("INSTRUCTIONS", X/2-iwidth, Y/2 + 80, 295, "center")
 	love.graphics.printf("QUIT", X/2-ewidth, Y/2 +160, 95, "center")


  -- love.graphics.rectangle("fill", x/2-100, y/2-150, 300, 100)
end