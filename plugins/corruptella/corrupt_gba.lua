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
		fuckADDR(":maincpu","program", 2, 32, 4)
		fuckADDR(":maincpu","program", 3, 32, 4)	
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program", 2, 32, 1)
		fuckADDR(":maincpu","program", 3, 32, 1)	
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":cartslot:cart:rom", 8, 128)
	end

	if (mode == 1) then
		fuckMEM(":cartslot:cart:rom", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program", 7, 32, 8)
		fuckADDR(":maincpu","program", 8, 32, 64)
		fuckADDR(":maincpu","program", 10, 32, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program", 7, 32, 1)
		fuckADDR(":maincpu","program", 8, 32, 1)
		fuckADDR(":maincpu","program", 10, 32, 1)
	end
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

