
Player = table.copy(Tile)
Player.__index = Player

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
		if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) and self.y > 0 then
			self:move(90)
		elseif (love.keyboard.isDown("a") or love.keyboard.isDown("left")) and self.x > 0 then
			self:move(180)
		elseif (love.keyboard.isDown("s") or love.keyboard.isDown("down")) and self.y < MAPH then
			self:move(270)
		elseif (love.keyboard.isDown("d") or love.keyboard.isDown("right")) and self.x < MAPW then
			self:move(0)
		end
	end
	
	-- TODO: Clean this up. Should be using a table instead of if, else, and elseifs.
	if inGhost then
		if self.faceDir.x > 0 then
			self.texture = textures["ghost_right"]
		elseif self.faceDir.x < 0 then
			self.texture = textures["ghost_left"]
		elseif self.faceDir.y > 0 then
			self.texture = textures["ghost_forward"]
		else
			self.texture = textures["ghost_back"]
		end
	else
		if self.faceDir.x > 0 then
			self.texture = textures["player_right"]
		elseif self.faceDir.x < 0 then
			self.texture = textures["player_left"]
		elseif self.faceDir.y > 0 then
			self.texture = textures["player_forward"]
		else
			self.texture = textures["player_back"]
		end
	end
end

Player._move = Player.move
function Player:move(direction)
	local moved, block = self:_move(direction, true)
	if moved then
		self.map:playerOn(self:getX(), self:getY(), self)
	elseif block then
		if block:playerPush(self, self.faceDir, direction) then
			self:_move(direction)
		end
	end
end

function Player:use()
	local x = self.x + self.faceDir.x
	local y = self.y + self.faceDir.y
	
	self.map:activate(x, y, self)
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
