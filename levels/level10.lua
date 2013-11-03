
MAPW = 24
MAPH = 34

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


local wa = "wall_a"
local t = true
local f = false


local function makeBed(x, y)
	makeTile(Tile,  x, y  ,  "bed_top", t, f, t, f).activate = changeForm
	makeTile(Tile,  x, y+1,  "bed_bottom", t, f, t, f).activate = changeForm
end

player = Player:new(11, 33, -1, realMap , false)
ghost  = Player:new( 0,  0, -1, ghostMap, true )

----------------------------------------------------------------------------------------------------

local redSpikes = {
	{ 8, 29},
	{ 7, 29},
	{ 7, 28},
	{ 7, 27},
	{ 7, 26},
	{ 7, 25},
	{ 9, 25},
	
	{17, 23},
	{17, 24},
	{18, 24},
	{19, 24},
	{20, 24},
	{21, 24},
	{22, 24},
	{22, 23},
}

local blueSpikes = {
	{14, 29},
	{15, 29},
	{15, 28},
	{15, 27},
	{15, 26},
	{15, 25},
	{13, 25},
	
	{ 6, 23},
	{ 6, 24},
	{ 5, 24},
	{ 4, 24},
	{ 3, 24},
	{ 2, 24},
	{ 1, 24},
	{ 1, 23},
}

makeTile(Lever, 8, 28, -1, f, t, f, t):setTextures(textures["lever_red_off"], textures["lever_red_on"]):setChangeState(function(self, state)
	for _,cord in pairs(redSpikes) do
		if state then
			makeTile(Tile, cord[1], cord[2], "spikes_red", t, f, t, f)
		else
			realMap:removeTile(cord[1], cord[2], 2)
		end
	end
end):setState(true)
makeTile(Lever, 14, 28, -1, f, t, f, t):setTextures(textures["lever_blue_off"], textures["lever_blue_on"]):setChangeState(function(self, state)
	for _,cord in pairs(blueSpikes) do
		if state then
			makeTile(Tile, cord[1], cord[2], "spikes_blue", t, f, t, f)
		else
			realMap:removeTile(cord[1], cord[2], 2)
		end
	end
end):setState(true)
makeTile(Lever, 11, 28, -1, f, t, f, t):setTextures(textures["lever_blue_off"], textures["lever_blue_on"]):setChangeState(function(self, state)
	if state then
		makeTile(Tile, 9, 27, "spikes_blue", t, f, t, f)
		realMap:removeTile(13, 27, 2)
	else
		makeTile(Tile, 13, 27, "spikes_blue", t, f, t, f)
		realMap:removeTile(9, 27, 2)
	end
end):setState(true)

makeTile(Tile, 14, 33, wa, t, f, t, f)
makeTile(Tile, 14, 32, wa, t, f, t, f)
makeTile(Tile, 14, 31, wa, t, f, t, f)
makeTile(Tile, 14, 30, wa, t, f, t, f)
makeTile(Tile, 13, 30, wa, t, f, t, f)
makeTile(Tile, 13, 29, wa, t, f, t, f)
--makeTile(Tile, 13, 28, wa, t, f, t, f)
makeTile(Tile, 12, 28, wa, t, f, t, f)

makeTile(Boulder, 12, 30, -1, t, f, t, f)
makeTile(Boulder, 11, 30, -1, t, f, t, f)
makeTile(Boulder, 10, 30, -1, t, f, t, f)

makeTile(Tile,   8, 33, wa, t, f, t, f)
makeTile(Tile,   8, 32, wa, t, f, t, f)
makeTile(Tile,   8, 31, wa, t, f, t, f)
makeTile(Tile,   8, 30, wa, t, f, t, f)
makeTile(Tile,   9, 30, wa, t, f, t, f)
makeTile(Tile,   9, 29, wa, t, f, t, f)
makeTile(Tile,   9, 28, wa, t, f, t, f)
makeTile(Tile,  10, 28, wa, t, f, t, f)

