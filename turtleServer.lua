function getModem()
	local modemSide = ""
	periphs = peripheral.getNames()
	for i=1,table.getn(periphs),1 do
		if peripheral.getType(periphs[i]) == "modem" then
			modemSide = periphs[i]
		end
	end
	return modemSide
end
function Split(s, delimiter) -- Not my code, no touch
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
function waitForInstruct(port)
	local eventType, modemSide, senderChannel, replyChannel, message, senderDistance = os.pullEvent("modem_message")
	if replyChannel ~= senderChannel then
		-- Logic for replies will go here
		waitForInstruct(port)
	elseif string.find(message,"forward") then
		local stepsForward = 1
		if string.find(message," ") then
			stepsForward = tonumber(Split(message," ")[2])
		end
		if turtle.getFuelLevel() < stepsForward then
			local modem = peripheral.wrap(getModem())
			modem.transmit(replyChannel,senderChannel,"Not enough fuel")
		else
			for x = 1, stepsForward, 1 do
				turtle.forward()
			end
		end
		waitForInstruct(port)
	elseif string.find(message,"back") then
		local stepsBack = 1
		if string.find(message," ") then
			stepsBack = tonumber(Split(message," ")[2])
		end
		if turtle.getFuelLevel() < stepsBack then
			local modem = peripheral.wrap(getModem())
			modem.transmit(replyChannel,senderChannel,"Not enough fuel")
		else
			for x = 1, stepsBack, 1 do
				turtle.back()
			end
		end
		waitForInstruct(port)
	elseif string.find(message,"up") then
		local stepsUp = 1
		if string.find(message," ") then
			stepsUp = tonumber(Split(message," ")[2])
		end
		if turtle.getFuelLevel() < stepsUp then
			local modem = peripheral.wrap(getModem())
			modem.transmit(replyChannel,senderChannel,"Not enough fuel")
		else
			for x = 1, stepsUp, 1 do
				turtle.up()
			end
		end
		waitForInstruct(port)
	elseif string.find(message,"down") then
		local stepsDown = 1
		if string.find(message," ") then
			stepsDown = tonumber(Split(message," ")[2])
		end
		if turtle.getFuelLevel() < stepsDown then
			local modem = peripheral.wrap(getModem())
			modem.transmit(replyChannel,senderChannel,"Not enough fuel")
		else
			for x = 1, stepsDown, 1 do
				turtle.down()
			end
		end
		waitForInstruct(port)
	elseif string.find(message,"left") then
		local stepsLeft = 1
		if string.find(message," ") then
			stepsLeft = tonumber(Split(message," ")[2])
		end
		for x = 1, stepsLeft, 1 do
			turtle.turnLeft()
		end
		waitForInstruct(port)
	elseif string.find(message,"right") then
		local stepsRight = 1
		if string.find(message," ") then
			stepsRight = tonumber(Split(message," ")[2])
		end
		for x = 1, stepsRight, 1 do
			turtle.turnRight()
		end
		waitForInstruct(port)
	elseif string.find(message,"stop") then
		local modem = peripheral.wrap(getModem())
		modem.close(port)
		local stopResponse = "Server on port " .. port .. " has been closed"
		modem.transmit(replyChannel,senderChannel,stopResponse)
	end
end
function turtleServer(port)
	local modem = peripheral.wrap(getModem())
	if modem.isOpen(port) then
		print("Server on port ",port," is already open!")
	else
		modem.open(port)
		print("Turtle server started on port ",port)
		waitForInstruct(port)
	end
end
io.write("Enter server port: ")
local port = tonumber(io.read())
io.write("\n")
turtleServer(port)