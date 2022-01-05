function startServer(port)
	local modem = peripheral.find("modem")
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