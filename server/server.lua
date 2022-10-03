RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)

RDX.RegisterCommand('revive', 'admin', function(source, args)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('rdx_revive:player', tonumber(args[1]))
		end
	else
		TriggerClientEvent('rdx_revive:player', source)
	end
end, function(source, args)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

