


include = function(file)
	love.filesystem.load(file)()
end

include("constants.lua")
include("texture.lua")
include("updates.lua")
include("tile.lua")
include("map.lua")


--include("menu.lua")

--------------------------------------------------

local layer

function love.load()
	love.graphics.setMode(WINW, WINH, false, true, 0)
	
	loadTileset("assets/images/tileset.png")
	layer = newLayer()
	
	for x=1, MAPW do
		for y=1, MAPH do
			if y%2 == 1 then
				layer:setTile(x-1, y-1, newTile(x-1, y-1, textures[1]))
			else
				layer:setTile(x-1, y-1, newTile(x-1, y-1, textures[2]))
			end
		end
	end
	
	
end

function love.update(delta)
	
end

function love.draw()
	layer:draw()
end




