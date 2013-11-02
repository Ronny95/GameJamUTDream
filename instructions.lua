IView = View:extend
{
	mFont=love.graphics.newFont(40)
	X = love.graphics.getWidth()/2
    Y = love.graphics.getHeight()/2
	love.graphics.printf("BLAH", X/2,Y/2,200,"center")
}