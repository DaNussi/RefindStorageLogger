local bridge = peripheral.find("rsBridge")
local items = bridge.listItems()

for index, item in pairs(items) do
    if(index == 1) then
        for k,v in pairs(item) do
            print(tostring(k)..' = '..tostring(v))
        end
    end
end