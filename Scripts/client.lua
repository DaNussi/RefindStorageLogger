# local bridge = peripheral.find("rsBridge")
print(http.get("http://192.168.0.106:8086/metrics").readAll())