--[[
	This class is an outline for Tiles in the game

	Tile is an outline that is meant to be extended
	in other parts of the game
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

--[[
	Initializes a new Tile

	params:
		x - grid x-coordinate
		y - grid y-coordinate
		texture - the texture to draw on the specified tile
		map - the map that the tile belongs to
		isGhost - whether or not the Tile belongs to the GhostWorld
]]
function Tile:init(x, y, texture, map, isGhost)
	self.x = x
	self.y = y
	self.texture = texture
	self.map = map
	self.isGhost = isGhost or false
	
	self.faceDir = {x=1, y=0}
end

--[[
	draws the Tile on the screen by invoking the draw function of the texture
	component of the Tile
]]
function Tile:draw()
	if self.texture then
		self.texture:draw(self.x * TILEW + self.moveX, self.y * TILEH + self.moveY)
	end
end

--[[
	updates the location of the Tile

	params:
		x - x-location to update the tile to
		y - y-location to update the tile to
]]
function Tile:setLocation(x, y)
	self.x = x
	self.y = y
	
	return self
end

--[[
	The following functions return various components of the Tile for use 
	elsewhere in the game
]]
function Tile:getX()
	return self.x
end

function Tile:getY()
	return self.y
end

function Tile:getMap()
	return self.map
end

--[[
	Sets whether the Tile is solid or not in the real world and ghost world

	params:
		realSolid - a value of "true" or "false" that tells you whether or not
			the Tile is solid in the real world
		ghostSolid - the same as realSolid but for the ghost world
]]
function Tile:setSolid(realSolid, ghostSolid)
	self.solidReal  = realSolid
	self.solidGhost = ghostSolid
	
	return self
end

--[[
	returns "true" or "false" depending on whether or not the Tile is solid
	in the real world
]]
function Tile:isRealSolid()
	return self.solidReal
end

--[[
	returns "true" or "false" depending on whether or not the Tile is solid
	in the ghost world
]]
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
	Causes a Tile to move in a certain direction by one tile

	params:
		direction - 0 is right, 90 is up, 180 is left, 270 is down

	All values passed in will be rounded to the nearest of the four 
	directions up

	Ex: 135 will round up to 180 rather than down to 90
]]
function Tile:move(direction, notInMap)
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
		
		local newX
		local newY 

		-- keeps the moveable objects from leaving the map area
		if (self.x > 0 and moveDir.x == -1) or (self.x < MAPW - 1 and moveDir.x == 1) then
			newX = self.x + moveDir.x
		else
			newX = self.x
		end

		if (self.y > 0 and moveDir.y == -1) or (self.y < MAPH - 1 and moveDir.y == 1) then
			newY = self.y + moveDir.y
		else
			newY = self.y
		end
		
		local solidTile = self.map:solidAt(newX, newY, self.isGhost)
		if solidTile then
			return false, solidTile
		end
		
		if not notInMap then
			self.map:removeTile(self.x, self.y, 2)
			self.map:setTile(newX, newY, 2, self)
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

--[[
	activate and playerOn are extendable functions that can be overwritten
]]
function Tile:activate(player) 

end

function Tile:playerOn(player)
	
end

function Tile:playerPush(player) 
	return false 
end

include("tiles/player.lua")
include("tiles/boulder.lua")
include("tiles/lever.lua")


