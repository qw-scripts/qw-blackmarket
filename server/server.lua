local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem(Config.ItemName, function(source, item)
    TriggerClientEvent('qw-blackmarket:client:openMarket', source)
end)

QBCore.Functions.CreateCallback('qw-blackmarket:server:checkCryptoWorth', function(source, cb, cryptoType)
    if Config.Crypto.CryptoType == 'qb' then
        local cryptoWorth = exports['qb-crypto']:GetCurrentCryptoWorth()
        cb(cryptoWorth)
    else
        local cryptoWorth = exports['qb-phone']:GetCryptoValue(Config.Crypto.RenewedCryptoType)
        cb(cryptoWorth)
    end
end)

QBCore.Functions.CreateCallback('qw-blackmarket:server:checkMoneyNeeded', function(source, cb, price, currency) 

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if currency == 'crypto' and Config.Crypto.Enabled then
        if Config.Crypto.CryptoType == 'qb' then
            local cryptoWorth = exports['qb-crypto']:GetCurrentCryptoWorth()
            if Player.Functions.RemoveMoney('crypto', price / cryptoWorth, "blackmarket-crypto-buy-items") then
                return cb(true)
            else
                return cb(false)
            end
        elseif Config.Crypto.CryptoType == 'renewed' then
            -- TODO: Add support for renewed crypto
            local Crypto = Player.PlayerData.metadata.crypto

            if not Crypto then return end
            
            local renewedCryptoWorth = exports['qb-phone']:GetCryptoValue(Config.Crypto.RenewedCryptoType)
            if exports['qb-phone']:RemoveCrypto(src, Config.Crypto.RenewedCryptoType, price / renewedCryptoWorth) then
                return cb(true)
            else
                return cb(false)
            end
        else
            print('Invalid crypto type')
            return cb(false)
        end
    elseif currency == 'bank' then
        if Player.Functions.RemoveMoney('bank', price, "blackmarket-buy-items") then -- REMINDER: BANK LETS YOU GO NEGATIVE
            return cb(true)
        else
            return cb(false)
        end
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