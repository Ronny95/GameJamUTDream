STRICT = true
DEBUG = true

require 'zoetrope'

local app = {}

RealMap = Map:extend
{
	spriteHeight = 32,
	spriteWidth = 32,

	sprites = { 
		[1] = Tile:new{ 
			width = 32, 
			height = 32,
			image = 'spritesheet.png',
			imageOffset = { x = 0, y = 0 } 
		},
		[2] = Tile:new{
			width = 32,
			height = 32,
			image = 'spritesheet.png',
			imageOffset = { x = 32, y = 0}
		}	 
	},
	
	onNew = function(self)
		self:loadMap('realmap.txt')
	end
}

DreamMap = Map:extend
{
	spriteHeight = 32,
	spriteWidth = 32,

	onNew = function(self)
		self:loadMap('dreammap.txt')
	end
}

Player = Animation:extend
{
	width = 32,
	height = 32,
	image = 'spritesheet.png',
	imageOffset = { x = 0, y= 0 },
	sequences = 
	{
		right = { frames = { 1 }, fps = 10},
		left = { frames = { 1 }, fps = 10},
		up = { frames = { 1 }, fps = 10},
		down = { frames = { 1 }, fps = 10}
	},

	onUpdate = function(self, elapsed)
		if the.keys:pressed('a') then
			self.velocity.x = -100
			self.velocity.y = 0
			self.play('left')
		elseif the.keys:pressed('e') or the.keys:pressed('d') then
			self.velocity.x = 100
			self.velocity.y = 0
			self.play('right')
		elseif the.keys:pressed(',') or the.keys:pressed('w') then
			self.velocity.y = -100
			self.velocity.x = 0
			self.play('up')
		elseif the.keys:pressed('o') or the.keys:pressed('s') then
			self.velocity.y = 100
			self.velocity.x = 0
			self.play('down')	
		else
			self.velocity.x = 0
			self.velocity.y = 0
		end
		if (self.x < 0 and the.keys:pressed('a')) or (self.x >  the.app.width and the.keys:pressed('d')) then
            self.velocity.x = 0
        end
        if (self.y < 0 and the.keys:pressed('w')) or (self.y > the.app.height and the.keys:pressed('s')) then
            self.velocity.y = 0
        end
    end,

	onCollide = function(self, other)
		-- doesn't do anything yet
	end,
}

the.app = App:new
{
	onRun = function (self)
		self.player = Player:new{ x = 0, y = 0 }
		self:add(self.player)
		self.map = RealMap:new{}
		self:add(self.map)
	end,

	onUpdate = function(self)
		-- doesn't do anything yet
	end
}



