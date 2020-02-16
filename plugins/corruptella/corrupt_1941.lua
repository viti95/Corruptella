local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":audiocpu", 8)
	dumpMEM(filename .. "_3", ":oki", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":audiocpu", 8)
	restoreMEM(filename .. "_3", ":oki", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 11, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 11, 8, 1)
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
		fuckADDR(":audiocpu", "program", 3, 8, 8)
		fuckMEM(":oki", 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":audiocpu", "program", 3, 8, 1)
		fuckMEM(":oki", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end
return corClass
