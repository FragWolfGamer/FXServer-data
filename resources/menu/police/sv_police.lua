RegisterServerEvent('wk_actionmenu:cuffGranted')
AddEventHandler('wk_actionmenu:cuffGranted', function(t)
	TriggerClientEvent('wk_actionmenu:getArrested', t)
end)




