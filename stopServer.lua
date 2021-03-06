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
	if modem.isOpen(port) then
		modem.close(port)
		print("Server on port ",port," has been closed")
	else
		print("Server on port ",port," is not open!")
	end
end
io.write("Enter server port: ")
local port = tonumber(io.read())
io.write("\n")
stopServer(port)