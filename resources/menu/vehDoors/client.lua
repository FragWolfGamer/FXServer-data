-- C O N F I G --
interactionDistance = 3.5 --The radius you have to be in to interact with the vehicle.
lockDistance = 25 --The radius you have to be in to lock your vehicle.

--  V A R I A B L E S --
engineoff = false

-- E N G I N E --
RegisterNetEvent('engineoff')
AddEventHandler('engineoff',function() 
		local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = true
			ShowNotification("Engine ~r~off~s~.")
			while (engineoff) do
			SetVehicleUndriveable(vehicle,true)
			Citizen.Wait(300)
			end
		end
end)
RegisterNetEvent('engineon')
AddEventHandler('engineon',function() 
    local player = GetPlayerPed(-1)

        if (IsPedSittingInAnyVehicle(player)) then 
            local vehicle = GetVehiclePedIsIn(player,false)
			engineoff = false
			SetVehicleUndriveable(vehicle,false)
			ShowNotification("Engine ~g~on~s~.")
	end
end)
-- T R U N K --
RegisterNetEvent('trunk')
AddEventHandler('trunk',function() 
	local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,true)
			local isopen = GetVehicleDoorAngleRatio(vehicle,5)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,5,0,0)
				else
				SetVehicleDoorShut(vehicle,5,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end)
-- R E A R  D O O R S --
RegisterNetEvent('rdoors')
AddEventHandler('rdoors',function() 
	local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,true)
			local isopen = GetVehicleDoorAngleRatio(vehicle,2) and GetVehicleDoorAngleRatio(vehicle,3)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,2,0,0)
				SetVehicleDoorOpen(vehicle,3,0,0)
				else
				SetVehicleDoorShut(vehicle,2,0)
				SetVehicleDoorShut(vehicle,3,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end)

-- H O O D --
RegisterNetEvent('hood')
AddEventHandler('hood',function() 
	local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,true)
			local isopen = GetVehicleDoorAngleRatio(vehicle,4)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
			
			if distanceToVeh <= interactionDistance then
				if (isopen == 0) then
				SetVehicleDoorOpen(vehicle,4,0,0)
				else
				SetVehicleDoorShut(vehicle,4,0)
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
end)
-- L O C K --
RegisterNetEvent('lock')
AddEventHandler('lock',function()
	local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,true)
	local islocked = GetVehicleDoorLockStatus(vehicle)
	local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)	
			if distanceToVeh <= lockDistance then
				if (islocked == 1)then
				SetVehicleDoorsLocked(vehicle, 2)
				ShowNotification("You have locked your ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~.")
				else
				SetVehicleDoorsLocked(vehicle,1)
				ShowNotification("You have unlocked your ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~.")
				end
			else
				ShowNotification("~r~You must be near your vehicle to do that.")
			end
	end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end