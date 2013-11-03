
Boulder = table.copy(Tile)
Boulder.__index = Boulder

Boulder._init = Boulder.init
function Boulder:init(x, y)
	self:_init(x, y, textures["boulder"], realMap)
	self:setSolid(true, false)
end

function Boulder:playerPush(player, vector, direction)
	if self.moveDir then return end
	
	local newX = self:getX() + vector.x
	local newY = self:getY() + vector.y
	
	if self.map:solidAt(newX, newY, false) then
		return false
	end
	
	self:move(direction)
	return true
end
