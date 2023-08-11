local bridge = peripheral.find("rsBridge")

local request = http.get("http://192.168.0.106:8086/metrics")
local data = request.readAll()
print(data)