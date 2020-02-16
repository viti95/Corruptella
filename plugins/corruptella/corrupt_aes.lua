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
		fuckADDR(":maincpu", "program", 15, 16, 32)	
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 15, 16, 1)
	end
end

function corClass.fuckROM(mode)
	if (mode == 0) then
		fuckMEM(":cslot1:maincpu", 8, 1024)
		fuckMEM(":cslot1:audiocpu", 8, 256)
	end

	if (mode == 1) then
		fuckMEM(":cslot1:maincpu", 8, 1)
		fuckMEM(":cslot1:audiocpu", 8, 1)
	end
	
end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":audiocpu", "program", 6, 8, 8)
		--fuckMEM(":audiocpu", 8, 64)
	end
	
	if (mode == 1) then
		fuckADDR(":audiocpu", "program", 6, 8, 1)
		--fuckMEM(":audiocpu", 8, 1)
	end
end

function corClass.fuckMusic(mode)

end
return corClass
