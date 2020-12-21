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
function stopServer(port)
	local modem = peripheral.wrap(getModem())
	modem.close(port)
end
io.write("Enter server port: ")
local port = tonumber(io.read())
stopServer(port)
io.write("\nServer on port ", port, " has been closed.\n")