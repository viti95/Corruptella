local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":slot:cart:rom", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":slot:cart:rom", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":z80", "program", 2, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":z80", "program", 2, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":slot:cart:rom", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":slot:cart:rom", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckADDR(":tms9918a", "vram", 1, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":tms9918a", "vram", 1, 8, 1)
	end
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

