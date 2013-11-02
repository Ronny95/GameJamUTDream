STRICT = true
DEBUG = true
require 'zoetrope'

local app = {}

function app:onRun()
	local obj = {}
	obj.width = 16
	obj.height = 16
	obj.x = (self.width-16)/2
	obj.y = (self.height-16)/2
	obj.fill = {0, 0, 255}
	obj.velocity = {}
	obj.velocity.rotation = math.pi/2
	
	self:add(Fill:new(obj))
end

the.app = App:new(app)
