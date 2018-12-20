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
		fuckADDR(":maincpu", "program", 1, 8, 8) -- RAM
		fuckADDR(":maincpu", "program", 2, 8, 2) -- Suzy
		fuckADDR(":maincpu", "program", 3, 8, 2) -- Mikey
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 8, 1) -- RAM
		fuckADDR(":maincpu", "program", 2, 8, 1) -- Suzy
		fuckADDR(":maincpu", "program", 3, 8, 1) -- Mikey
	end
end	

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":cartslot:cart:rom", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":cartslot:cart:rom", 8, 1)
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

