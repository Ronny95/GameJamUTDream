--[[
	This class is an outline for Tiles in the game

	The constructor takes four parameters:
		grid x-coordinate (already scaled down by tile size)
		grid y-coordinate (also scaled down)
		texture - takes a texture that contains an image and a quad
			that can be rendered to the screen
]]

-- a scaling constant for move speed
MOVESCALE = 1

local Tile = {}

Tile.x = 0
Tile.y = 0
Tile.texture = nil
Tile.move_dir = nil
Tile.move_x = 0
Tile.move_y = 0

function newTile(x, y, texture)
	local tile = setmetatable({}, Tile)
	tile.x = x
	tile.y = y
	tile.texture = texture

	return tile
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
	if self.move_dir == nil then
		self.texture:draw(self.x, self.y)
	elseif self.move_dir == 0 then
		self.texture:draw(self.x + self.move_x, self.y)
		self.move_x += MOVESCALE * delta
	elseif self.move_dir == 1 then
		self.texture:draw(self.x, self.y - self.move_y)
		self.move_y += MOVESCALE * delta
	elseif self.move_dir == 2 then
		self.texture:draw(self.x - self.move_x, self.y)
		self.move_x += MOVESCALE * delta
	elseif self.move_dir == 3 then
		self.texture:draw(self.x, self.y + self.move_y)
		self.move_y += MOVESCALE * delta
	end

	if self.move_x ~= 0 and self.move_x > 32 and self.move_dir == 0 then
		self.move_x = 0
		self.x += 32
		self.move_dir = nil
	elseif self.move_x ~= 0 and self.move_x > 32 and self.move_dir == 2 then
		self.move_x = 0
		self.x -= 32
		self.move_dir = nil
	elseif self.move_y ~= 0 and self.move_y > 32 and self.move_dir == 1 then
		self.move_y = 0
		self.y -= 32
		self.move_dir = nil
	elseif self.move_y ~= 0 and self.move_y > 32 and self.move_dir == 3 then
		self.move_y = 0
		self.y += 32
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
		self.move_dir = math.round(direction / 90)
	else
		move_dir = nil
	end
end


