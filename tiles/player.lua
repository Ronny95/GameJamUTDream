
Player = table.copy(Tile)
Player.__index = Player

-- Save the Tile update function
Player._update = Player.update
function Player:update(delta)
	-- Call the super update
	self:_update(delta)
	
	if not self.move_dir then
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

-- Initializer.
Player._init = Player.init
function Player:init(...)
	Player:_init(...)
	addUpdateTile(self)
end

-- Garbage Collection
function Player:__gc()
	removeUpdateTile(self)
end
