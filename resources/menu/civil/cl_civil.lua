function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent( 'cl_civilKneelHU' )
AddEventHandler( 'cl_civilKneelHU', function()
    local player = GetPlayerPed( -1 )
    if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "random@arrests" )
        loadAnimDict( "random@arrests@busted" )
        if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
            TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (3000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
        else
            TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (4000)
            TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (500)
            TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            Wait (1000)
            TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
        end     
    end
end )

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(0,21,true)
        end
    end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(0,21,true)
		end
	end
end)


local crouched = false

-- Register the network event(s)
RegisterNetEvent( 'cl_civilplayerCrouch' )
AddEventHandler( 'cl_civilplayerCrouch', function()
    -- Get the local ped 
    local ped = GetPlayerPed( -1 )

    -- Make sure the player is alive
    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 

        -- Here we create thread, but notice how we don't have a while loop.
        -- This is because we use it to Wait for the animation dictionary to load.
        Citizen.CreateThread( function()        
            -- Request the crouched animation set     
            RequestAnimSet( "move_ped_crouched" )

            -- Wait until it has loaded 
            while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                Citizen.Wait( 100 )
            end 

            -- We inverse the crouch variable for the next time it is called 
            if ( crouched == true ) then 
                ResetPedMovementClipset( ped, 0 )
                crouched = false 
            elseif ( crouched == false ) then
                SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                crouched = true 
            else
                Citizen.Trace( "Crouch Script Error: variable 'crouched' not found or not a boolean value." )
            end 
        end )
    end 
end )


RegisterNetEvent( 'cl_civil_dropwep' )
AddEventHandler( 'cl_civil_dropwep', function()
    local ped = PlayerPedId()
            local wep = GetSelectedPedWeapon(ped)
            SetPedDropsWeaponsWhenDead(ped, true)
            RequestAnimDict("mp_weapon_drop")
            if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) and not IsPauseMenuActive() and IsPedArmed(ped, 7) then -- INPUT_DROP_WEAPON (F7)
            TaskPlayAnim(ped, "mp_weapon_drop", "drop_bh", 8.0, 2.0, -1, 0, 2.0, 0, 0, 0 )
            SetPedDropsInventoryWeapon(ped, wep, 0, 2.0, 0, -1)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
            
            end
end)

RegisterNetEvent("cl_civilHandsup")
AddEventHandler("cl_civilHandsup" , function() 
    local lPed = GetPlayerPed(-1)
    if DoesEntityExist(lPed) then
        Citizen.CreateThread(function()
            RequestAnimDict("random@mugging3")
            while not HasAnimDictLoaded("random@mugging3") do
                Citizen.Wait(100)
            end
            
            if IsEntityPlayingAnim(lPed, "random@mugging3", "handsup_standing_base", 3) then
                ClearPedSecondaryTask(lPed)
                SetEnableHandcuffs(lPed, false)
                TriggerEvent("chatMessage", "", {255, 0, 0}, "hands down")
            else
                TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
                SetEnableHandcuffs(lPed, true)
                TriggerEvent("chatMessage", "", {255, 0, 0}, "hands up.")
            end     
        end)
    end
end)


RegisterNetEvent("cl_civilofficer") 
AddEventHandler("cl_civilofficer", function()
    local ped = PlayerPedId() 
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_Nightstick"), 1000, false) -- gives pistol to nearest player
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_Flashlight"), 1000, false) -- gives pistol to nearest player
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_StunGun"), 1000, false) -- gives pistol to nearest player
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 1000, false) -- gives pistol to nearest player
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 1000, false) -- gives pistol to nearest player
    GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH")) -- ads attachment to pistol of nearest player
	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_PI_FLSH")) -- ads attachment to pistol of nearest player
end)


RegisterNetEvent("cl_civilems") 
AddEventHandler("cl_civilems", function()
    local ped = PlayerPedId() 
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_StunGun"), 1000, false) -- gives pistol to nearest player
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BATTLEAXE"), 1000, false) -- gives pistol to nearest player
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 1000, false) -- gives pistol to nearest player
end)


