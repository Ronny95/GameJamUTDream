
Layer = table.copy(Base)
Layer.__index = Layer
Layer.tiles = nil

function Layer:init()
	self.tiles = {}
end

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

--------------------------------------------------

Map = table.copy(Base)
Map.__index = Map
Map.layers = nil

function Map:init()
	self.layers = {}
end

function Map:setLayer(i, layer)
	self.layers[i] = layer
end
function Map:getLayer(i, layer)
	return self.layers[i]
end


