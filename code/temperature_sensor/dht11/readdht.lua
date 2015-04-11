humi=-1
temp=-1
checksumFail=true

PIN = 4 --  data pin, GPIO2

--load DHT11 module and read sensor
function ReadDHT11()
	dht11 = require("dht11")
	dht11.read(PIN)
	t = dht11.getTemperature()
	h = dht11.getHumidity()
	checksumFail=dht11.getChecksumFail()
	humi=(h)
	temp=(t)
	--fare=((t*9/5)+32)
	print("Humidity:    "..humi.."%")
	print("Temperature: "..temp.." deg C")
	--print("Temperature: "..fare.." deg F")
	-- release module
	dht11 = nil
	package.loaded["dht11"]=nil
end

ReadDHT11()

-- read every 60s
tmr.alarm(1,60000, 1, function() ReadDHT11() end)
