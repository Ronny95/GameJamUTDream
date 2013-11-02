-- music and audio

music = {
	['dream'] = {
		volume = 0.0,
		audio = love.audio.newSource('assets/audio/dream.mp3')
	},
	['real'] = {
		volume = 1.0,
		audio = love.audio.newSource('assets/audio/real.mp3')
	}
}

soundfx = {
	['switch'] = nil,--createNewMusic('switch.mp3', 0.0)
	['boulder'] = nil,--createNewMusic('boulder.mp3, 0.0')
	['changeForm'] = nil,--createNewMusic('changeForm.mp3', 0.0)
	['lever'] = nil
}
-- move animation speed scale factor
MOVESCALE = 150

-- Tile width and height in pixels
TILEW = 64
TILEH = 64

-- Map width and height (in tile units)
MAPW = 34
MAPH = 24

-- Window dimensions
WINW = 640
WINH = 640

