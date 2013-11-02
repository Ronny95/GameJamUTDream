
--[[
	works like #include
]]
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
include("sound.lua")


--include("menu.lua")

--------------------------------------------------

inGhost = false

player = nil
ghost = nil
realMap = nil
ghostMap = nil

local bg

function love.load()
	love.graphics.setMode(WINW, WINH, false, true, 0)

	love.audio.play(music['real'].audio)
	music['real'].audio:setVolume(music['real'].volume)
	
	bg = love.graphics.newImage("assets/images/dreambg.png")
	
	loadTileset("assets/images/tileset.png")
	
	realMap = Map:new()
	ghostMap = Map:new()
	
	local floor = Layer:new()
	--[[
		MAPW and MAPH need to be able to change to be different sizes depending
		on the level
	]]
	for x=1, MAPW do
		for y=1, MAPH do
			floor:setTile(x-1, y-1, Tile:new(x-1, y-1, textures[999], realMap))
		end
	end
	realMap:setLayer(1, floor)
	realMap:setLayer(2, Layer:new())
	
	ghostMap:setLayer(1, floor)
	ghostMap:setLayer(2, Layer:new())
	
	ghostMap:setTile(5, 5, 2, realMap:createTile(5, 5, 2, textures[6]):setSolid(true, false)).playerOn = 
		function(_, ply) 
			if ply.isGhost then 
				print("You float over the hole!") 
			end
		end
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
	
end

function love.update(delta)
	updateTiles(delta)
	updateSound()
end

local step = 0
local function doGhostEffects()
	step = step + 1

	love.graphics.setColor(HSL((step/40)%6, math.sin(step/30*3)*0.3+0.7, math.sin(step/30)*0.3+0.7, 90))
	love.graphics.draw(bg, 0, 0)
end


function love.draw()
	
	local aply = getActivePlayer()
	
	love.graphics.push()
	love.graphics.translate(-aply:getX()*TILEW-aply.moveX + WINW/2, -aply:getY()*TILEH-aply.moveY + WINH/2)
	
	love.graphics.setColor(255, 255, 255, 255)
	if not inGhost then
		realMap:draw()
		player:draw()
	else
		ghostMap:draw()
		player:draw()
		ghost:draw()
	end
	
	-- HUD
	
	love.graphics.pop()
	if inGhost then
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

function changeForm()
	if ghostMap:solidAt(player:getX(), player:getY(), true) then 
		return false 
	end

	inGhost = not inGhost
	if inGhost then
		ghost:setLocation(player:getX(), player:getY())
	end
	return true
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	if key == "f" and inGhost then
		changeForm()
	end
	if key == "e" then
		getActivePlayer():use()
	end
end

function HSL(hue, saturation, lightness, alpha)
    if hue < 0 or hue > 360 then
        return 0, 0, 0, alpha
    end
    if saturation < 0 or saturation > 1 then
        return 0, 0, 0, alpha
    end
    if lightness < 0 or lightness > 1 then
        return 0, 0, 0, alpha
    end
    local chroma = (1 - math.abs(2 * lightness - 1)) * saturation
    local h = hue/60
    local x =(1 - math.abs(h % 2 - 1)) * chroma
    local r, g, b = 0, 0, 0
    if h < 1 then
        r,g,b=chroma,x,0
    elseif h < 2 then
        r,b,g=x,chroma,0
    elseif h < 3 then
        r,g,b=0,chroma,x
    elseif h < 4 then
        r,g,b=0,x,chroma
    elseif h < 5 then
        r,g,b=x,0,chroma
    else
        r,g,b=chroma,0,x
    end
    local m = lightness - chroma/2
    return (r+m)*255,(g+m)*255,(b+m)*255,alpha
end

function updateSound()
	if music['real'].audio:isLooping() and inGhost then
		fadeSound(music['real'].audio)
	elseif music['dream'].audio:isLooping() and inGhost then
		fadeSound(music['dream'].audio)
	end
end

