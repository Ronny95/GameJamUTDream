
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

MAPW = 10
MAPH = 10

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
realMap:setLayer(3, Layer:new())

ghostMap:setLayer(1, floor)
ghostMap:setLayer(2, Layer:new())
ghostMap:setLayer(3, Layer:new())

local function makeTile(class, x, y, tex, real, ghost, sreal, sghost, layer)
	local map
	if real then
		map = realMap
	else
		map = ghostMap
	end
	--[[local vargs = {...}
	local args = {x, y, textures[tex], map, ghost or false}
	for _,v in ipairs(vargs)do
		table.insert(args, v)
	end]]
	local tile = class:new(x, y, textures[tex], map, ghost or false)
	tile:setSolid(sreal or false, sghost or false)
	if real then
		realMap:setTile(x, y, layer or 2, tile)
	end
	if ghost then
		ghostMap:setTile(x, y, layer or 2, tile)
	end
	return tile
end

local function makeLight(x, y)
	local light = makeTile(Lever,  x,  y, 10,  true,  true,  true, false):setTextures(textures[8], textures[10]):setState(false)
	
	local function lightf(ply)
		if inGhost and light:getState() then
			local x = ghost:getX()
			local y = ghost:getY()
			changeForm()
			player:setLocation(x, y)
		end
	end
	
	makeTile(Tile, x+0, y+0, -1, true, true, false, false, 3).playerOn = lightf
	
	makeTile(Tile, x+1, y+0, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+0, y+1, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x-1, y+0, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+0, y-1, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+1, y+1, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x-1, y-1, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+1, y-1, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x-1, y+1, -1, true, true, false, false, 3).playerOn = lightf
	
	makeTile(Tile, x+2, y+0, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+0, y+2, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x+0, y-2, -1, true, true, false, false, 3).playerOn = lightf
	makeTile(Tile, x-2, y+0, -1, true, true, false, false, 3).playerOn = lightf
	
	return light
end

player = Player:new(9, 4, textures[ 5], realMap , false)
ghost  = Player:new(0, 0, textures[10], ghostMap, true )

-- Bed
makeTile(Tile,  7,  4,  1,  true,  true,  true, false).activate = changeForm
makeTile(Tile,  7,  5,  2,  true,  true,  true, false).activate = changeForm

-- Spikes
makeTile(Tile,  6,  0,  3,  true,  true,  true, false)
makeTile(Tile,  5,  1,  3,  true,  true,  true, false)
makeTile(Tile,  6,  2,  3,  true,  true,  true, false)
-- Lantern
makeLight(6, 1)

-- Spikes
makeTile(Tile,  5,  3,  3,  true,  true,  true, false)
makeTile(Tile,  5,  4,  3,  true,  true,  true, false)
makeTile(Tile,  5,  5,  3,  true,  true,  true, false)
makeTile(Tile,  5,  6,  3,  true,  true,  true, false)

-- Spikes
makeTile(Tile,  6,  7,  3,  true,  true,  true, false)
makeTile(Tile,  5,  8,  3,  true,  true,  true, false)
makeTile(Tile,  6,  9,  3,  true,  true,  true, false)
-- Lantern
makeTile(Tile,  6,  8, 10,  true,  true,  true, false)

-- End
makeTile(Tile,  0,  4,  8,  true, false, false, false).playerOn = function(ply)
	if not ply.isGhost then
		loadLevel("levels/level10.lua")
	end
end

