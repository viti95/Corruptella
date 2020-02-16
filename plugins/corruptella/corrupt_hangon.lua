local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":subcpu", 8)
	dumpMEM(filename .. "_3", ":soundcpu", 8)
	dumpMEM(filename .. "_4", ":pcm", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":subcpu", 8)
	restoreMEM(filename .. "_3", ":soundcpu", 8)
	restoreMEM(filename .. "_4", ":pcm", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 2, 8, 4)
		fuckADDR(":maincpu", "program", 5, 8, 4)
		fuckADDR(":maincpu", "program", 8, 8, 4)
		fuckADDR(":maincpu", "program", 9, 8, 4)

		fuckADDR(":subcpu", "program", 2, 8, 4)
		fuckADDR(":subcpu", "program", 3, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 2, 8, 1)
		fuckADDR(":maincpu", "program", 5, 8, 1)
		fuckADDR(":maincpu", "program", 8, 8, 1)
		fuckADDR(":maincpu", "program", 9, 8, 1)

		fuckADDR(":subcpu", "program", 2, 8, 1)
		fuckADDR(":subcpu", "program", 3, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 16)
		fuckMEM(":subcpu", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
		fuckMEM(":subcpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":soundcpu", "program", 2, 8, 8)
		fuckMEM(":soundcpu", 8, 4)
		fuckMEM(":pcm", 8, 32)
	end

	if (mode == 1) then
		fuckADDR(":soundcpu", "program", 2, 8, 1)
		fuckMEM(":soundcpu", 8, 1)
		fuckMEM(":pcm", 8, 4)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
