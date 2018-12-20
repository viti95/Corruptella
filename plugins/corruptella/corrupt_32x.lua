local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":gamecart_sh2", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":gamecart_sh2", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program", 11, 16, 16)
		fuckADDR(":sega32x:32x_slave_sh2","program", 14, 32, 32)
		fuckADDR(":sega32x:32x_master_sh2","program", 14, 32, 32)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu","program", 11, 16, 1)
		fuckADDR(":sega32x:32x_slave_sh2","program", 14, 32, 1)
		fuckADDR(":sega32x:32x_master_sh2","program", 14, 32, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":gamecart_sh2", 8, 64)
	end
	
	if (mode == 1) then
		fuckMEM(":gamecart_sh2", 8, 2)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":genesis_snd_z80","program", 1, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":genesis_snd_z80","program", 1, 8, 1)
	end	
end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

