local corClass = {	
	
}

function corClass.start()

end

function corClass.dump(filename)

end

function corClass.restore(filename)

end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":m68000", "program", 2, 8, 128)
		fuckADDR(":m68000", "program", 3, 8, 128)
	end

	if (mode == 1) then
		fuckADDR(":m68000", "program", 2, 8, 32)
		fuckADDR(":m68000", "program", 3, 8, 32)
	end
end

function corClass.fuckROM(mode)
	
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

