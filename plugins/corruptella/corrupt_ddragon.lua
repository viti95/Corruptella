local corClass = {	
	
}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":sub", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":sub", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu", "program", 1, 8, 8)
		fuckADDR(":sub", "program", 2, 8, 8)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 8, 1)
		fuckADDR(":sub", "program", 2, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 16)
		fuckMEM(":sub", 8, 16)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
		fuckMEM(":sub", 8, 1)
	end	
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":audiocpu", "program", 1, 8, 8)
	end 

	if (mode == 1) then
		fuckADDR(":audiocpu", "program", 1, 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
