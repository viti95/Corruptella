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
		fuckADDR(":maincpu", "program", 1, 32, 32)
		fuckADDR(":maincpu", "program", 2, 32, 32)
	end

	if (mode == 1) then
		fuckADDR(":maincpu", "program", 1, 32, 1)
		fuckADDR(":maincpu", "program", 2, 32, 1)
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

