local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":snsslot:cart:rom", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":snsslot:cart:rom", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 1, 16, 32)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 16, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":snsslot:cart:rom", 8, 32)
	end

	if (mode == 1) then
		fuckMEM(":snsslot:cart:rom", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":soundcpu", "program", 1, 8, 4)
		fuckADDR(":soundcpu", "program", 3, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":soundcpu", "program", 1, 8, 2)
		fuckADDR(":soundcpu", "program", 3, 8, 2)
	end	
end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

