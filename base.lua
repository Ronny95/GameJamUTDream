
Base = {}
Base.__index = Base

-- Initializer
function Base:init() end

-- Object Constructor
function Base:new(...)
	local instance = setmetatable({}, self)
	instance:init(...)
	return instance
end