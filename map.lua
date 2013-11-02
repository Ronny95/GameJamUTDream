
Layer = table.copy(Base)
Layer.__index = Layer
Layer.tiles = nil

function Layer:init()
	self.tiles = {}
end

function Layer:setTile(x, y, tile)
	self.tiles[x+y*MAPW] = tile
end
function Layer:createTile(x, y, texture, map)
	local tile = Tile:new(x, y, texture, map)
	self.tiles[x+y*MAPW] = tile
	return tile
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

function Map:draw()
	for _,layer in pairs(self.layers) do
		layer:draw()
	end
end

function Map:solidAt(x, y, inGhost)
	for _,layer in pairs(self.layers) do
		if not inGhost then
			local tile = layer:getTile(x, y)
			if tile and tile:isRealSolid() then
				return tile
			end
		else
			local tile = layer:getTile(x, y)
			if tile and tile:isGhostSolid() then
				return tile
			end
		end
	end
	return false
end

function Map:removeTile(x, y, l)
	self.layers[l]:setTile(x, y, nil)
end

function Map:setTile(x, y, l, tile)
	self.layers[l]:setTile(x, y, tile)
	return tile
end
function Map:createTile(x, y, l, texture)
	return self.layers[l]:createTile(x, y, texture, self)
end

function Map:activate(x, y, player)
	for _,layer in pairs(self.layers) do
		local tile = layer:getTile(x, y)
		if tile then
			tile:activate(player)
		end
	end
end
function Map:playerOn(x, y, player)
	for _,layer in pairs(self.layers) do
		local tile = layer:getTile(x, y)
		if tile then
			tile:playerOn(player)
		end
	end
end

--------------------------------------------------
--[[
-- After all we only have 2 maps.

function solidAt(x, y, inGhost)
	return realMap:solidAt(x, y, inGhost) or ghostMap:solidAt(x, y, inGhost)
end
function activate(x, y, player)
	if not player.isGhost then
		realMap:activate(x, y, player)
	else
		ghostMap:activate(x, y, player)
	end
end
]]
