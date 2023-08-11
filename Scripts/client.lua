local bridge = peripheral.find("rsBridge")
local items = bridge.listItems()

local body = "measurement,item=host1 field1=2i,field2=2.0";

for index, item in pairs(items) do
    local name = item["name"]
    local amount = item["amount"]
    local isCraftable = item["isCraftable"]

    local itemData = "measurement,";
    itemData = itemData .. "item="..name.."_"..index
    itemData = itemData .. " "
    itemData = itemData .. "name="..name
    itemData = itemData .. "amount="..amount
    itemData = itemData .. "isCraftable="..isCraftable

    body = body..itemData.."\n";
end

local headers = {
    [ "Authorization" ] = "Token IYW-b_B1ImVPW1i09j4nafgkv4z1cCQdQn_P04JULaYdWgHNjn5JH883cczJIPrxuZg3w7nmkiPl0kyS7DuTXA=="
}

local request = http.request{
                    url = "https://influx.nussi.net/write?db=rf",
                    body = body,
                    headers = headers,
                    method = "POST"
                }
