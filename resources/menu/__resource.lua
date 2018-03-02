--[[-----------------------------------------------------------------------

	ActionMenu - Version 1.0 
	Created by WolfKnight
	Additional help from TheStonedTurtle, Briglair, and lowheartrate. 

	NOTE: This is an example resource, which you must add to in order for 
	it to become useable in your server/gamemode. Each area has been 
	commented for your understanding. 

-----------------------------------------------------------------------]]--

-- Set the resource manifest version 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Tell FiveM's NUI system what the main html file is for this resource 
ui_page "nui/ui.html"

-- Add the files that need to be used/loaded
files {
	"nui/ui.html",
	"nui/ui.js", 
	"nui/ui.css"
}

-- Initiate the clientside lua script 
client_script 'cl_action.lua'


client_script 'car/cl_carsetting.lua'
server_script 'car/sv_carsetting.lua'

client_script 'civil/cl_civil.lua'
server_script 'civil/sv_civil.lua'

client_script 'police/cl_police.lua'
server_script 'police/sv_police.lua'

client_script 'lock/cl_lock.lua'
server_script 'lock/sv_lock.lua'

client_script 'save/cl_save.lua'
server_script 'save/sv_save.lua'

client_script 'advert/cl_advert.lua'
server_script 'advert/sv_advert.lua'

