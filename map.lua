
local Layer = {}
Layer.__index = Layer
Layer.tiles = nil

function Layer:setTile(x, y, tile)
	self.tiles[x+y*MAPW] = tile
end
function Layer:getTile(x, y)
	return self.tiles[x+y*MAPW]
end
function Layer:draw()
	for _,v in pairs(self.tiles) do
		v:draw()
	end
end

function newLayer()
	local layer = setmetatable({}, Layer)
	layer.tiles = {}
	
	return layer
end
