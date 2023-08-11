local bridge = peripheral.find("rsBridge")
local items = bridge.listItems()

for index, item in pairs(items) do

    local name = item["name"]
    local amount = item["amount"]
    local isCraftable = item["isCraftable"]
    

    if(index == 1) then
        for k,v in pairs(item["nbt"]) do
            print(tostring(k)..' = '..tostring(v))
        end
    end
end