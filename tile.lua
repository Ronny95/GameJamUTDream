--[[
	This class is an outline for Tiles in the game

	The constructor takes four parameters:
		grid x-coordinate (already scaled down by tile size)
		grid y-coordinate (also scaled down)
		texture - takes a texture that contains an image and a quad
			that can be rendered to the screen
]]

local Tile = {}
Tile.__index = Tile

Tile.x = 0
Tile.y = 0
Tile.texture = nil
Tile.move_dir = nil
Tile.moveX = 0
Tile.moveY = 0

function newTile(x, y, texture)
	local tile = setmetatable({}, Tile)
	tile.x = x
	tile.y = y
	tile.texture = texture

	return tile
end

function Tile:draw()
	self.texture:draw(self.x * TILEW + self.moveX, self.y * TILEH + self.moveY)
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
	if self.move_dir == 0 then
		self.moveX = self.moveX + MOVESCALE * delta
	elseif self.move_dir == 1 then
		self.moveY = self.moveY - MOVESCALE * delta
	elseif self.move_dir == 2 then
		self.moveX = self.moxe_x - MOVESCALE * delta
	elseif self.move_dir == 3 then
		self.moveY = self.moveY + MOVESCALE * delta
	end

	if self.moveX ~= 0 and self.moveX > TILEW and self.move_dir == 0 then
		self.moveX = 0
		self.x = self.x + 1
		self.move_dir = nil
	elseif self.moveX ~= 0 and self.moveX > TILEW and self.move_dir == 2 then
		self.moveX = 0
		self.x = self.x - 1
		self.move_dir = nil
	elseif self.moveY ~= 0 and self.moveY > TILEH and self.move_dir == 1 then
		self.moveY = 0
		self.y = self.y - 1
		self.move_dir = nil
	elseif self.moveY ~= 0 and self.moveY > TILEH and self.move_dir == 3 then
		self.moveY = 0
		self.y = self.y + 1
		self.move_dir = nil
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
		self.move_dir = math.floor(direction / 90 + 0.5)
	else
		self.move_dir = nil
	end
end


