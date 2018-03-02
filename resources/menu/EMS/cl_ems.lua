--RegisterNetEvent("revive")
--AddEventHandler("revive", function()
--if (IsEntityDead(ped)) then
--function revivePed(ped)
	--local playerPos = GetEntityCoords(ped, true)
--
	--NetworkResurrectLocalPlayer(playerPos, true, true, false)
	--SetPlayerInvincible(ped, false)
	--ClearPedBloodDamage(ped)
	--drawNotification("Player Revived")
	--else
	--drawNotification("Player Isn't Dead")
      --  end
 --end)

--RegisterNetEvent('revive')
--AddEventHandler('revive',function()
  --  local myPed = GetPlayerPed(-1)
    --local vehicle = GetVehiclePedIsIn(myPed, true)
    --local islocked = GetVehicleDoorLockStatus(vehicle)
--
  --      if (islocked  == 1) then 
    --        SetVehicleDoorsLocked(vehicle, 2)
      --      drawNotification("test 2")
        --elseif (islocked  == 2) then
          --  SetVehicleDoorsLocked(vehicle, 1)
            --SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
            --drawNotification("test")
        --end
 --end)
 
RegisterNetEvent("revive")
AddEventHandler("revive", function()
ped = GetPlayerPed(-1)
local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
NetworkResurrectLocalPlayer(x, y, z, true, true, false)
TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." has been revived.")
end)
--GetBlipFromEntity
-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)
		-- for id = 0, 100 do
			-- if NetworkIsPlayerActive( id ) then
			-- ped = GetPlayerPed( id )
			-- blip = GetBlipFromEntity( ped )
			-- SetBlipAlpha(blip, 0.5)
			-- end
		-- end
	-- end
	
	-- end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPeds = GetPlayerPed(-1)
		DisplayRadar(false)
		if GetEntityHealth(playerPeds) < 130 then
			SetEntityHealth(playerPeds, 130)
		end
		end
		end)