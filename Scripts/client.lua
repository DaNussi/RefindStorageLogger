local token = ""

function bool_to_number(value)
    return value and 1 or 0
end

function itemToMeasurement(item)
    return "measurement,item=\""..item["name"].."\" name=\""..item["name"].."\",amount="..item["amount"]..",isCraftable="..bool_to_number(item["isCraftable"]);
end

function sendData(body)
    local headers = {
        [ "Authorization" ] = "Token "..token
    }
    
    request = http.post("https://influx.nussi.net/write?db=rf", body, headers)
    print("Request: "..#request)
    print("Sent data!")
end

function GetTableLng(tbl)
    local getN = 0
    for n in pairs(tbl) do 
      getN = getN + 1 
    end
    return getN
  end

local bridge = peripheral.find("rsBridge")
local oldItems = {}
while true do
    print("")
    print("")
    print("")
    print("")
    local data = bridge.listItems()
    local items = {}

    print("=== Indexing Items ===")
    for index, item in pairs(data) do
        local index = item["name"]

        local current = items[index]
        if current == nil then
            current = item
            -- print("+ "..index..current["amount"])
        else
            current["amount"] = current["amount"] + item["amount"]
            -- print("~ "..index..current["amount"])
        end
        items[index] = current
    end
    print("Total: "..GetTableLng(items))
    print("")


    print("=== Rremoving Trash ===")
    local comp = items
    items = {}
    for name, item in pairs(comp) do
        
        local current = oldItems[name]
        if current == nil then
            items[name] = item
            oldItems[name] = item
            print("+ "..name..item["amount"])
        else
            if current["amount"] ~= item["amount"] then
                items[name] = item
                oldItems[name] = item
                -- print("~ "..name..item["amount"])
            end
        end
    end
    print("Changes: "..GetTableLng(items))
    print("")


    print("=== Building Body ===")
    local body = ""
    for name, item in pairs(items) do
        if item ~= nil then
            local itemData = itemToMeasurement(item)
            body = body..itemData.."\n"
            -- print("# "..itemData)
        end
    end
    print("Length: "..#body)
    print("")

    print("=== Sending Data ===")
    sendData(body)
    print("")

    
    os.sleep( 3 )
end
