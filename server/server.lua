RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)

RDX.RegisterCommand('revive', 'admin', function(source, args)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('rdx_revive:player', tonumber(args[1]))
			
			TriggerClientEvent('rdx_kill:player', tonumber(args[1]))
			TriggerClientEvent('chat:addMessage', -1, { args = { 'A admin has revived '..GetPlayerName(tonumber(args[1]))..'.' } })
		end	
	end
end, function(source, args)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

RDX.RegisterCommand('death', 'admin', function(source, args)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('rdx_kill:player', tonumber(args[1]))
			TriggerClientEvent('chat:addMessage', -1, { args = { 'This is an admin warning for '..GetPlayerName(tonumber(args[1]))..'.' } })
		end	
	end

end, function(source, args)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } }) end)

RDX.RegisterCommand('deathkick', 'admin', function(source, args)
		if args[1] ~= nil then
			if GetPlayerName(tonumber(args[1])) ~= nil then
				TriggerClientEvent('rdx_kill:player', tonumber(args[1]))
				Citizen.Wait(5000)
				DropPlayer((tonumber(args[1])), "has been kicked by an admin")
				TriggerClientEvent('chat:addMessage', -1, { args = { ''..GetPlayerName(tonumber(args[1]))..' has been kicked by an admin' } })
			end	
		end
	
	end, function(source, args)
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } }) end)




	
