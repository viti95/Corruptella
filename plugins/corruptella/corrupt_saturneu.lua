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
		fuckADDR(":maincpu", "program", 4, 32, 8)
		--fuckADDR(":maincpu", "program", 33, 32, 8)
		fuckADDR(":slave", "program", 4, 32, 8)
		--fuckADDR(":slave", "program", 33, 32, 8)
	end
	
	if (mode == 1) then
		fuckADDR(":maincpu", "program", 4, 32, 1)
		--fuckADDR(":maincpu", "program", 33, 32, 1)
		fuckADDR(":slave", "program", 4, 32, 1)
		--fuckADDR(":slave", "program", 33, 32, 1)
	end
end

function corClass.fuckROM(mode)

end

function corClass.fuckVideo(mode)

end

function corClass.fuckSound(mode)
	if (mode == 0) then
		fuckADDR(":scu:scudsp", "program", 1, 32, 2)
		fuckADDR(":audiocpu", "program", 1, 32, 4)
	end
	
	if (mode == 1) then
		fuckADDR(":scu:scudsp", "program", 1, 32, 1)
		fuckADDR(":audiocpu", "program", 1, 32, 1)
	end
end

function corClass.fuckMusic(mode)

end

return corClass
