-- license:BSD-3-Clause
-- copyright-holders:ViTi95
local exports = {}
exports.name = "corruptella"
exports.version = "0.0.1"
exports.description = "Corruptella plugin"
exports.license = "The BSD 3-Clause License"
exports.author = { name = "ViTi95" }

local corruptella = exports

function corruptella.startplugin()

	corruptellaFolder = "./corruptella/"

	local json = require("json")
	local conth = emu.thread()
	local started = false
	local ln = require("linenoise")
	local preload = false
	print("ViTi95's Corruptella\n");
	ln.historysetmaxlen(10)
	local scr = [[
local ln = require('linenoise')
ln.setcompletion(function(c, str)
	status = str
	yield()
	status:gsub('[^,]*', function(s) if s ~= '' then ln.addcompletion(c, s) end end)
end)
return ln.linenoise('\x1b[1;36m[Corruptella]\x1b[0m> ')
]]

    local seen={}

	local function find_unmatch(str, openpar, pair)
		local done = false
		if not str:match(openpar) then
			return str
		end
		local tmp = str:gsub(pair, "")
		if not tmp:match(openpar) then
			return str
		end
		repeat
			str = str:gsub(".-" .. openpar .. "(.*)", function (s)
				tmp = s:gsub(pair, "")
				if not tmp:match(openpar) then
					done = true
				end
				return s
			end)
		until done or str == ""
		return str
	end

	local function get_completions(str)
		local comps = ","
		local rest, dot, last = str:match("(.-)([.:]?)([^.:]*)$")
		str = find_unmatch(str, "%(", "%b()")
		str = find_unmatch(str, "%[", "%b[]")
		local table = str:match("([%w_%.:%(%)%[%]]-)[:.][%w_]*$")
		local err
		if rest == "" or not table then
			if dot == "" then
				table = "_G"
			else
				return comps
			end
		end
		err, tablef = pcall(load("return " .. table))
		if (not err) or (not tablef) then
			return comps
		end
		rest = rest .. dot
		if type(tablef) == 'table' then
			for k, v in pairs(tablef) do
				if k:match("^" .. last) then
					comps = comps .. "," .. rest .. k
				end
			end
		end
		if type(tablef) == "userdata" then
			local tablef = getmetatable(tablef)
			for k, v in pairs(tablef) do
				if k:match("^" .. last) then
					comps = comps .. "," .. rest .. k
				end
			end
		end
		return comps
	end

	function tablelength(T)
  		local count = 0
  		for _ in pairs(T) do 
  			count = count + 1 
  		end
  		return count
	end

	local socket = emu.file("rwc") 
	socket:open("socket.127.0.0.1:666")

	local A1, A2 = 727595, 798405  -- 5^17=D20*A1+A2
	local D20, D40 = 1048576, 1099511627776  -- 2^20, 2^40
	math.randomseed(os.clock()*100000000000)
	local X1 = math.random(0, 2^20-1)
	local X2 = math.random(0, 2^20-1)

	function rand()
	    local U = X2*A2
	    local V = (X1*A2 + X2*A1) % D20
	    V = (V*D20 + U) % D40
	    X1 = math.floor(V/D20)
	    X2 = V - X1*D20
	    return V/D40
	end

	function numbertobytes(num, width)
	  local function _n2b(t, width, num, rem)
	    if width == 0 then return table.concat(t) end
	    table.insert(t, 1, string.char(rem * 256))
	    return _n2b(t, width-1, math.modf(num/256))
	  end
	  return _n2b({}, width, math.modf(num/256))
	end

	function readAll(file)
		local f = io.open(file, "rb")
		local content = f:read("*all")
		f:close()
		return content
	end

	function readMappings()
		local mappingFile = readAll("./" .. manager:options().entries.pluginspath:value() .. "/corruptella/corruptella.json")
		return json.parse(mappingFile)
	end

	function test()
		--emu.pause()

		local s
		for k,v in pairs(manager:machine().screens) do s=v break end

		print(s:width() .. "x" .. s:height())
		s:draw_text(40, 40, "foo"); -- (x0, y0, msg)
		s:draw_box(20, 20, 80, 80, 0, 0xff00ffff); -- (x0, y0, x1, y1, fill-color, line-color)
		s:draw_line(20, 20, 80, 80, 0xff00ffff); -- (x0, y0, x1, y1, line-color)

 		--emu.unpause()
	end

	function getInfo()
		print("\nDriver: " .. manager:machine():system().name .. "(" .. manager:machine():system().parent .. ")")

		print ("\nScreens:\n")
		for k,v in pairs(manager:machine().screens) do
			print (k .. " (" .. v:width() .. "x" .. v:height() .. "@" .. v:refresh() .. ")")
		end

		print("\nDevices:\n")
		for k,v in pairs(manager:machine().devices) do 
			print(v:name() .. " (" .. k .. ") ") 

			if tablelength(v.state) > 0 then
				print("\tregisters\t")
				
				strRegisters = "\t\t"

				for i,j in pairs(v.state) do
					strRegisters = strRegisters .. i .. ", "
				end

				strRegisters = strRegisters:sub(0, #strRegisters - 2)

				print(strRegisters)
			end

			if tablelength(v.spaces) > 0 then
				for i,j in pairs (v.spaces) do
					print("\t" .. i)
					for x,y in pairs(j.map) do
						print("\t\t" .. x .. ", " .. string.format("0x%X", y["offset"]) .. ", " .. string.format("0x%X", y["endoff"]) .. ", " .. y["readtype"] .. ", " .. y["writetype"])
					end
				end
			end
		end
		
		print("\nMemory regions:\n")

		for k,v in pairs(manager:machine():memory().regions) do
			print(k .. ", " .. v.size)
		end

		print("\nShared memory:\n")

		for k,v in pairs(manager:machine():memory().shares) do
			print(k .. ", " .. v.size)
		end
	end

	function dumpTime()
		local finalFileName = os.date("%Y%m%d_%H%M%S")
		local currentGame = get_game()

		if currentGame ~= "" then
			finalFileName = finalFileName .. "_" .. currentGame
		end

		dump(finalFileName)
	end

	function dump(filename)
		emu.pause()

		lastDump = filename

		if corClass ~= nil then
			corClass.dump(manager:machine():system().name .. "_" .. filename)
		end

		manager:machine():save(filename)

		emu.unpause()
	end

	function restore(filename)
		emu.pause()

		manager:machine():load(filename)

		emu.pause()

		if corClass ~= nil then
			corClass.restore(manager:machine():system().name .. "_" .. filename)
		end 

		emu.unpause()
	end

	function restoreLast()
		if lastDump ~= nil then
			restore(lastDump)
		end
	end

	function minifuck(bits, repetitions)
		local count = 0;

		for k,v in pairs(manager:machine().devices) do 
			if tablelength(v.spaces) > 0 then
				for i,j in pairs (v.spaces) do
					for x,y in pairs(j.map) do
						count = count + 1
					end
				end
			end
		end
		
		for k,v in pairs(manager:machine():memory().regions) do
			count = count + 1
		end

		for k,v in pairs(manager:machine():memory().shares) do
			count = count + 1
		end

		local rndFuck = math.floor(math.random(1, count))

		count = 0

		for k,v in pairs(manager:machine().devices) do 
			if tablelength(v.spaces) > 0 then
				for i,j in pairs (v.spaces) do
					for x,y in pairs(j.map) do
						count = count + 1
						if (count == rndFuck) then
							print(k .. " " .. i .. " " .. x .. " " .. bits .. " " .. repetitions)
							fuckADDR(k, i, x, bits, repetitions)
						end
					end
				end
			end
		end
		
		for k,v in pairs(manager:machine():memory().regions) do
			count = count + 1
			if (count == rndFuck) then
				fuckMEM(k, bits, repetitions)
				print(k .. ", " .. v.size)
			end
		end

		for k,v in pairs(manager:machine():memory().shares) do
			count = count + 1
			if (count == rndFuck) then
				fuckSHA(k, bits, repetitions)
				print(k .. ", " .. v.size)
			end
		end
	end

	function autofuck(bits, repetitions)
		autofuckdevices(bits, repetitions)
		autofuckregions(bits, repetitions)
		autofuckshares(bits, repetitions)
	end

	function autofuckdevices(bits, repetitions)
		for k,v in pairs(manager:machine().devices) do 
			if tablelength(v.spaces) > 0 then
				for i,j in pairs (v.spaces) do
					for x,y in pairs(j.map) do
						fuckADDR(k, i, x, bits, repetitions)
						print(k .. " " .. i .. " " .. x .. " " .. bits .. " " .. repetitions)
					end
				end
			end
		end
	end

	function autofuckregions(bits, repetitions)
		for k,v in pairs(manager:machine():memory().regions) do
			fuckMEM(k, bits, repetitions)
			print(k .. ", " .. v.size)
		end
	end

	function autofuckshares(bits, repetitions)
		for k,v in pairs(manager:machine():memory().shares) do
			fuckSHA(k, bits, repetitions)
			print(k .. ", " .. v.size)
		end
	end

	function fuck(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckRAM(mode)
			corClass.fuckROM(mode)
			corClass.fuckVideo(mode)
			corClass.fuckSound(mode)
			corClass.fuckMusic(mode)
		end

		emu.unpause()
	end

	function fuckRAM(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckRAM(mode)
		end

		emu.unpause()
	end

	function fuckROM(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckROM(mode)
		end

		emu.unpause()
	end

	function fuckVideo(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckVideo(mode)
		end

		emu.unpause()
	end

	function fuckSound(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckSound(mode)
		end

		emu.unpause()
	end

	function fuckMusic(mode)
		emu.pause()

		if corClass ~= nil then
			corClass.fuckMusic(mode)
		end
		
		emu.unpause()
	end

	function string.split(inputstr, sep)
		local t={} ; i=1
		if inputstr == nil then
			return t
		end
		if inputstr == "" then
			return t
		end
        if sep == nil then
                sep = "%s"
        end
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
	end

	function fuckADDR_limits(device, space, block, bits, repetitions, offset, endoff)
		emu.pause()

		local memDevice = manager:machine().devices[device].spaces[space]
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = offset + math.floor(rand() * (endoff - offset + 1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end
		end

		emu.unpause()
	end

	function fuckADDR(device, space, block, bits, repetitions)
		emu.pause()

		local memDevice = manager:machine().devices[device].spaces[space]
		local offset = memDevice.map[block]["offset"]
		local endoff = memDevice.map[block]["endoff"]
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = offset + math.floor(rand() * (endoff - offset + 1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end
		end

		emu.unpause()
	end

	function fuckREG(device, register, bits)
		manager:machine().devices[device].state[register].value = math.floor(rand() * (2^bits))
	end

	function fuckMEM_limits(mem, bits, repetitions, offset, endoff)
		emu.pause()

		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = offset + math.floor(rand() * (endoff - offset + 1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end
		end

		emu.unpause()
	end

	function fuckMEM(mem, bits, repetitions)
		emu.pause()

		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = math.floor(rand() * (maxAddress+1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end
		end

		emu.unpause()
	end

	function fuckSHA_limits(mem, bits, repetitions, offset, endoff)
		emu.pause()

		local memDevice = manager:machine():memory().shares[mem]
		local maxAddress = memDevice.size
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = offset + math.floor(rand() * (endoff - offset + 1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end
		end

		emu.unpause()
	end

	function fuckSHA(mem, bits, repetitions)
		emu.pause()

		local memDevice = manager:machine():memory().shares[mem]
		local maxAddress = memDevice.size
		local maxValue = 2^bits-1

		for i=0,repetitions-1,1 do
			local randomAddress = math.floor(rand() * (maxAddress+1))
			local randomValue = math.floor(rand() * (maxValue+1))

			if (bits == 8) then
				memDevice:write_u8(randomAddress,randomValue)
			end

			if (bits == 16) then
				memDevice:write_u16(randomAddress,randomValue)
			end

			if (bits == 32) then
				memDevice:write_u32(randomAddress,randomValue)
			end

			if (bits == 64) then
				memDevice:write_u64(randomAddress,randomValue)
			end	
		end

		emu.unpause()
	end

	function getMEMsize(mem)
		local memDevice = manager:machine():memory().regions[mem]
		return memDevice.size
	end

	function getSHAsize(mem)
		local memDevice = manager:machine():memory().shares[mem]
		return memDevice.size
	end

	function showREGS(device)
		emu.pause()

		for i,j in pairs(manager:machine().devices[device].state) do
			print (i .. ": " .. j.value)
		end

		emu.unpause()
	end

	function dumpADDR(file, device, space, block, bits)
		local newFile = io.open(corruptellaFolder .. file, "wb")

		local memDevice = manager:machine().devices[device].spaces[space]
		local offset = memDevice.map[block]["offset"]
		local endoff = memDevice.map[block]["endoff"]

		for i = offset, endoff, 1 do

			if (bits == 8) then
				newFile:write(string.format("%02X", memDevice:read_u8(i)))
			end

			if (bits == 16) then
				newFile:write(string.format("%04X", memDevice:read_u16(i)))
			end

			if (bits == 32) then
				newFile:write(string.format("%08X", memDevice:read_u32(i)))
			end

			if (bits == 64) then
				newFile:write(string.format("%16X", memDevice:read_u64(i)))
			end

		end

		newFile:close()		
	end

	function restoreADDR(file, device, space, block, bits)
		local readFile = io.open(corruptellaFolder .. file, "rb")

		local memDevice = manager:machine().devices[device].spaces[space]
		local offset = memDevice.map[block]["offset"]
		local endoff = memDevice.map[block]["endoff"]
		
		for i = offset, endoff, 1 do
			
			if (bits == 8) then
				local byteDump = tonumber(readFile:read(2), 16)
				memDevice:write_u8(i, byteDump)
			end

			if (bits == 16) then
				local byteDump = tonumber(readFile:read(4), 16)
				memDevice:write_u16(i, byteDump)
			end

			if (bits == 32) then
				local byteDump = tonumber(readFile:read(8), 16)
				memDevice:write_u32(i, byteDump)
			end

			if (bits == 64) then
				local byteDump = tonumber(readFile:read(16), 16)
				memDevice:write_u64(i, byteDump)
			end
		end

		readFile:close()
	end

	function fastLocalDumpMEM(mem)
		
		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size
	
		local array = {}
		for i=0,maxAddress-1,1 do
			array[#array+1] = memDevice:read_u8(i)
		end

		return array
	end

	function compareArray(array1, array2)

		local length = #array1
		local equalCount = 0

		for i=0,length-1,1 do
			if array1[i] == array2[i] then
				equalCount = equalCount + 1
			end
		end

		return equalCount / length
	end

	function fastDumpMEM(file, mem)
		local newFile = io.open(corruptellaFolder .. file, "wb")

		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size
	
		local fullFile = {}
		for i=0,maxAddress-1,1 do
			fullFile[#fullFile+1] = string.char(memDevice:read_u8(i))
		end
		fullFile = table.concat(fullFile);
				
		newFile:write(fullFile)
		newFile:close()
	end

	function dumpMEM(file, mem, bits)
		local newFile = io.open(corruptellaFolder .. file, "wb")

		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size

		for i=0,maxAddress-1,1 do
			if (bits == 8) then
				newFile:write(string.format("%02X", memDevice:read_u8(i)))
			end

			if (bits == 16) then
				newFile:write(string.format("%04X", memDevice:read_u16(i)))
			end

			if (bits == 32) then
				newFile:write(string.format("%08X", memDevice:read_u32(i)))
			end

			if (bits == 64) then
				newFile:write(string.format("%16X", memDevice:read_u64(i)))
			end
		end

		newFile:close()
	end

	function restoreMEM(file, mem, bits)
		local readFile = io.open(corruptellaFolder .. file, "rb")

		local memDevice = manager:machine():memory().regions[mem]
		local maxAddress = memDevice.size

		for i=0,maxAddress-1,1 do
			if (bits == 8) then
				local byteRead = tonumber(readFile:read(2), 16)
				memDevice:write_u8(i, byteRead)
			end

			if (bits == 16) then
				local byteRead = tonumber(readFile:read(4), 16)
				memDevice:write_u16(i, byteRead)
			end

			if (bits == 32) then
				local byteRead = tonumber(readFile:read(8), 16)
				memDevice:write_u32(i, byteRead)
			end

			if (bits == 64) then
				local byteRead = tonumber(readFile:read(16), 16)
				memDevice:write_u64(i, byteRead)
			end
		end

		readFile:close()
	end

	function dumpSHA(file, mem, bits)
		local newFile = io.open(corruptellaFolder .. file, "wb")

		local memDevice = manager:machine():memory().shares[mem]
		local maxAddress = memDevice.size

		for i=0,maxAddress-1,1 do
			if (bits == 8) then
				newFile:write(string.format("%02X", memDevice:read_u8(i)))
			end

			if (bits == 16) then
				newFile:write(string.format("%04X", memDevice:read_u16(i)))
			end

			if (bits == 32) then
				newFile:write(string.format("%08X", memDevice:read_u32(i)))
			end

			if (bits == 64) then
				newFile:write(string.format("%16X", memDevice:read_u64(i)))
			end
		end

		newFile:close()
	end

	function restoreSHA(file, mem, bits)
		local readFile = io.open(corruptellaFolder .. file, "rb")
		
		local memDevice = manager:machine():memory().shares[mem]
		local maxAddress = memDevice.size

		for i=0,maxAddress-1,1 do
			if (bits == 8) then
				local byteRead = tonumber(readFile:read(2), 16)
				memDevice:write_u8(i, byteRead)
			end

			if (bits == 16) then
				local byteRead = tonumber(readFile:read(4), 16)
				memDevice:write_u16(i, byteRead)
			end

			if (bits == 32) then
				local byteRead = tonumber(readFile:read(8), 16)
				memDevice:write_u32(i, byteRead)
			end

			if (bits == 64) then
				local byteRead = tonumber(readFile:read(16), 16)
				memDevice:write_u64(i, byteRead)
			end
		end

		readFile:close()
	end

	function get_game()

		if manager:machine().images["cart"] ~= nil then
			if manager:machine().images["cart"]:filename() ~= nil then
				return manager:machine().images["cart"]:filename()
			end
		end

		if manager:machine().images["cart1"] ~= nil then
			if manager:machine().images["cart1"]:filename() ~= nil then
				return manager:machine().images["cart1"]:filename()
			end
		end		

		if manager:machine().images["flop1"] ~= nil then
			if manager:machine().images["flop1"]:filename() ~= nil then
				return manager:machine().images["flop1"]:filename()
			end
		end

		return ""
	end

	function string.starts(String,Start)
   		return string.sub(String,1,string.len(Start))==Start
	end

	function prequire(m) 
  		local ok, err = pcall(require, m) 
  		if not ok then return nil, err end
  		return err
	end

	function menu_callback(index, event)
		return true
	end

	mappings = readMappings()

	for k,v in pairs(mappings["mappings"])  do
		print(k)
	end

	lastDump = nil

	currentKey = nil
	lastKey = nil

	emu.register_start(function ()
		currentKey = nil
		lastKey = nil

		fileToLoad = "corrupt_"

		if manager:machine():system().name ~= "___empty" then
			fileToLoad = fileToLoad .. manager:machine():system().name
		end

		corClass = prequire("corruptella/" .. fileToLoad)
		if corClass ~= nil then			
			corClass.start()
		else
			print ("System not prepared for corruption")
		end
	end)

	emu.register_frame(function ()

		if manager:machine():system().name ~= "___empty" then

			currentKey = nil

			for k,v in pairs(mappings["mappings"]) do
				local inputCode = manager:machine():input():code_from_token(k)
				if manager:machine():input():code_pressed(inputCode) then 
					currentKey = k
					break
				end
			end

			if lastKey ~= currentKey and lastKey ~= nil then
				if mappings["mappings"][lastKey] ~= nil then
					print (mappings["mappings"][lastKey])
					local dynamicFunction = loadstring(mappings["mappings"][lastKey], errorMSG)
					dynamicFunction()
				end
			end

			lastKey = currentKey

			-- TWITCH
			local socketKey = socket:read(1)

			if socketKey ~= nil and socketKey ~= "" then
				local dynamicKeycode = "KEYCODE_" .. socketKey
				print (mappings["mappings"][dynamicKeycode])
				local dynamicTwitchFunction = loadstring(mappings["mappings"][dynamicKeycode], errorMSG)
				dynamicTwitchFunction()
			end

		end

	end)

	emu.register_periodic(function()
		if conth.yield then
			conth:continue(get_completions(conth.result))
			return
		elseif conth.busy then
			return
		elseif started then
			local cmd = conth.result
			local args = {}
			preload = false
			
			if (cmd ~= "") then
				args = string.split(cmd, " ")
			end

			if (cmd == "help") then

			end

			if (cmd == "reboot") then
				manager:machine():hard_reset()
				print("OK")
				ln.historyadd(cmd)
			end

			if (cmd == "reset") then
				manager:machine():soft_reset()
				print("OK")
				ln.historyadd(cmd)
			end

			if (cmd == "video") then
				if (manager:machine():video():is_recording()) then
					manager:machine():video():end_recording()
					print("OK, Stop recording")
				else
					manager:machine():video():begin_recording()
					print("OK, Begin recording")
				end
			end

			if (cmd == "save") then
				dump("v95qs")
				print("OK")
				ln.historyadd(cmd)
			end

			if (cmd == "load") then
				restore("v95qs")
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "showREGS ")) then
				showREGS(args[2])
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "showADDR ")) then
				showADDR(args[2], args[3], tonumber(args[4]), tonumber(args[5]))
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "showMEM ")) then
				showMEM(args[2], tonumber(args[3]))
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "showSHA ")) then
				showSHA(args[2], tonumber(args[3]))
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "save ")) then
				dump(args[2])
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "load ")) then
				restore(args[2])
				print("OK")
				ln.historyadd(cmd)
			end

			if (cmd == "getInfo") then
				getInfo()
				ln.historyadd(cmd)
			end

			if (cmd == "exit") then
				manager:machine():exit()
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"fuckADDR ")) then
				emu.pause()
				fuckADDR(args[2], args[3], tonumber(args[4]), tonumber(args[5]), tonumber(args[6]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"fuckMEM ")) then
				emu.pause()
				fuckMEM(args[2], tonumber(args[3]), tonumber(args[4]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"fuckSHA ")) then
				emu.pause()
				fuckSHA(args[2], tonumber(args[3]), tonumber(args[4]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"fuckREG ")) then
				emu.pause()
				fuckREG(args[2], args[3], tonumber(args[4]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (cmd == "fuck") then
				fuck()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"autofuck ")) then
				autofuck(tonumber(args[2]), tonumber(args[3]))
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd,"minifuck ")) then
				minifuck(tonumber(args[2]), tonumber(args[3]))
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "dumpADDR ")) then
				emu.pause()
				dumpADDR(args[2], args[3], args[4], tonumber(args[5]), tonumber(args[6]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "dumpMEM ")) then
				emu.pause()
				dumpMEM(args[2], args[3], tonumber(args[4]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "fastDumpMEM ")) then
				emu.pause()
				fastDumpMEM(args[2], args[3])
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "dumpSHA ")) then
				emu.pause()
				dumpSHA(args[2], args[3], tonumber(args[4]))
				emu.unpause()
				print("OK")
				ln.historyadd(cmd)
			end

			if (string.starts(cmd, "test")) then
				test()
			end

			if (string.starts(cmd, "exec ")) then
				pcall(load(args[2]))
			end

			cmd = ""
			args = {}
		end
		conth:start(scr)
		started = true
	end)
end

return exports
