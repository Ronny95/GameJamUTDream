-- music and audio

musicPlaying = 'real'

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

function initSound()
	music['real'].audio:setLooping(true)
	music['dream'].audio:setLooping(false)

	love.audio.play(music['real'].audio)
	love.audio.setVolume(music['real'].volume)
end

function fadeSound(music_obj)

	-- REAL
	if music_obj == music['real'] then
		if music['real'].volume > 0.0 then
			music['real'].volume = music['real'].volume - 0.005
			love.audio.setVolume(music['real'].volume)
		end

		if music['real'].volume <= 0.0 and music['real'].audio:isLooping() then
			music['real'].volume = 0.0
			love.audio.stop()
			music['real'].audio:setLooping(false)
		end

		if not music['real'].audio:isLooping() and music['dream'].volume < 1.0 then
			if not music['dream'].audio:isLooping() then
				music['dream'].audio:isLooping(true)
				love.audio.play(music['dream'].audio)
			end

			music['dream'].volume = music['dream'].volume + 0.005
			love.audio.setVolume(music['dream'].volume)
		end

	-- DREAM
	elseif music_obj == music['dream'] then
		if music['dream'].volume > 0.0 then
			music['dream'].volume = music['dream'].volume - 0.005
			love.audio.setVolume(music['dream'].volume)
		end

		if music['dream'].volume <= 0.0 and music['dream'].audio:isLooping() then
			music['dream'].volume = 0.0
			love.audio.stop()
			music['dream'].audio:isLooping(false)
		end

		if not music['dream'].audio:isLooping() and music['real'].volume < 1.0 then
			if not music['real'].audio:isLooping() then
				music['real'].audio:isLooping(true)
				love.audio.play(music['real'].audio)
			end

			music['real'].volume = music['real'].volume + 0.005
			love.audio.setVolume(music['real'].volume)
		end
	end
end



