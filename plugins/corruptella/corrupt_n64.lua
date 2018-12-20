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
		fuckADDR(":maincpu", "program", 1, 32, 32) -- TLB mapping
		--fuckADDR_limits(":maincpu", "program", 1, 32, 32, 0x00000000, 0x00200000) -- TLB mapping
		--fuckSHA(":rdram", 32, 16)
	end

	if (mode == 1) then
		--fuckADDR(":maincpu", "program", 1, 32, 1) -- TLB mapping
		--fuckSHA(":rdram", 32, 1)
	end
end

function corClass.fuckROM(mode)

	local minCart = 0x000000
	local maxCart = 0x3200000

	if (mode == 0) then
		fuckMEM_limits(":user2", 32, 256, minCart, maxCart)
		--fuckMEM_limits(":user2", 8, 128, 0x0, maxCart)
		--fuckMEM_limits(":cartslot:rom", 32, 16384, 0x0000000, 0x000000010)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 3, 32, 32) -- RSP DMEM
		fuckADDR(":maincpu", "program", 4, 32, 32) -- RSP IMEM
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu", "program", 3, 32, 1) -- RSP DMEM
		fuckADDR(":maincpu", "program", 4, 32, 1) -- RSP IMEM
	end
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

