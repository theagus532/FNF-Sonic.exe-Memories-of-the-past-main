function onCreate() --GF invisible!!
    setProperty('gf.visible', false)
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	    health = getProperty('health')
        if getProperty('health') > 0.1 then
	    setProperty('health', health- 0.02);

	    cameraSnake()
		cameraShake('game', 0.003, 0.1)
		cameraShake('hud', 0.0041, 0.11)
	end
end
