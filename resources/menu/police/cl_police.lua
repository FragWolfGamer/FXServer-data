-----------------------------------------------------------------------------------------------------------------------------------------------------------------
local handCuffed = false


RegisterNetEvent('cl_police_cuff')
AddEventHandler('cl_police_cuff', function()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("cl_police:cuffGranted", GetPlayerServerId(t))
	else
		drawNotification("no ped near you !")
	end
end)


RegisterNetEvent('cl_police:getArrested')
AddEventHandler('cl_police:getArrested', function()
	handCuffed = not handCuffed
	if(handCuffed) then
		drawNotification("you are been cuffed")
	else
		drawNotification("you are been uncuffed")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	if (handCuffed) then

			local ped = GetPlayerPed( -1 )	
			DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
    end
   end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		
				
		if (handCuffed) then
			RequestAnimDict('mp_arresting')

			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(0)
			end

			local myPed = PlayerPedId(-1)
			local animation = 'idle'
			local flags = 49
			
			while(IsPedBeingStunned(myPed, 0)) do
				ClearPedTasksImmediately(myPed)
			end
			TaskPlayAnim(myPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
		end
	end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("cl_police_PutInVehicle")
AddEventHandler("cl_police_PutInVehicle", function()

	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		TriggerServerEvent("cl_police:forceEnterAsk", GetPlayerServerId(t), v)
	else
		drawNotification("No ped near you")
	end
end)

RegisterNetEvent('cl_police:forcedEnteringVeh')
AddEventHandler('cl_police:forcedEnteringVeh', function(veh)
	
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

		if vehicleHandle ~= nil then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
		end
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cl_police_UnseatVehicle")
AddEventHandler("cl_police_UnseatVehicle", function()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("cl_police:confirmUnseat", GetPlayerServerId(t))
	else
		drawNotification("No ped near you")
	end
end)

RegisterNetEvent('cl_police:unseatme')
AddEventHandler('cl_police:unseatme', function(t)
	local ped = GetPlayerPed(t)        
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2
   
	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

------------------------------------------------------------------------------------------------------------------------------------------------------------------

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('cl_policesetSpike')
AddEventHandler('cl_policesetSpike', function()
	drawNotification("Setting a spike on ground")
    SetSpikesOnGround()
end)


function SetSpikesOnGround()
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    spike = GetHashKey("P_ld_stinger_s")

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
    end

    local object = CreateObject(spike, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
      if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
         SetVehicleTyreBurst(veh, 0, true, 1000.0)
         SetVehicleTyreBurst(veh, 1, true, 1000.0)
		 Citizen.Wait(200)
         SetVehicleTyreBurst(veh, 2, true, 1000.0)
         SetVehicleTyreBurst(veh, 3, true, 1000.0)
		 Citizen.Wait(200)
         SetVehicleTyreBurst(veh, 4, true, 1000.0)
         SetVehicleTyreBurst(veh, 5, true, 1000.0)
         SetVehicleTyreBurst(veh, 6, true, 1000.0)
         SetVehicleTyreBurst(veh, 7, true, 1000.0)
         RemoveSpike()
       end
     end
   end
end)

RegisterNetEvent('cl_policedeleteSpike')
AddEventHandler('cl_policedeleteSpike', function()
	drawNotification("deleting spike from ground")
    DeleteSpike()
end)

function DeleteSpike()
   local ped = GetPlayerPed(-1)
   local pedCoord = GetEntityCoords(ped)
   if DoesObjectOfTypeExistAtCoords(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
      spike = GetClosestObjectOfType(pedCoord["x"], pedCoord["y"], pedCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
      SetEntityAsMissionEntity(spike, true, true)
      DeleteObject(spike)
   end
end

