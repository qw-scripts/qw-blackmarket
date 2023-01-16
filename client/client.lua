local QBCore = exports['qb-core']:GetCoreObject()
pickupZoneName = nil
pickupBlip = nil


if Config.Debug then
    RegisterCommand('bm-test', function()
        SetDisplay(true)
    end)
end

RegisterNetEvent('qw-blackmarket:client:openMarket', function()
    SetDisplay(true)
end)

function openMarket()
    TriggerEvent('qw-blackmarket:client:openMarket')
end

exports('openMarket', openMarket)

RegisterNUICallback('getItemList', function(_, cb)
    local itemList = {}
    for k, v in pairs(Config.Items) do
        itemList[#itemList + 1] = {
            name = v.name,
            description = v.description,
            price = v.price,
            item = k
        }
    end

    cb(itemList)

end)

RegisterNUICallback('isCryptoEnabled', function(_, cb)
    cb(Config.Crypto.Enabled)
end)

RegisterNUICallback('getCryptoInfo', function(_, cb)
    QBCore.Functions.TriggerCallback('qw-blackmarket:server:checkCryptoWorth', function(result)
        local cryptoInfo = {}

        if Config.Crypto.CryptoType == 'qb' then
            cryptoInfo = {
                name = 'qbit',
                worth = result
            }
        else 
            cryptoInfo = {
                name = Config.Crypto.RenewedCryptoType,
                worth = result
            }
        end
        cb(cryptoInfo)
    end, Config.Crypto.CryptoType)
end)

RegisterNUICallback('checkout', function(data, cb) 
    -- for k, v in pairs(data.cartItems) do
    --     print(k, v)
    -- end
    SetDisplay(false)

    QBCore.Functions.TriggerCallback('qw-blackmarket:server:checkMoneyNeeded', function(hasEnough)
        if hasEnough then
            createPickupZone(data.cartItems)
            cb(true)
        else
            QBCore.Functions.Notify('You do not have enough money to purchase this item!', 'error', 7500)
            cb(false)
        end
    end, data.total, data.currency)
end)

function createPickupZone(items)
    local pickupZoneInfo = Config.PickupLocations[math.random(1,#Config.PickupLocations)]
    pickupZoneName = pickupZoneInfo.name

    QBCore.Functions.Notify('Purchase Successful, you will receive an email shortly with your pickup location!', 'success', 7500)

    StartPickup(pickupZoneInfo.coords)

    exports['qb-target']:AddBoxZone(pickupZoneInfo.name, pickupZoneInfo.coords,
                                    pickupZoneInfo.length, pickupZoneInfo.width,
                                    {
        name = pickupZoneInfo.name,
        debugPoly = Config.Debug,
        heading = pickupZoneInfo.heading,
        minZ = pickupZoneInfo.minZ,
        maxZ = pickupZoneInfo.maxZ
    }, {
        options = {
            {
                type = "client",
                action = function()
                    TriggerEvent("qw-blackmarket:client:pickupItem", items)
                end,
                icon = "fas fa-hand",
                label = "Pickup Items"
            }
        },
        distance = 2.0
    })
end

function createPickupBlipRoute(coords)

    if pickupBlip ~= nil then RemoveBlip(pickupBlip) end

    pickupBlip = AddBlipForCoord(coords)
    SetBlipRoute(pickupBlip, true)
    SetBlipRouteColour(pickupBlip, 43)
    SetBlipSprite(pickupBlip, 514)
    SetBlipAsShortRange(pickupBlip, true)
    SetBlipScale(pickupBlip, 0.8)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Pickup Location')
    EndTextCommandSetBlipName(pickupBlip)
end

function StartPickup(coords)
    SetTimeout(Config.EmailSendTime, function()
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Anon',
            subject = 'Your Items are Ready for Pickup',
            message = 'I have added a waypoint to your GPS, please make your way over there to retrieve your items.',
            button = {}
        })
        Wait(1000)
        createPickupBlipRoute(coords)
    end)
end

RegisterNetEvent('qw-blackmarket:client:pickupItem', function(items)
    TriggerServerEvent('qw-blackmarket:server:pickupItem', items)
    exports['qb-target']:RemoveZone(pickupZoneName)
    RemoveBlip(pickupBlip)
    pickupZoneName = nil
    pickupBlip = nil
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = 'setVisible',
        data = bool
    })
end

RegisterNUICallback('hideUI', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
end)