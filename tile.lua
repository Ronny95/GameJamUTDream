--[[
	This class is an outline for Tiles in the game

	The constructor takes four parameters:
		grid x-coordinate (already scaled down by tile size)
		grid y-coordinate (also scaled down)
		texture - takes a texture that contains an image and a quad
			that can be rendered to the screen
]]

Tile = table.copy(Base)
Tile.__index = Tile

Tile.x = 0
Tile.y = 0
Tile.texture = nil
Tile.map = nil
Tile.solidReal  = false
Tile.solidGhost = false
Tile.isGhost = false

-- Move animation
Tile.moveDir = nil
Tile.faceDir = nil
Tile.moveX = 0
Tile.moveY = 0

function Tile:init(x, y, texture, map, isGhost)
	self.x = x
	self.y = y
	self.texture = texture
	self.map = map
	self.isGhost = isGhost or false
	
	self.faceDir = {x=1, y=0}
end

function Tile:draw()
	self.texture:draw(self.x * TILEW + self.moveX, self.y * TILEH + self.moveY)
end

function Tile:setLocation(x, y)
	self.x = x
	self.y = y
	
	return self
end

function Tile:getX()
	return self.x
end

function Tile:getY()
	return self.y
end

function Tile:getMap()
	return self.map
end

function Tile:setSolid(realSolid, ghostSolid)
	self.solidReal  = realSolid
	self.solidGhost = ghostSolid
	
	return self
end

function Tile:isRealSolid()
	return self.solidReal
end

function Tile:isGhostSolid()
	return self.solidGhost
end

--[[
	params:
		delta - the time passed between previous call to update
			and this one

	this makes calls to texture:draw depending on whether or not
	the tile should be moving and stops its movement after it has
	moved one tile
]]
function Tile:update(delta)
	if self.moveDir then
		self.moveX = self.moveX + self.moveDir.x * MOVESCALE * delta
		self.moveY = self.moveY + self.moveDir.y * MOVESCALE * delta
		
		if self.moveX * self.moveDir.x > 0 or self.moveY * self.moveDir.y > 0 then
			self.moveX = 0
			self.moveY = 0
			self.moveDir = nil
			removeUpdateTile(self)
		end
	end
end

--[[
	params:
		direction - 0 is right, 90 is up, 180 is left, 270 is down

	All values passed in will be rounded to the nearest of the four 
	directions up

	Ex: 135 will round up to 180 rather than down to 90
]]
function Tile:move(direction)
	if direction <= 360 then
		direction = math.floor(direction / 90 + 0.5)
		addUpdateTile(self)
		
		local moveDir = {x=0, y=0}
		if direction == 0 then
			moveDir.x = 1
		elseif direction == 1 then
			moveDir.y = -1
		elseif direction == 2 then
			moveDir.x = -1
		else
			moveDir.y = 1
		end
		
		self.faceDir = moveDir
		
		local newX = self.x+moveDir.x
		local newY = self.y+moveDir.y
		
		if self.map:solidAt(newX, newY, self.isGhost) then
			return false
		end
		
		self.x = newX
		self.y = newY
		self.moveX = -moveDir.x*TILEW
		self.moveY = -moveDir.y*TILEH
		self.moveDir = moveDir
		return true
	else
		self.moveDir = nil
		removeUpdateTile(self)
		return false
	end
end

function Tile:activate(player) end
function Tile:playerOn(player) end

include("tiles/player.lua")


