local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":nes_slot:cart:prg_rom", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":nes_slot:cart:prg_rom", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 1, 8, 16)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 8, 2)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":nes_slot:cart:prg_rom", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":nes_slot:cart:prg_rom", 8, 2)
	end
end

function corClass.fuckVideo(mode)
	--fuckADDR(":ppu", "videoram", 1, 8, 4)
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

return corClass
