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
	modem.open(port)
end
io.write("Enter server port: ")
local port = tonumber(io.read())
startServer(port)
io.write("\nServer started on port ", port, "\n")