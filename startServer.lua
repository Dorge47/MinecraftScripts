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
function startServer(port)
	local modem = peripheral.wrap(getModem())
	if modem.isOpen(port) then
		print("Server on port ",port," is already open!")
	else
		modem.open(port)
		print("Server started on port ",port)
	end
end
io.write("Enter server port: ")
local port = tonumber(io.read())
io.write("\n")
startServer(port)