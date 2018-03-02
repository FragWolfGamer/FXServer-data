RegisterServerEvent("lockv")
AddEventHandler("lockv", function()
local s = source
TriggerClientEvent("lock" , s)
end)
