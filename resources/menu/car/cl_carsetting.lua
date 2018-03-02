RegisterNetEvent("cl_carsetting_Hood")
AddEventHandler("cl_carsetting_Hood", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 4)
    if IsPedInAnyVehicle(myPed, false) then

    	if (doorAngle > 0.5) then
    		drawNotification("Hood closed") 
            SetVehicleDoorShut(vehicle, 4, 0)
    	 else
    	 	drawNotification("Hood opened")
            SetVehicleDoorOpen(vehicle, 4, 0)
    	end
    else
    	drawNotification("you are not in a car")
    end
end)

RegisterNetEvent("cl_carsetting_Trunk")
AddEventHandler("cl_carsetting_Trunk", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 5)
    if IsPedInAnyVehicle(myPed, false) then
   		if (doorAngle > 0.5) then
   			drawNotification("Trunk closed") 
            SetVehicleDoorShut(vehicle, 5, 0)
     	else
     		drawNotification("Trunk opened")
            SetVehicleDoorOpen(vehicle, 5, 0)
    	end
    else
    	drawNotification("you are not in a car")
    end
end)

RegisterNetEvent("cl_carsetting_doortopleft")
AddEventHandler("cl_carsetting_doortopleft", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
       if IsPedInAnyVehicle(myPed, false) then

    if (doorAngle > 0.5) then 
    		drawNotification("door closed")
            SetVehicleDoorShut(vehicle, 0, 0)
     else
     	drawNotification("door opened")
            SetVehicleDoorOpen(vehicle, 0, 0)
    end

else
	drawNotification("you are not in a car")
end
end)

RegisterNetEvent("cl_carsetting_doortopright")
AddEventHandler("cl_carsetting_doortopright", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 1)
        if IsPedInAnyVehicle(myPed, false) then

    if (doorAngle > 0.5) then 
    	drawNotification("door closed")
            SetVehicleDoorShut(vehicle, 1, 0)
     else
     	drawNotification("door opened")
            SetVehicleDoorOpen(vehicle, 1, 0)
    end
	else
		drawNotification("you are not in a car")
	end
end)

RegisterNetEvent("cl_carsetting_doorbuttonright")
AddEventHandler("cl_carsetting_doorbuttonright", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 3)
        if IsPedInAnyVehicle(myPed, false) then

    if (doorAngle > 0.5) then 
    	drawNotification("door closed")
            SetVehicleDoorShut(vehicle, 3, 0)
     else
     	drawNotification("door opened")
            SetVehicleDoorOpen(vehicle, 3, 0)
    end
else
	drawNotification("you are not in a car")
end
end)

RegisterNetEvent("cl_carsetting_doorbuttonleft")
AddEventHandler("cl_carsetting_doorbuttonleft", function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, false)
    local doorAngle = GetVehicleDoorAngleRatio(vehicle, 2)
        if IsPedInAnyVehicle(myPed, false) then

    if (doorAngle > 0.5) then 
    	drawNotification("door closed")
            SetVehicleDoorShut(vehicle, 2, 0)
     else
     	drawNotification("door opened")
            SetVehicleDoorOpen(vehicle, 2, 0)
    end
else
	drawNotification("you are not in a car")
end
end)



RegisterNetEvent("cl_carsetting_EngineToggle")
AddEventHandler("cl_carsetting_EngineToggle", function()
    local  player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)

     if IsPedInAnyVehicle(player, false) then

    	if IsVehicleEngineOn(vehicle) then
        	SetVehicleEngineOn(vehicle, false, false, true)
   		 else
			SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
    	end
    else
    	drawNotification(" you are not in a car")
    end
end)



RegisterNetEvent("cl_carsetting_dropwindow")
AddEventHandler("cl_carsetting_dropwindow", function()
    local windowup = true
    local playerPed = GetPlayerPed(-1)

    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
        if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
            SetEntityAsMissionEntity( playerCar, true, true )
        
            if ( windowup) then
                RollDownWindow(playerCar, 0)
                TriggerEvent('chatMessage', '', {255,0,0}, 'Windows down')
                windowup = false

            end
        end
    else
       drawNotification("you are not in a car")
    end
end)

