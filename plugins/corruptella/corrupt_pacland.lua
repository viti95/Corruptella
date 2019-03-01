local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":mcu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":mcu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 3, 8, 8)
		fuckADDR(":mcu", "program", 2, 8, 4)
		fuckADDR(":mcu", "program", 7, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 3, 8, 1)
		fuckADDR(":mcu", "program", 2, 8, 1)
		fuckADDR(":mcu", "program", 7, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 16)
		fuckMEM(":mcu", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
		fuckMEM(":mcu", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

