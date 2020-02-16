local corClass = {	
	
}

function corClass.start()

end

function corClass.dump(filename)

end

function corClass.restore(filename)

end

function corClass.fuckRAM(mode)
	fuckADDR(":maincpu", "program", 1, 8, 1)
	fuckADDR(":maincpu", "program", 2, 8, 1)
	fuckADDR(":maincpu", "program", 3, 8, 1)
	fuckADDR(":maincpu", "program", 4, 8, 1)
	fuckADDR(":maincpu", "program", 5, 8, 1)
	fuckADDR(":maincpu", "program", 6, 8, 1)
	fuckADDR(":maincpu", "program", 7, 8, 1)
	fuckADDR(":maincpu", "program", 8, 8, 1)
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
