local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":soundcpu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":soundcpu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 2, 8, 8)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu", "program", 2, 8, 1)
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
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 3, 8, 8)
		fuckADDR(":maincpu", "program", 4, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 3, 8, 1)
		fuckADDR(":maincpu", "program", 4, 8, 1)
	end
end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckMEM(":soundcpu", 8, 16)
		fuckADDR(":soundcpu", "data", 1, 8, 2)
	end

	if (mode == 1) then
		fuckMEM(":soundcpu", 8, 1)
		fuckADDR(":soundcpu", "data", 1, 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
