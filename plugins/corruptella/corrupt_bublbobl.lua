local corClass = {	

}

function corClass.start()

end

function corClass.dump(filename)
	dumpMEM(filename .. "_1", ":maincpu", 8)
	dumpMEM(filename .. "_2", ":audiocpu", 8)
	dumpMEM(filename .. "_3", ":subcpu", 8)
end

function corClass.restore(filename)
	restoreMEM(filename .. "_1", ":maincpu", 8)
	restoreMEM(filename .. "_2", ":audiocpu", 8)
	restoreMEM(filename .. "_3", ":subcpu", 8)
end

function corClass.fuckRAM(mode)
	if (mode == 0) then		
		fuckADDR(":maincpu","program",5, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program",5, 8, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":maincpu", 8, 8)
		fuckMEM(":audiocpu", 8, 8)
		fuckMEM(":subcpu", 8, 8)
	end

	if (mode == 1) then
		fuckMEM(":maincpu", 8, 1)
		fuckMEM(":audiocpu", 8, 1)
		fuckMEM(":subcpu", 8, 1)
	end
end

function corClass.fuckVideo(mode)
	if (mode == 0) then
		fuckADDR(":maincpu","program",3, 8, 8)
		fuckADDR(":maincpu","program",4, 8, 8)
	end

	if (mode == 1) then
		fuckADDR(":maincpu","program",3, 8, 1)
		fuckADDR(":maincpu","program",4, 8, 1)
	end
end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":audiocpu","program",2, 8, 8)	
	end

	if (mode == 1) then
		fuckADDR(":audiocpu","program",2, 8, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
