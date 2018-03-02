



--[[------------------------------------------------------------------------

	ActionMenu 
	Created by WolfKnight
	Additional help from lowheartrate, TheStonedTurtle, and Briglair. 

------------------------------------------------------------------------]]--

-- Define the variable used to open/close the menu 
local menuEnabled = false 

local saved = false

controlsave_bool = false

--[[------------------------------------------------------------------------
    Resource Rename Fix 
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
    Citizen.Wait( 1000 )
    local resourceName = GetCurrentResourceName()
    SendNUIMessage( { resourcename = resourceName } )
end )

--[[------------------------------------------------------------------------
	ActionMenu Toggle
	Calling this function will open or close the ActionMenu. 
------------------------------------------------------------------------]]--
function ToggleActionMenu()
	-- Make the menuEnabled variable not itself 
	-- e.g. not true = false, not false = true 
	menuEnabled = not menuEnabled

	if ( menuEnabled ) then 
		-- Focuses on the NUI, the second parameter toggles the 
		-- onscreen mouse cursor. 
		SetNuiFocus( true, true )

		-- Sends a message to the JavaScript side, telling it to 
		-- open the menu. 
		SendNUIMessage({
			showmenu = true 
		})
	else 
		-- Bring the focus back to the game
		SetNuiFocus( false )

		-- Sends a message to the JavaScript side, telling it to
		-- close the menu.
		SendNUIMessage({
			hidemenu = true 
		})
	end 
end


function returnto()

SendNUIMessage ({
	showmenu = true 
	}) 

end

--[[------------------------------------------------------------------------
	ActionMenu HTML Callbacks
	This will be called every single time the JavaScript side uses the
	sendData function. The name of the data-action is passed as the parameter
	variable data. 
------------------------------------------------------------------------]]--
RegisterNUICallback( "ButtonClick", function( data, cb ) 
	if ( data == "engine" ) then 
		TriggerEvent("cl_carsetting_EngineToggle")

	elseif ( data == "lock") then
		TriggerServerEvent("sv_carsetting_lock")
		
	elseif ( data == "revive") then
		TriggerServerEvent("sv_ems_revive")
		
	elseif ( data == "store") then
		TriggerEvent("cl_advert_store")
		
	elseif ( data == "bank") then
		TriggerEvent("cl_advert_bank")
		
	elseif ( data == "traffic") then
		TriggerEvent("cl_advert_traffic")
		
	elseif ( data == "dealership") then
		TriggerEvent("cl_advert_dealership")
		
	elseif ( data == "lsc") then
		TriggerEvent("cl_advert_lsc")
		
	elseif ( data == "ammunation") then
		TriggerEvent("cl_advert_ammunation")
		
	elseif ( data == "taxi") then
		TriggerEvent("cl_advert_taxi")
		
	elseif ( data == "uber") then
		TriggerEvent("cl_advert_uber")
		
	elseif ( data == "chp") then
		TriggerEvent("cl_advert_chp")
		
	elseif ( data == "onlyadmin") then
		TriggerEvent("cl_advert_onlyadmin")
			
	elseif ( data == "save") then
		TriggerEvent("cl_carsetting_save")
		
	elseif ( data  == "Hood" ) then
	    TriggerEvent( 'cl_carsetting_Hood' )

	elseif ( data  == "Trunk" ) then

		TriggerEvent( 'cl_carsetting_Trunk' )

	elseif ( data  == "doortopleft" ) then

		TriggerEvent( 'cl_carsetting_doortopleft' )

   elseif ( data  == "doortopright" ) then

		TriggerEvent( 'cl_carsetting_doortopright' )

	elseif ( data  == "doorbuttonright" ) then

		TriggerEvent( 'cl_carsetting_doorbuttonright' )


	elseif ( data  == "doorbuttonleft" ) then

		TriggerEvent( 'cl_carsetting_doorbuttonleft' )

	elseif ( data == "carfix" ) then

		TriggerEvent("cl_carsetting_carfix")
                
		
	elseif ( data == "cleancar") then
		TriggerEvent("cl_carsetting_cleancar")


	elseif ( data == "dvslet") then
		
		TriggerEvent("cl_carsetting_dvslet")

	elseif ( data == "rollwindow") then

		TriggerEvent("cl_carsetting_dropwindow")

	elseif ( data == "rollwindow2") then

		TriggerEvent("cl_carsetting_dropwindow2")

	elseif ( data == "cuff" ) then

		TriggerEvent("cl_police_cuff")


	elseif ( data == "PutInVehicle") then

		TriggerEvent("cl_police_PutInVehicle")


	elseif ( data == "UnseatVehicle") then

		TriggerEvent("cl_police_UnseatVehicle")

	elseif ( data == "spikes" ) then
		TriggerServerEvent("sv_policesetSpike")

	elseif ( data == "deletespikes") then

		TriggerServerEvent("sv_policedeletespikes")

	elseif ( data =="playerCrouch") then

		TriggerServerEvent("sv_civilplayerCrouch")


	elseif ( data == "handsup") then

		TriggerServerEvent("sv_civilhandsup")


	elseif ( data == "onknee") then

		TriggerEvent("cl_civilKneelHU")


	elseif ( data == "dropweap") then

		TriggerEvent("cl_civil_dropwep")

	elseif ( data == "officer") then

		TriggerEvent("cl_civilofficer")

	elseif ( data == "ems") then

		TriggerEvent("cl_civilems")

	elseif ( data == "radarrc" ) then 
        TriggerEvent( 'wk:radarRC' )

	elseif ( data == "return") then

		returnto()
		return

	

	elseif ( data == "exit" ) then 
		-- We toggle the ActionMenu and return here, otherwise the function 
		-- call below would be executed too, which would just open the menu again 
		ToggleActionMenu()
		return

	end 

	-- This will only be called if any button other than the exit button is pressed
	ToggleActionMenu()
end )


--[[------------------------------------------------------------------------
	ActionMenu Control and Input Blocking 
	This is the main while loop that opens the ActionMenu on keypress. It 
	uses the input blocking found in the ES Banking resource, credits to 
	the authors.
------------------------------------------------------------------------]]--
Citizen.CreateThread( function()
	-- This is just in case the resources restarted whilst the NUI is focused. 
	SetNuiFocus( false )

	while true do 
		-- Control ID 20 is the 'Z' key by default 
		-- Use https://wiki.fivem.net/wiki/Controls to find a different key 
		if ( IsControlJustPressed( 1, 244 ) ) then 
			ToggleActionMenu()
		end 

	    if ( menuEnabled ) then
            local ped = GetPlayerPed( -1 )	

            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring( ped, true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end

		Citizen.Wait( 0 )
	end 
end )

function chatPrint( msg )
	TriggerEvent( 'chatMessage', "ActionMenu", { 255, 255, 255 }, msg )
end 








