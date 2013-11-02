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
	['boulder'] = love.audio.newSource('assets/audio/rockrollmono.wav'),
	['changeForm'] = love.audio.newSource('assets/audio/ghoston.wav'),
	['lever'] = love.audio.newSource('assets/audio/switch_2mono.wav'),
	['solve'] = nil,--love.audio.newSource('assets/audio/solve.wav'),
	['statue'] = love.audio.newSource('assets/audio/statue.wav')
}

function fadeSound(music_obj)
	if music_obj == music['real'] and music_obj.volume > 0.0 then
		music_obj.volume = music_obj.volume - 0.05
		music_obj.audio:setVolume(music_obj.volume)

		local mus = music['dream']
		if not mus.audio:isPlaying() then
			love.audio.play(mus.audio)
		end
		mus.volume = mus.volume + 0.05
		mus.audio:setVolume(mus.volume)

		if music_obj.volume <= 0.0 then
			music_obj.audio:stop()
		end
	elseif music_obj == music['dream'] and music_obj.volume > 0.0 then
		music_obj.volume = music_obj.volume - 0.05
		music_obj.audio:setVolume(music_obj.volume)

		local mus = music['dream']
		if not mus.audio:isPlaying() then
			love.audio.play(mus.audio)
		end
		mus.volume = mus.volume + 0.05
		mus.audio:setVolume(mus.volume)

		if music_obj.volume <= 0.0 then
			music_obj.audio:stop()
		end
	end
end



