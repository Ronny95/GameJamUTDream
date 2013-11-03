

MAPW = 10
MAPH = 10

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
	local light = makeTile(Lever,  x,  y, 10,  true,  true,  true, false):setTextures(textures["lantern"], textures["star"]):setState(false)
	
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

player = Player:new(9, 4, -1, realMap , false)
ghost  = Player:new(0, 0, -1, ghostMap, true )

-- Bed
makeTile(Tile,  7,  4,  "bed_top",  true,  true,  true, false).activate = changeForm
makeTile(Tile,  7,  5,  "bed_bottom",  true,  true,  true, false).activate = changeForm

-- Spikes
makeTile(Tile,  6,  0,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  5,  1,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  6,  2,  "spikes_blue",  true,  true,  true, false)
-- Lantern
makeLight(6, 1)

-- Spikes
makeTile(Tile,  5,  3,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  5,  4,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  5,  5,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  5,  6,  "spikes_blue",  true,  true,  true, false)

-- Spikes
makeTile(Tile,  6,  7,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  5,  8,  "spikes_blue",  true,  true,  true, false)
makeTile(Tile,  6,  9,  "spikes_blue",  true,  true,  true, false)
-- Lantern
makeLight(6, 8)

-- End
makeTile(Tile,  0,  4,  "star",  true, false, false, false).playerOn = function(ply)
	if not ply.isGhost then
		loadLevel("levels/level10.lua")
	end
end

