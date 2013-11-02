


include = function(file)
	love.filesystem.load(file)()
end

include("constants.lua")
include("menu.lua")
include("tile.lua")

--------------------------------------------------

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

local Layer = {}
Layer.__index = Map
Layer.tiles = {}

function Layer:setTile(x, y, tile)
	tiles[x+","+y] = id
end
function Layer:getTile(x, y)
	return tiles[x+","+y]
end

--------------------------------------------------

local function loadTileset(path)
	local img = love.graphics.newImage(path)
	
	for k,v in pairs(textures) do
		textures[k] = newTexture(img, v[1], v[2])
		print(textures[k])
	end
end

function love.load()
	loadTileset("assets/images/tileset.png")
end

function love.update(delta)
	
end

function love.draw()
	
end



