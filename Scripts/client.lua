# local bridge = peripheral.find("rsBridge")
local request = http.get("https://influx.nussi.net/metrics")
print(request.readAll())
-- => HTTP is working!
request.close()