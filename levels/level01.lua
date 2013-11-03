
MAPW = 7
MAPH = 7

realMap = Map:new()
ghostMap = Map:new()

local floor = Layer:new()

for x=1, MAPW do
	for y=1, MAPH do
		floor:setTile(x-1, y-1, Tile:new(x-1, y-1, textures["floor_a"], realMap))
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

player = Player:new(3, 6, -1, realMap , false)
ghost  = Player:new(0, 0, -1, ghostMap, true )

makeTile(Tile,  3,  2,  "bed_top",  true,  true,  true, false).activate = changeForm
makeTile(Tile,  3,  3,  "bed_bottom",  true,  true,  true, false).activate = changeForm

makeTile(Tile,  3,  0,  "star", false,  true, false, false).playerOn = function(ply)
	if ply.isGhost then
		loadLevel("levels/level02.lua")
	end
end

