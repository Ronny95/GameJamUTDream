


include = function(file)
	love.filesystem.load(file)()
end

function table.copy(tbl)
	local copy = {}
	for k,v in pairs(tbl) do
		copy[k] = v
	end
	return copy
end

include("base.lua")
include("constants.lua")
include("texture.lua")
include("updates.lua")
include("tile.lua")
include("map.lua")


--include("menu.lua")

--------------------------------------------------

inGhost = false

player = nil
ghost = nil
realMap = nil
ghostMap = nil

function love.load()
	love.graphics.setMode(WINW, WINH, false, true, 0)
	
	loadTileset("assets/images/tileset.png")
	
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
	--[[
	local floor = Layer:new()
	for x=1, MAPW do
		for y=1, MAPH do
			floor:setTile(x-1, y-1, Tile:new(x-1, y-1, textures[998], ghostMap))
		end
	end]]
	ghostMap:setLayer(1, floor)
	ghostMap:setLayer(2, Layer:new())
	
	ghostMap:setTile(5, 5, 2, realMap:createTile(5, 5, 2, textures[6]):setSolid(true, false))
	ghostMap:setTile(3, 2, 2, realMap:createTile(3, 2, 2, textures[3]):setSolid(true, false))
	ghostMap:setTile(3, 3, 2, realMap:createTile(3, 3, 2, textures[3]):setSolid(true, false))
	ghostMap:createTile(6, 2, 2, textures[8]):setSolid(false, true)
	
	player = Player:new(0, 0, textures[ 5], realMap , false)
	ghost  = Player:new(0, 0, textures[10], ghostMap, true )
	
end



function love.update(delta)
	updateTiles(delta)
end

local function doGhostEffects()
	local s = 16
	for i=1, WINW/s do
		for j=1, WINH/s do
			local x = i-1
			local y = j-1
			
			love.graphics.setColor(80, 80, 200, math.random(40, 70))
			love.graphics.rectangle("fill", x*s, y*s, s, s)
		end
	end
end

function love.draw()
	
	love.graphics.setColor(255, 255, 255, 255)
	if not inGhost then
		realMap:draw()
		player:draw()
	else
		ghostMap:draw()
		player:draw()
		ghost:draw()
		
		doGhostEffects()
	end
end

function getActivePlayer()
	if not inGhost then
		return player
	else
		return ghost
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == "f" and not solidAt(player:getX(), player:getY(), true) then
		inGhost = not inGhost
		if inGhost then
			ghost:setLocation(player:getX(), player:getY())
		end
	end
	if key == "e" then
		getActivePlayer():use()
	end
end


