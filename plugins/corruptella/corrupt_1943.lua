local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":audiocpu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":audiocpu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 23, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 23, 8, 1)
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
		fuckADDR(":maincpu", "program", 15, 8, 4)
		fuckADDR(":maincpu", "program", 16, 8, 4)
		fuckADDR(":maincpu", "program", 17, 8, 4)
		fuckADDR(":maincpu", "program", 24, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 15, 8, 1)
		fuckADDR(":maincpu", "program", 16, 8, 1)
		fuckADDR(":maincpu", "program", 17, 8, 1)
		fuckADDR(":maincpu", "program", 24, 8, 1)
	end
end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":audiocpu", "program", 2, 8, 4)
		fuckMEM(":audiocpu", 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":audiocpu", "program", 2, 8, 1)
		fuckMEM(":audiocpu", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

