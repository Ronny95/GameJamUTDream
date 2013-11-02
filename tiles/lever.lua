Lever = table.copy(Tile)
Lever.__index = Lever

Lever.state = nil
Lever.spikes = {}



function Lever:init(spikes) 
	self.state = 0
	self.spikes = spikes
end

function Lever:toggle()
	self.state = (self.state + 1) % 2
end

function Lever:activate()
	self:toggle()

end
