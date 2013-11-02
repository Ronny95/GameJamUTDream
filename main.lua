-- Tutorial 1: Hamster Ball
-- Add an image to the game and move it around using 
-- the arrow keys.
-- compatible with löve 0.6.0 and up

local textures = 
{
	["player"] = "player.png",
	["tile_dev"] = "tile.png"
}

local x
local y
local speed

function love.load_graphics()
	for k, v in pairs(textures) do
		textures[k] = love.graphics.newImage(v)
	end
end

function love.load()
	
	love.load_graphics()
	
	x = 50
	y = 50
	speed = 300
end

function love.update(dt)
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		x = x + (speed * dt)
	end
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		x = x - (speed * dt)
	end

	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		y = y + (speed * dt)
	end
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		y = y - (speed * dt)
	end
end

function love.draw()
	for i=0, 19 do
		for j=0, 19 do
			love.graphics.draw(textures.player, i*32, j*32)
		end
	end
	
	love.graphics.draw(textures.hamster, x, y)
	
end