local headers = {
    [ "Authorization" ] = "Token IYW-b_B1ImVPW1i09j4nafgkv4z1cCQdQn_P04JULaYdWgHNjn5JH883cczJIPrxuZg3w7nmkiPl0kyS7DuTXA=="
}

request = http.post("https://influx.nussi.net/write?db=rf", "measurement,item=host1 field1=2i,field2=2.0", headers)
print("=== REQUEST ===")
for k,v in pairs(request) do
   print(k.." = "..v) 
end
request.close()