RegisterNetEvent("cl_carsetting_dropwindow2")
AddEventHandler("cl_carsetting_dropwindow2", function()

local windowup = true
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local playerCar = GetVehiclePedIsIn(playerPed, false)
        if ( GetPedInVehicleSeat( playerCar, -1 ) == playerPed ) then 
            SetEntityAsMissionEntity( playerCar, true, true )
        
            if ( windowup ) then
                RollUpWindow(playerCar, 0)
                TriggerEvent('chatMessage', '', {255,0,0}, 'Windows up')
                windowup = true
            end
        end
    else
        drawNotification("you are not in a car")
    end
end)


RegisterNetEvent("cl_carsetting_carfix")
AddEventHandler("cl_carsetting_carfix", function()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleEngineHealth(vehicle, 1000)
        SetVehicleEngineOn( vehicle, true, true )
        SetVehicleFixed(vehicle)
    else
    	drawNotification(" you are not in a car")
    end
end)


RegisterNetEvent("cl_carsetting_cleancar")
AddEventHandler("cl_carsetting_cleancar", function()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        SetVehicleDirtLevel(vehicle, 0)
       else
       	drawNotification("you are not in a car ")
    end
end)

RegisterNetEvent("cl_carsetting_dvslet")
AddEventHandler("cl_carsetting_dvslet", function()
local distanceToCheck = 5.0

    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                    drawNotification( "~r~Unable to delete vehicle, try again." )
                else 
                    drawNotification( "Vehicle deleted." )
                end 
            else 
                drawNotification( "You must be in the driver's seat!" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                    drawNotification( "~r~Unable to delete vehicle, try again." )
                else 
                    drawNotification( "Vehicle deleted." )
                end 
            else 
                drawNotification( "You must be in or near a vehicle to delete it." )
            end 
        end 
    end 
end)


function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

-- L O C K --
RegisterNetEvent('lockLights')
AddEventHandler('lockLights',function()
local vehicle = saveVehicle
	StartVehicleHorn(vehicle, 100, 1, false)
	SetVehicleLights(vehicle, 2)
	Wait (200)
	SetVehicleLights(vehicle, 0)
	StartVehicleHorn(vehicle, 100, 1, false)
	Wait (200)
	SetVehicleLights(vehicle, 2)
	Wait (400)
	SetVehicleLights(vehicle, 0)
end)

RegisterNetEvent('lock')
AddEventHandler('lock',function()
    local myPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(myPed, true)
    local islocked = GetVehicleDoorLockStatus(vehicle)

        if (islocked  == 1) then 
            SetVehicleDoorsLocked(vehicle, 2)
            drawNotification("You have locked your car")
			TriggerEvent('lockLights')
        elseif (islocked  == 2) then
            SetVehicleDoorsLocked(vehicle, 1)
            SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
			riggerEvent('lockLights')
            drawNotification("You have unlocked your car")
        end
 end)
-- S A V E --
RegisterNetEvent('cl_carsetting_save')
AddEventHandler('cl_carsetting_save',function() 
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then 
		if  saved == true then
			--remove from saved.
			saveVehicle = nil
			RemoveBlip(targetBlip)
			SetEntityAsNoLongerNeeded(vehicle)
			ShowNotification("Saved vehicle ~r~removed~w~.")
			saved = false
		else
			RemoveBlip(targetBlip)
			saveVehicle = GetVehiclePedIsIn(player,true)
			local vehicle = saveVehicle
			SetEntityAsMissionEntity(vehicle, true, true)
			targetBlip = AddBlipForEntity(vehicle)
			SetBlipSprite(targetBlip,225)
			ShowNotification("This ~y~" .. GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. "~w~ is now your~g~ saved ~w~vehicle.")
			saved = true
		end
	end
end)