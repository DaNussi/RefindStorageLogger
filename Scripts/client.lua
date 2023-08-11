local bridge = peripheral.find("rsBridge")
local items = bridge.listItems()

for k, v in pairs(items) do
    print(k)
end