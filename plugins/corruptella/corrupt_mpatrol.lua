local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":irem_audio:iremsound", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":irem_audio:iremsound", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 13, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 13, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":irem_audio:iremsound", "program", 3, 8, 8)
		fuckMEM(":irem_audio:iremsound", 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":irem_audio:iremsound", "program", 3, 8, 1)
		fuckMEM(":irem_audio:iremsound", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
