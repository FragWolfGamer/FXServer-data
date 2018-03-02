RegisterServerEvent("revive")
AddEventHandler("revive", function()
local s = source
TriggerClientEvent( 'revive', s )
end)