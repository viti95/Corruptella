local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program",6, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program",6, 8, 2)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 32)
	end
	
	if (mode == 1) then
		fuckMEM(":maincpu", 8, 2)
	end
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end

return corClass
