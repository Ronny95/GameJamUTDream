STRICT = true
DEBUG = true

TILEW = 32
TILEH = 32

require 'zoetrope'

local app = {}
local tiles = {}

local function loadTile(x, y)
	local tileData = {}
	tileData.width = TILEW
	tileData.height = TILEH
	tileData.image = 'spritesheet.png'
	tileData.imageOffset = {}
	tileData.imageOffset.x = x*TILEW
	tileData.imageOffset.y = y*TILEH
	
	return Tile:new(tileData)
end

--------------------------------------------------


local mapData = {}
mapData.spriteHeight = TILEW
mapData.spriteWidth = TILEH

function mapData:onNew()
	self:loadMap(self.mapPath)
end

local GameMap = Map:extend(mapData)

--------------------------------------------------

local playerData = {}

playerData.width = TILEW
playerData.height = TILEH
playerData.image = 'spritesheet.png'
playerData.imageOffset = {x = 0, y= 0}
playerData.sequences = 
{
	right = { frames = { 1 }, fps = 10},
	left  = { frames = { 1 }, fps = 10},
	up    = { frames = { 1 }, fps = 10},
	down  = { frames = { 1 }, fps = 10}
}

function playerData:onUpdate(elapsed)
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
end

function playerData:onCollide(object)
	print(object)
end

local Player = Animation:extend(playerData)

--------------------------------------------------

local appData = {}


function appData:onRun()
	tiles[1] = loadTile(0, 0)
	tiles[2] = loadTile(1, 0)
	
	self.mapReal  = GameMap:new{mapPath = "maps/real_00.txt" , sprites = tiles}
	self.mapDream = GameMap:new{mapPath = "maps/dream_00.txt", sprites = tiles}
	self:add(self.map)
	self.player = Player:new{ x = 0, y = 0 }
	self:add(self.player)
end

function appData:onUpdate()
	-- doesn't do anything yet
end



