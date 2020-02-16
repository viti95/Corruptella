local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":user1", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":user1", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program", 1, 32, 128)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu","program", 1, 32, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":user1", 8, 128)
	end

	if (mode == 1) then
		fuckMEM(":user1", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	
end

function corClass.fuckSound(mode)
	if (mode == 0) then	
		fuckADDR(":audiocpu","program", 2, 8, 8)
	end

	if (mode == 1) then	
		fuckADDR(":audiocpu","program", 2, 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
