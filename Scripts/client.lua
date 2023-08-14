
function bool_to_number(value)
    return value and 1 or 0
end

function itemToMeasurement(item)
    return "measurement,item=\""..item["name"].."\" name=\""..item["name"].."\",amount="..item["amount"]..",isCraftable="..bool_to_number(item["isCraftable"]);
end

function sendData(body)
    local headers = {
        [ "Authorization" ] = "Token IYW-b_B1ImVPW1i09j4nafgkv4z1cCQdQn_P04JULaYdWgHNjn5JH883cczJIPrxuZg3w7nmkiPl0kyS7DuTXA=="
    }
    
    request = http.post("https://influx.nussi.net/write?db=rf", body, headers)
    -- print("=== REQUEST ===")
    -- print(request)

    print("Sent data!")
end



local bridge = peripheral.find("rsBridge")
while true do
    
    local data = bridge.listItems()
    local items = {}

    for index, item in pairs(data) do
        local index = item["name"]

        current = items[index]
        if current == nil then
            current = item
        else
            current["amount"] = current["amount"] + item["amount"]
        end
        items[index] = current


    end


    local body = ""
    for name, item in pairs(items) do
        body = body..itemToMeasurement(item).."\n"
    end

    sendData(body)
    
    os.sleep( 3 )
end
