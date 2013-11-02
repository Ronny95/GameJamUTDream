
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
}

--------------------------------------------------

local Texture = {}
Texture.__index = Texture
Texture.image = nil
Texture.quad = nil

function Texture:draw(x, y)
	love.graphics.drawq(self.image, self.quad, x, y)
end

function newTexture(image, x, y)
	local image = image
	local quad = love.graphics.newQuad(x*TILEW, y*TILEH, TILEW, TILEH, image:getWidth(), image:getHeight())
	
	local texture = setmetatable({}, Texture)
	texture.image = image
	texture.quad = quad
	
	return texture
end

--------------------------------------------------

function loadTileset(path)
	local img = love.graphics.newImage(path)
	
	for k,v in pairs(textures) do
		textures[k] = newTexture(img, v[1], v[2])
	end
end
