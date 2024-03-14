
local ox_inventory = exports.ox_inventory

ESX.RegisterServerCallback("fdocs:getJob", function(source, cb) 
    local xPlayer = ESX.GetPlayerFromId(source)
    cb(xPlayer.getJob(), xPlayer.getName())
end) 

RegisterServerEvent('fdocs:add')
AddEventHandler('fdocs:add', function(meta)
    exports.ox_inventory:RemoveItem(source, 'document', 1, {}, slot)
    exports.ox_inventory:AddItem(source, 'document', 1, meta)
end)