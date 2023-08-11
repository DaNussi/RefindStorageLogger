local request = http.get("https://raw.githubusercontent.com/DaNussi/RefindStorageLogger/master/Scripts/client.lua")
local data = request.readAll()
local fileName = "client.lua"

if fs.exists(fileName) then
    fs.delete(fileName)
end

local file = fs.open(fileName, "w")
file.writeLine(data)
file.close() -- never forget to close a file!

-- => HTTP is working!
request.close()