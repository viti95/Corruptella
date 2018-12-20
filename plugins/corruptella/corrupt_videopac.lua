local corClass = {	
	
}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":cartslot:cart:rom", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":cartslot:cart:rom", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "data", 1, 8, 2)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "data", 1, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":cartslot:cart:rom", 8, 4)
	end
	
	if (mode == 1) then
		fuckMEM(":cartslot:cart:rom", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckMEM(":gfx1", 8, 2)
	end

	if (mode == 1) then
		fuckMEM(":gfx1", 8, 1)
	end	
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

