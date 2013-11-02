
Player = table.copy(Tile)
Player.__index = Player

Player.isGhost = false
Player.faceDir = 0

-- Save the Tile update function
Player._update = Player.update
function Player:update(delta)
	
	if  (not self.isGhost and inGhost) or
		(self.isGhost and not inGhost) then
		self.moveX = 0
		self.moveY = 0
		return false
	end
	
	-- Call the super update
	self:_update(delta)
	
	if not self.moveDir then
		if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			self:move(90)
		elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
			self:move(180)
		elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
			self:move(270)
		elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
			self:move(0)
		end
	end
end

Player._move = Player.move
function Player:move(direction)
	if not self.move_dir then
		self.faceDir = math.floor(direction / 90 + 0.5)
	end
	self:_move(direction)
end

function Player:use()
	local x = self.x + self.faceDir.x
	local y = self.y + self.faceDir.y
	
	activate(x, y, self)
end

-- Initializer.
Player._init = Player.init
function Player:init(...)
	self:_init(...)
	
	addUpdateTile(self)
end

-- Garbage Collection
function Player:__gc()
	removeUpdateTile(self)
end
