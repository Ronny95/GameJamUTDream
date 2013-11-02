
textures = {
	[1 ] = { 0,  0}, -- Bed Top
	[2 ] = { 0,  1}, -- Bed Bottom
	
	[3 ] = { 1,  0}, -- Spikes Blue
	[4 ] = { 3,  1}, -- Spikes Red
	
	[5 ] = { 1,  1}, -- Boulder
	[6 ] = { 6,  1}, -- Hole
	[7 ] = { 7,  1}, -- Pressure Plate
	
	[8 ] = { 2,  1}, -- Star
	[9 ] = { 4,  1}, -- Sign
	[10] = { 5,  1}, -- Lantern
	
	[11] = { 4,  0}, -- Player Forward
	[12] = { 5,  0}, -- Player Left
	[13] = { 6,  0}, -- Player Right
	[14] = { 7,  0}, -- Player Back
	
	[15] = { 6,  2},
	[16] = { 7,  2},
	
	[17] = { 4,  2},
	[18] = { 5,  2},
	
	[998] = {3, 0}, -- Dev Ghost Tile Blue
	[999] = {2, 0}, -- Dev Real  Tile Grey
}

--------------------------------------------------

Texture = table.copy(Base)
Texture.__index = Texture
Texture.image = nil
Texture.quad = nil

function Texture:init(image, x, y)
	local image = image
	local quad = love.graphics.newQuad(x*TILEW, y*TILEH, TILEW, TILEH, image:getWidth(), image:getHeight())
	
	self.image = image
	self.quad = quad
end

function Texture:draw(x, y)
	love.graphics.drawq(self.image, self.quad, x, y)
end

--------------------------------------------------

function loadTileset(path)
	local img = love.graphics.newImage(path)
	
	for k,v in pairs(textures) do
		textures[k] = Texture:new(img, v[1], v[2])
	end
end
