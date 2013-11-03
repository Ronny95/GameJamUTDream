
include = function(file)
	love.filesystem.load(file)()
end

function table.copy(tbl)
	local copy = {}
	for k,v in pairs(tbl) do
		copy[k] = v
	end
	return copy
end

include("base.lua")
include("constants.lua")
include("texture.lua")
include("updates.lua")
include("tile.lua")
include("map.lua")
include("sound.lua")
include("menu.lua")


