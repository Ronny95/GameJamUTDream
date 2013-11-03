
-- Predefine all globals created by this class
-- TODO: Minimize globals by making textures local and add a function called texture.get(...) instead.
Texture = {}
texture = {}
textures = {}

local tileCoords = {}

table.insert(tileCoords, { 1,  1, "boulder"})
table.insert(tileCoords, { 6,  1, "hole"})
table.insert(tileCoords, { 7,  1, "pressure_plate"})
table.insert(tileCoords, { 2,  1, "star"})
table.insert(tileCoords, { 4,  1, "sign"})
table.insert(tileCoords, { 5,  1, "lantern"})

table.insert(tileCoords, { 0,  0, "bed_top"})
table.insert(tileCoords, { 0,  1, "bed_bottom"})

table.insert(tileCoords, { 1,  0, "spikes_blue"})
table.insert(tileCoords, { 3,  1, "spikes_red"})

table.insert(tileCoords, { 0,  3, "player_back"})
table.insert(tileCoords, { 1,  3, "player_forward"})
table.insert(tileCoords, { 2,  3, "player_right"})
table.insert(tileCoords, { 3,  3, "player_left"})

table.insert(tileCoords, { 0,  2, "ghost_back"})
table.insert(tileCoords, { 1,  2, "ghost_forward"})
table.insert(tileCoords, { 2,  2, "ghost_right"})
table.insert(tileCoords, { 3,  2, "ghost_left"})

table.insert(tileCoords, { 6,  2, "lever_red_off"})
table.insert(tileCoords, { 7,  2, "lever_red_on"})
table.insert(tileCoords, { 4,  2, "lever_blue_off"})
table.insert(tileCoords, { 5,  2, "lever_blue_on"})
table.insert(tileCoords, { 4,  2, "lever_teal_off"})
table.insert(tileCoords, { 5,  2, "lever_teal_on"})

table.insert(tileCoords, { 0,  4, "statue_blue_forward_top"})
table.insert(tileCoords, { 0,  5, "statue_blue_forward_bottom"})
table.insert(tileCoords, { 1,  4, "statue_blue_back_top"})
table.insert(tileCoords, { 1,  5, "statue_blue_back_bottom"})
table.insert(tileCoords, { 2,  4, "statue_blue_left_top"})
table.insert(tileCoords, { 2,  5, "statue_blue_left_bottom"})
table.insert(tileCoords, { 3,  4, "statue_blue_right_top"})
table.insert(tileCoords, { 3,  5, "statue_blue_right_bottom"})

table.insert(tileCoords, { 0,  6, "statue_orange_forward_top"})
table.insert(tileCoords, { 0,  7, "statue_orange_forward_bottom"})
table.insert(tileCoords, { 1,  6, "statue_orange_back_top"})
table.insert(tileCoords, { 1,  7, "statue_orange_back_bottom"})
table.insert(tileCoords, { 2,  6, "statue_orange_left_top"})
table.insert(tileCoords, { 2,  7, "statue_orange_left_bottom"})
table.insert(tileCoords, { 3,  6, "statue_orange_right_top"})
table.insert(tileCoords, { 3,  7, "statue_orange_right_bottom"})

table.insert(tileCoords, { 0,  8, "statue_green_forward_top"})
table.insert(tileCoords, { 0,  9, "statue_green_forward_bottom"})
table.insert(tileCoords, { 1,  8, "statue_green_back_top"})
table.insert(tileCoords, { 1,  9, "statue_green_back_bottom"})
table.insert(tileCoords, { 2,  8, "statue_green_left_top"})
table.insert(tileCoords, { 2,  9, "statue_green_left_bottom"})
table.insert(tileCoords, { 3,  8, "statue_green_right_top"})
table.insert(tileCoords, { 3,  9, "statue_green_right_bottom"})

table.insert(tileCoords, { 0, 10, "statue_red_forward_top"})
table.insert(tileCoords, { 0, 11, "statue_red_forward_bottom"})
table.insert(tileCoords, { 1, 10, "statue_red_back_top"})
table.insert(tileCoords, { 1, 11, "statue_red_back_bottom"})
table.insert(tileCoords, { 2, 10, "statue_red_left_top"})
table.insert(tileCoords, { 2, 11, "statue_red_left_bottom"})
table.insert(tileCoords, { 3, 10, "statue_red_right_top"})
table.insert(tileCoords, { 3, 11, "statue_red_right_bottom"})

table.insert(tileCoords, { 0, 12, "floor_a"})
table.insert(tileCoords, { 4, 12, "wall_a"})

table.insert(tileCoords, { 3,  0, "dev_wall"})
table.insert(tileCoords, { 2,  0, "dev_floor"})

----------------------------------------------------------------------------------------------------

Texture = table.copy(Base)
Texture.__index = Texture
Texture.image = nil
Texture.quad = nil

function Texture:init(image, x, y)
	
	local image = image
	self.image = image
	
	-- Not a tile texture
	if not x or not y then return end
	
	local quad = love.graphics.newQuad(
		x*TILEW, y*TILEH,
		TILEW, TILEH,
		image:getWidth(), image:getHeight())
	self.quad = quad
end

function Texture:draw(x, y)
	if self.quad then
		love.graphics.drawq(self.image, self.quad, x, y)
	else
		love.graphics.draw(self.image, x, y)
	end
end

----------------------------------------------------------------------------------------------------

function texture.loadTileset(path)
	local img = love.graphics.newImage(path)
	
	for k,v in pairs(tileCoords) do
		textures[v[3]] = Texture:new(img, v[1], v[2])
	end
end

function texture.loadTexture(name, path)
	local img = love.graphics.newImage(path)
	
	textures[name] = Texture:new(img)
end
