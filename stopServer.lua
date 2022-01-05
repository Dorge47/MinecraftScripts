function stopServer(port)
	local modem = peripheral.find("modem")
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