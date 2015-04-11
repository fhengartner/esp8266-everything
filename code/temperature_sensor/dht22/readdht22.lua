humi=-1
temp=-1
checksumFail=true

PIN = 4 --  data pin, GPIO2

--load DHT22 module and read sensor
function ReadDHT22()
	t,h = dofile("dht22.lua").read(PIN, true)
	if t == nil then
		if h == 1 or h == 2 then
			print("Timing error, aborting DHT read.")
		elseif h == 3 then
			checksumFail=true
			print("Checksum fail, aborting DHT read.")
          else
               print("Unkown error.")
               print(t)
               print(h)
		end
		return
	end
	checksumFail=false
     humi=h/10
	temp=t/10
	print("Humidity:    "..humi.."%")
	print("Temperature: "..temp.." deg C")
end

ReadDHT22()

-- read every 60s
tmr.alarm(1,60000, 1, function() ReadDHT22() end)
