local corClass = {	
	
}

function corClass.start()

end

function corClass.dump(filename)

end

function corClass.restore(filename)

end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
	end
end

function corClass.fuckROM(mode)
	
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckSHA(":video_ram", 8, 8)
	end

	if (mode == 1) then
		fuckSHA(":video_ram", 8, 1)
	end
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

return corClass
