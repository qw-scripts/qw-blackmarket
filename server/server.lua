local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    TriggerClientEvent('qw-blackmarket:client:openMarket', source)
end)

QBCore.Functions.CreateCallback('qw-blackmarket:server:checkMoneyNeeded', function(source, cb, price, currency) 

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if Player.Functions.RemoveMoney(currency, price, "blackmarket-buy-items") then -- REMINDER: BANK LETS YOU GO NEGATIVE
        return cb(true)
    else
        return cb(false)
    end
end)

RegisterNetEvent('qw-blackmarket:server:pickupItem', function(items)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    for k, v in pairs(items) do
        if not Player.Functions.AddItem(v, 1, nil, {}) then return end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add')
    end
end)