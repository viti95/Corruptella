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
		fuckADDR(":maincpu", "program", 1, 32, 16)
		fuckADDR(":maincpu", "program", 4, 32, 16)
		fuckADDR(":maincpu", "program", 5, 32, 16)
		fuckADDR(":maincpu", "program", 7, 32, 16)
		fuckADDR(":maincpu", "program", 9, 32, 16)
		fuckADDR(":maincpu", "program", 10, 32, 16)
		fuckADDR(":maincpu", "program", 11, 32, 16)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 32, 1)
		fuckADDR(":maincpu", "program", 4, 32, 1)
		fuckADDR(":maincpu", "program", 5, 32, 1)
		fuckADDR(":maincpu", "program", 7, 32, 1)
		fuckADDR(":maincpu", "program", 9, 32, 1)
		fuckADDR(":maincpu", "program", 10, 32, 1)
		fuckADDR(":maincpu", "program", 11, 32, 1)
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

function corClass.drawHUD()

end

return corClass

