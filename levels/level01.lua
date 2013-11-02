
--[[

textures = {
	[1 ] = { 0,  0}, -- Bed Top
	[2 ] = { 0,  1}, -- Bed Bottom
	
	[3 ] = { 1,  0}, -- Spikes Blue
	[4 ] = { 3,  1}, -- Spikes Red
	
	[5 ] = { 1,  1}, -- Boulder
	[6 ] = { 6,  1}, -- Hole
	[7 ] = { 7,  1}, -- Pressure Plate
	
	[8 ] = { 2,  1}, -- Star
	[9 ] = { 4,  1}, -- Sign
	[10] = { 5,  1}, -- Lantern
	
	[11] = { 4,  0}, -- Player Forward
	[12] = { 5,  0}, -- Player Left
	[13] = { 6,  0}, -- Player Right
	[14] = { 7,  0}, -- Player Back
	
	[998] = {3, 0}, -- Dev Ghost Tile Blue
	[999] = {2, 0}, -- Dev Real  Tile Grey
}

]]

MAPW = 7
MAPH = 7

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

player = Player:new(3, 6, textures[ 5], realMap , false)
ghost  = Player:new(0, 0, textures[10], ghostMap, true )

makeTile(Tile,  3,  2,  1,  true,  true,  true, false).activate = changeForm
makeTile(Tile,  3,  3,  2,  true,  true,  true, false).activate = changeForm

makeTile(Tile,  3,  0,  8, false,  true, false, false).playerOn = function(ply)
	if ply.isGhost then
		loadLevel("levels/level02.lua")
	end
end

