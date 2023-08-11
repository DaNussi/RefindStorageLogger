# local bridge = peripheral.find("rsBridge")
local request = http.get("http://192.168.0.106:8086/metrics")
print(request.readAll())
-- => HTTP is working!
request.close()