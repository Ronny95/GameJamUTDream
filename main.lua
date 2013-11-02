


include = function(file)
	love.filesystem.load(file)()
end

include("constants.lua")
include("texture.lua")
include("tile.lua")
include("menu.lua")

--------------------------------------------------

local Layer = {}
Layer.__index = Map
Layer.tiles = {}

function Layer:setTile(x, y, tile)
	tiles[x+","+y] = id
end
function Layer:getTile(x, y)
	return tiles[x+","+y]
end

--------------------------------------------------

local tile

function love.load()
	loadTileset("assets/images/tileset.png")
	tile = newTile(0, 0, textures[1])
end

function love.update(delta)
	tile:update(delta)
end

function love.draw()
	tile:draw()
end

function love.mousepressed(x, y, button)
	if button == "l" then
		tile:move(0)
	end
end