makeBed(11, 25)
--makeTile(Tile,  11, 25,  1, t, f, t, f).activate = changeForm
--makeTile(Tile,  11, 26,  2, t, f, t, f).activate = changeForm

makeTile(Tile,  10, 26, wa, t, f, t, f)
makeTile(Tile,  10, 25, wa, t, f, t, f)
makeTile(Tile,  10, 24, wa, t, f, t, f)
makeTile(Tile,  10, 23, wa, t, f, t, f)

makeTile(Tile,  11, 24, wa, t, f, t, f)
makeTile(Tile,  11, 23, wa, t, f, t, f)

makeTile(Tile,  12, 26, wa, t, f, t, f)
makeTile(Tile,  12, 25, wa, t, f, t, f)
makeTile(Tile,  12, 24, wa, t, f, t, f)
makeTile(Tile,  12, 23, wa, t, f, t, f)


makeTile(Tile,   7, 29, wa, f, t, f, t)
makeTile(Tile,   7, 28, wa, f, t, f, t)
makeTile(Tile,   7, 27, wa, f, t, f, t)
makeTile(Tile,   7, 26, wa, f, t, f, t)
makeTile(Tile,   7, 25, wa, f, t, f, t)
makeTile(Tile,   8, 25, wa, f, t, f, t)
makeTile(Tile,   9, 25, wa, f, t, f, t)
makeTile(Tile,   9, 26, wa, f, t, f, t)
makeTile(Tile,   9, 27, wa, f, t, f, t)
makeTile(Tile,   9, 28, wa, f, t, f, t)
makeTile(Tile,   9, 29, wa, f, t, f, t)
makeTile(Tile,   8, 29, wa, f, t, f, t)

makeTile(Tile,   7+6, 29, wa, f, t, f, t)
makeTile(Tile,   7+6, 28, wa, f, t, f, t)
makeTile(Tile,   7+6, 27, wa, f, t, f, t)
makeTile(Tile,   7+6, 26, wa, f, t, f, t)
makeTile(Tile,   7+6, 25, wa, f, t, f, t)
makeTile(Tile,   8+6, 25, wa, f, t, f, t)
makeTile(Tile,   9+6, 25, wa, f, t, f, t)
makeTile(Tile,   9+6, 26, wa, f, t, f, t)
makeTile(Tile,   9+6, 27, wa, f, t, f, t)
makeTile(Tile,   9+6, 28, wa, f, t, f, t)
makeTile(Tile,   9+6, 29, wa, f, t, f, t)
makeTile(Tile,   8+6, 29, wa, f, t, f, t)

for i=1, MAPW do
	makeTile(Tile, i-1, 22, wa, t, t, t, t)
end

realMap:removeTile( 3, 22, 2)
realMap:removeTile( 4, 22, 2)
realMap:removeTile(19, 22, 2)
realMap:removeTile(20, 22, 2)

makeBed( 8, 25)
makeBed(14, 25)

----------------------------------------------------------------------------------------------------

makeBed(11, 18)

for i=1, MAPW do
	makeTile(Tile, i-1, 16, wa, t, f, t, f)
end
for i=1, MAPW do
	makeTile(Tile, i-1, 14, wa, f, t, f, t)
end

realMap:removeTile( 3, 16, 2)
realMap:removeTile(19, 16, 2)
makeTile(Tile, 3, 17, wa, t, f, t, f)
makeTile(Tile, 19, 17, wa, t, f, t, f)


realMap:removeTile(11, 16, 2)
makeTile(Tile, 10, 17, wa, t, f, t, f)
makeTile(Tile, 11, 17, wa, t, f, t, f)
makeTile(Tile, 12, 17, wa, t, f, t, f)


makeLight(3, 18)
makeLight(19, 18)

----------------------------------------------------------------------------------------------------

-- End
makeTile(Tile,  0,  4,  8,  true, false, false, false).playerOn = function(ply)
	if not ply.isGhost then
		loadLevel("levels/level10.lua")
	end
end


