local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":audiocpu", 8)
	dumpMEM(filename .. "_3", ":oki1", 8)
	dumpMEM(filename .. "_4", ":oki2", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":audiocpu", 8)
	restoreMEM(filename .. "_3", ":oki1", 8)
	restoreMEM(filename .. "_4", ":oki2", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 10, 8, 16)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 10, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":audiocpu", "program", 9, 8, 4)
		fuckMEM(":audiocpu", 8, 8)
		fuckMEM(":oki1", 8, 32)
		fuckMEM(":oki2", 8, 32)
	end

	if (mode == 1) then
		fuckADDR(":audiocpu", "program", 9, 8, 1)
		fuckMEM(":audiocpu", 8, 1)
		fuckMEM(":oki1", 8, 1)
		fuckMEM(":oki2", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end
return corClass
