
inGhost = false

player = nil
ghost = nil
realMap = nil
ghostMap = nil

function loadLevel(lvl)
	inGhost = false
	include(lvl)
end

function love.update(delta)
	updateTiles(delta)
	updateSound()
end

local function doGhostEffects()
	love.graphics.setColor(255, 255, 255, 50)
	textures["dream_background"]:draw(0, 0)
end


function love.draw()
	
	local activePlayer = getActivePlayer()
	
	love.graphics.push()
	love.graphics.translate(
		-activePlayer:getX()*TILEW-activePlayer.moveX + WINW/2,
		-activePlayer:getY()*TILEH-activePlayer.moveY + WINH/2)
	
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
	if ghostMap and ghostMap:solidAt(player:getX(), player:getY(), true) then 
		return false 
	end

	inGhost = not inGhost
	if inGhost and ghost then
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

function updateSound()
	if (music['real'].audio:isLooping() or music['dream'].volume < 1.0) and inGhost then
		fadeSound(music['real'])
	elseif (music['dream'].audio:isLooping() or music['real'].volume < 1.0) and not inGhost then
		fadeSound(music['dream'])
	end
end

function love.load()
	love.graphics.setMode(WINW, WINH, false, true, 0)

	love.audio.play(music['real'].audio)
	music['real'].audio:setVolume(music['real'].volume)
	
	texture.loadTileset("assets/images/tileset.png")
	texture.loadTexture("dream_background", "assets/images/dreambg.png")

	loadLevel("levels/level01.lua")
end

-- TODO: This is here because this file is executed from menu.lua. This is the wrong way
-- to deal with initial loading.
love.load()
