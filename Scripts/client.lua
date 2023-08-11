function bool_to_number(value)
    return value and 1 or 0
end

local bridge = peripheral.find("rsBridge")
local items = bridge.listItems()
local body = "";

for index, item in pairs(items) do
    local name = item["name"]
    local amount = item["amount"]
    local isCraftable = item["isCraftable"]

    local itemData = "measurement,";
    itemData = itemData .. "item="..name.."_"..index
    itemData = itemData .. " "
    itemData = itemData .. "name="..name
    itemData = itemData .. ","
    itemData = itemData .. "amount="..amount
    itemData = itemData .. ","
    itemData = itemData .. "isCraftable="..bool_to_number(isCraftable)

    print(itemData)

    body = body..itemData.."\n";
end

local headers = {
    [ "Authorization" ] = "Token IYW-b_B1ImVPW1i09j4nafgkv4z1cCQdQn_P04JULaYdWgHNjn5JH883cczJIPrxuZg3w7nmkiPl0kyS7DuTXA=="
}

request = http.post("https://influx.nussi.net/write?db=rf", body, headers)
print("=== REQUEST ===")
for k,v in pairs(request) do
   print(k.." = "..v) 
end
request.close()
