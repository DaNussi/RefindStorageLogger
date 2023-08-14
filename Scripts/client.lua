local arg = { ... }

function bool_to_number(value)
    return value and 1 or 0
end

function itemToMeasurement(item)
    return "measurement,item=\""..item["name"].."\" name=\""..item["name"].."\",amount="..item["amount"]..",isCraftable="..bool_to_number(item["isCraftable"]);
end

function sendData(body)
    local headers = {
        [ "Authorization" ] = "Token "..arg[1]
    }
    
    print("Body: "..body)
    request = http.post("https://influx.nussi.net/write?db=rf", body, headers)
    print("Request: "..request)
    print("Sent data!")
end



local bridge = peripheral.find("rsBridge")
local oldItems = {}
while true do
    
    local data = bridge.listItems()
    local items = {}

    print("=== Indexing Items ===")
    for index, item in pairs(data) do
        local index = item["name"]

        local current = items[index]
        if current == nil then
            current = item
            print("+ "..index..current["amount"])
        else
            current["amount"] = current["amount"] + item["amount"]
            print("~ "..index..current["amount"])
        end
        items[index] = current


    end


    print("=== Rremoving Trash ===")
    for name, item in pairs(items) do
        
        local current = oldItems[name]
        if current == nil then
            oldItems[name] = item
            print("+ "..name..item["amount"])
        else
            if current["amount"] == item["amount"] then
                table.remove(item, name)
            else
                print("~ "..name..item["amount"])
            end
        end

    end


    print("=== Sending data ===")
    local body = ""
    for name, item in pairs(items) do
        local itemData = itemToMeasurement(item)
        body = body..itemData.."\n"
        print("# "..itemData)
    end

    
    os.sleep( 3 )
end
