local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":sub", 8)
	dumpMEM(filename .. "_3", ":soundcpu", 8)
	dumpMEM(filename .. "_4", ":oki", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":sub", 8)
	restoreMEM(filename .. "_3", ":soundcpu", 8)
	restoreMEM(filename .. "_4", ":oki", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 1, 8, 8)
		fuckADDR(":maincpu", "program", 4, 8, 8)
		fuckADDR(":sub", "program", 2, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 8, 1)
		fuckADDR(":maincpu", "program", 4, 8, 1)
		fuckADDR(":sub", "program", 2, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 8)
		fuckMEM(":sub", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
		fuckMEM(":sub", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":soundcpu", "program", 2, 8, 4)
		fuckMEM(":soundcpu", 8, 8)
		fuckMEM(":oki", 8, 32)
	end

	if (mode == 1) then
		fuckADDR(":soundcpu", "program", 2, 8, 1)
		fuckMEM(":soundcpu", 8, 1)
		fuckMEM(":oki", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
