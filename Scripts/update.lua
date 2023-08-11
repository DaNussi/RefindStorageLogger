local bridge = peripheral.find("rsBridge")

local request = http.get("https://example.tweaked.cc")
print(request.readAll())
-- => HTTP is working!
request.close()