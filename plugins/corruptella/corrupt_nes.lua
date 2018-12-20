local corClass = {	

}

corClass._game = nil
corClass._screen = nil

corClass._sizeROM = 0

corClass._currentBytesRAM = 0
corClass._currentBytesROM = 0

corClass._prevBytesRAM = 0
corClass._prevBytesROM = 0

function corClass.start(screen, game)
	corClass._game = game
	corClass._screen = screen
	corClass._sizeROM = getMEMsize(":nes_slot:cart:prg_rom")
	corClass._currentBytesRAM = 0
	corClass._currentBytesROM = 0
end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":nes_slot:cart:prg_rom", 8)
	corClass._prevBytesROM = corClass._currentBytesROM
	corClass._prevBytesRAM = corClass._currentBytesRAM
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":nes_slot:cart:prg_rom", 8)
	corClass._currentBytesROM = corClass._prevBytesROM
	corClass._currentBytesRAM = corClass._prevBytesRAM
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 1, 8, 16)
		corClass._currentBytesRAM = corClass._currentBytesRAM + 16
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 8, 2)
		corClass._currentBytesRAM = corClass._currentBytesRAM + 2
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":nes_slot:cart:prg_rom", 8, 16)
		corClass._currentBytesROM = corClass._currentBytesROM + 16
	end

	if (mode == 1) then
		fuckMEM(":nes_slot:cart:prg_rom", 8, 2)
		corClass._currentBytesROM = corClass._currentBytesROM + 2
	end
end

function corClass.fuckVideo(mode)
	--fuckADDR(":ppu", "videoram", 1, 8, 4)
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

	local percentageROM = (corClass._currentBytesROM / corClass._sizeROM) * 100

	corClass._screen:draw_box(110, 225, 258, 239, 0x99000000, 0x00000000); -- (x0, y0, x1, y1, fill-color, line-color)
	corClass._screen:draw_text(112, 227, "ROM Corruption: " .. string.format("%2.3f%%", percentageROM) .. " RAM Corruption: " .. corClass._currentBytesRAM); -- (x0, y0, msg)		

end

return corClass

