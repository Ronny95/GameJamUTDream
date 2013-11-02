Lever = table.copy(Tile)
Lever.__index = Lever

Lever.state = false
Lever.textureOn = nil
Lever.textureOff = nil

function Lever:toggle()
	self:setState(not self.state)
end

function Lever:setState(state)
	self.state = state
	
	if not self.state then
		self.texture = self.textureOff
	else
		self.texture = self.textureOn
	end
	
	self:changeState(state)
	
	return self
end

function Lever:setTextures(ton, toff)
	self.textureOn = ton
	self.textureOff = toff
	return self
end

function Lever:getState()
	return self.state
end

function Lever:activate()
	self:toggle()
end

function Lever:setChangeState(func)
	self.changeState = func
	return self
end

function Lever:changeState(state) end
