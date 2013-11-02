
MAPW = 34
MAPH = 24

realMap = Map:new()
ghostMap = Map:new()

local floor = Layer:new()

for x=1, MAPW do
	for y=1, MAPH do
		floor:setTile(x-1, y-1, Tile:new(x-1, y-1, textures[999], realMap))
	end
end
realMap:setLayer(1, floor)
realMap:setLayer(2, Layer:new())

ghostMap:setLayer(1, floor)
ghostMap:setLayer(2, Layer:new())

local function makeTile(class, x, y, tex, real, ghost, sreal, sghost, ...)
	local map
	if real then
		map = realMap
	else
		map = ghostMap
	end
	local tile = class:new(x, y, textures[tex], map, ghost or false, ...)
	tile:setSolid(sreal or false, sghost or false)
	if real then
		realMap:setTile(x, y, 2, tile)
	end
	if ghost then
		ghostMap:setTile(x, y, 2, tile)
	end
	return tile
end

makeTile(Tile, 5, 5, 6, true, true, true, false)


--[[
ghostMap:setTile(5, 5, 2, realMap:createTile(5, 5, 2, textures[6]):setSolid(true, false)).playerOn = 
	function(_, ply) 
		if ply.isGhost then 
			print("You float over the hole!") 
		end
	end]]
ghostMap:setTile(3, 2, 2, realMap:createTile(3, 2, 2, textures[1]):setSolid(true, false)).activate = 
	function() 
		changeForm() 
	end
ghostMap:setTile(3, 3, 2, realMap:createTile(3, 3, 2, textures[2]):setSolid(true, false)).activate = 
	function() 
		changeForm() 
	end
ghostMap:createTile(6, 2, 2, textures[8]):setSolid(false, true)

local boulder = Boulder:new(1, 2)
ghostMap:setTile(1, 2, 2, realMap:setTile(1, 2, 2, boulder))

ghostMap:setTile(5, 0, 2, realMap:createTile(5, 0, 2, textures[998]):setSolid(true, true))

player = Player:new(1, 1, textures[ 5], realMap , false)
ghost  = Player:new(0, 0, textures[10], ghostMap, true )
