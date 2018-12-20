local corClass = {	

}

function corClass.start(screen, game)

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":soundcpu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":soundcpu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program",2, 8, 16)
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program",2, 8, 2)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 32)
		fuckMEM(":soundcpu", 8, 4)
	end
	
	if (mode == 1) then
		fuckMEM(":maincpu", 8, 2)
		fuckMEM(":soundcpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":soundcpu","program",2, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":soundcpu","program",2, 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

function corClass.drawHUD()

end

return corClass

