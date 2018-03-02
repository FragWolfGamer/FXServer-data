RegisterServerEvent("sv_civilplayerCrouch")
AddEventHandler("sv_civilplayerCrouch", function()
local s = source
TriggerClientEvent( 'cl_civilplayerCrouch', s )
end)

RegisterServerEvent("sv_civilhandsup")
AddEventHandler("sv_civilhandsup" , function()
local s = source
TriggerClientEvent("cl_civilHandsup", s)
end)