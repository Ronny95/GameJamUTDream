


include = function(file)
	love.filesystem.load(file)()
end

function table.copy(tbl)
	local copy = {}
	for k,v in pairs(tbl) do
		copy[k] = v
	end
	return copy
end

include("base.lua")
include("constants.lua")
include("texture.lua")
include("updates.lua")
include("tile.lua")
include("map.lua")


--include("menu.lua")

--------------------------------------------------

local player
local layer

function love.load()
	love.graphics.setMode(WINW, WINH, false, true, 0)
	
	loadTileset("assets/images/tileset.png")
	layer = Layer:new()
	
	player = Player:new(0, 0, textures[5])
	
	for x=1, MAPW do
		for y=1, MAPH do
			layer:setTile(x-1, y-1, Tile:new(x-1, y-1, textures[999]))
		end
	end
	
	
end

function love.update(delta)
	updateTiles(delta)
end

function love.draw()
	layer:draw()
	player:draw()
end




