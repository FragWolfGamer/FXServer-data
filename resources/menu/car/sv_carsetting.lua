RegisterServerEvent("lock")
AddEventHandler("lock", function()
local s = source
TriggerClientEvent( 'lock', s )
end)

RegisterServerEvent("save")
AddEventHandler("save", function()
local s = source
TriggerClientEvent( 'cl_carsetting_save', s )
end)