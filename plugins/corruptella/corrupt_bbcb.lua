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
		fuckADDR(":maincpu", "program", 16, 8, 16)
		fuckADDR(":maincpu", "program", 17, 8, 16)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 16, 8, 1)
		fuckADDR(":maincpu", "program", 17, 8, 1)
	end
end

function corClass.fuckROM(mode)
	
end

function corClass.fuckVideo(mode)
	
end

function corClass.fuckSound(mode)

end

function corClass.fuckMusic(mode)

end
return corClass
