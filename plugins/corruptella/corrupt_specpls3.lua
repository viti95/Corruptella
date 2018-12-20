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
		fuckADDR(":maincpu", "program", 2, 8, 4)
		fuckADDR(":maincpu", "program", 3, 8, 4)
		fuckADDR(":maincpu", "program", 4, 8, 4)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 2, 8, 1)
		fuckADDR(":maincpu", "program", 3, 8, 1)
		fuckADDR(":maincpu", "program", 4, 8, 1)
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

