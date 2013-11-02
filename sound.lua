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

function fadeSound(music_obj)
	
end


