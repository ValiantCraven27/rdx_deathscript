RDX, Death, DSC = nil,{Counter = 30, HCore = 50, SCore = 50, DCore = 50, Weakness = false, Invincible = 5000},{} -- Settings
Citizen.CreateThread(function() while RDX == nil do TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end) Citizen.Wait(0) end while RDX.GetPlayerData().job == nil do Citizen.Wait(100) end
	RDX.PlayerData = RDX.GetPlayerData()
end)

-- Weakness not implemented yet
local StoreCoords  = 0
local Counter =  Death.Counter
local SetHCore = Death.SHore
local SetSCore = Death.SCore
local SetDCore = Death.DCore
local player

Citizen.CreateThread(function() -- Stop Auto Respawn
local coords	= GetEntityCoords(PlayerPedId())  
Citizen.Wait(1000)
exports.spawnmanager:setAutoSpawn(false)
--StoreCoords  = RDX.GetPlayerData('lastPosition', {x = coords.x,y = coords.y,z = coords.z})
end)

Citizen.CreateThread(function() -- saveCoords
  while true do
    --Citizen.Wait(1)
     player = GetPlayerPed(-1)
    if not IsPlayerDead(player) and not IsPedSwimming(player) and not IsEntityInWater(PlayerPedId())then
        StoreCoords  = GetEntityCoords(PlayerPedId())                                        
    end    
    Citizen.Wait(5000)
  end  
end)

Citizen.CreateThread(function() -- Death Listener
  while true do	
      player = GetPlayerPed(-1)
    if IsPlayerDead(player) and GetEntityHealth(player) < 1 then       
        DSC:CallTimer(player)                                             
    end
    Citizen.Wait(300)
  end
end)

Citizen.CreateThread(function() -- Death Listener
  while true do	
    Citizen.Wait(1)
      player = GetPlayerPed(-1)
    if IsPlayerDead(player) and GetEntityHealth(player) < 1 then 
        DSC:DrawTxt(" Reviving in "..Counter.."",0.50, 0.95, 0.5, 0.5, true, 255, 255, 255, 255, true)                                                    
    end   
  end   
end)
 
function DSC:Heartbeat(player) -- Timer  
  if IsPlayerDead(player) then  
      TriggerEvent('rdx:playsound', "heartbeat", 0.5)   
      Citizen.Wait(15000)
    if Counter > 13 and IsPlayerDead(player) then  
        TriggerEvent('rdx:playsound', "heartbeat", 0.5)  
    end
  end
end

function DSC:CallTimer(player) -- Timer
  Counter = Death.Counter 
  while Counter > 0 do    
    Citizen.Wait(1000)
    Counter = Counter - 1
    if Counter < 1 then
       DSC:ReviveDeadPlayer(player)
    end
   end
end

RegisterNetEvent('rdx:playsound') -- Play Sounds
AddEventHandler('rdx:playsound', function(sound,volume)  
    TriggerServerEvent('InteractSound_SV:PlayOnSource',sound, volume) 
end)

RegisterNetEvent('rdx_revive:player') -- admin call
AddEventHandler('rdx_revive:player', function()
	local playerPed = PlayerPedId()
  DSC:ReviveDeadPlayer(playerPed)   
end)

RegisterNetEvent('rdx_kill:player') -- admin call
AddEventHandler('rdx_kill:player', function()
	local playerPed = PlayerPedId()
	    if not IsPlayerDead(playerPed) then
      ApplyDamageToPed(playerPed,500,0,0,0)
      end	
end)

-- Revive
function DSC:ReviveDeadPlayer(player)
  if IsPlayerDead(player) then
      DoScreenFadeOut(1000)             
      Citizen.Wait(2000)
      NetworkResurrectLocalPlayer(StoreCoords, 100.00, true, true, false )        
      TriggerServerEvent("rdx_skin:loadSkin")
      TriggerServerEvent("rdx_clothing:loadClothes")
      Citizen.InvokeNative(0xC6258F41D86676E0,player, 0, Death.HCore) --core
      Citizen.InvokeNative(0xC6258F41D86676E0,player, 1, Death.SCore) --core  
      --Citizen.InvokeNative(0xC6258F41D86676E0,player, 2, Death.DCore) --core
      Citizen.Wait(3000)  
      DoScreenFadeIn(3000)       
      NetworkSetLocalPlayerInvincibleTime(Death.Invincible) 
  end    
end

function DSC:DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
  local str = CreateVarString(10, "LITERAL_STRING", str)
  SetTextScale(w, h)
  SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
  SetTextCentre(centre)
  if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end 
  Citizen.InvokeNative(0xADA9255D, 1);
  DisplayText(str, x, y)
end

RegisterCommand("die",function()
    local player             = PlayerPedId()
    local playerCoords       = GetEntityCoords(player)
      if not IsPlayerDead(player) then
         ApplyDamageToPed(player,500,0,0,0)
      end        
end) 


