local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":cvsd:cpu", 8)
	dumpMEM(filename .. "_3", ":gfx1", 8)
	dumpMEM(filename .. "_4", ":gfx2", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":cvsd:cpu", 8)
	restoreMEM(filename .. "_3", ":gfx1", 8)
	restoreMEM(filename .. "_4", ":gfx2", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 8, 8, 8)
		fuckADDR(":maincpu", "program", 9, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 8, 8, 1)
		fuckADDR(":maincpu", "program", 9, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 4)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckMEM(":gfx1", 8, 8)
		fuckMEM(":gfx2", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":gfx1", 8, 1)
		fuckMEM(":gfx2", 8, 2)
	end
end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":cvsd:cpu", "program", 1, 8, 8)
		fuckMEM(":cvsd:cpu", 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":cvsd:cpu", "program", 1, 8, 1)
		fuckMEM(":cvsd:cpu", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
