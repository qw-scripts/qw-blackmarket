Config = {}

Config.ItemName = 'tablet' -- usable item name

Config.Debug = false -- debug mode

Config.EmailSendTime = math.random(10000, 30000) -- time in ms to send email

Config.Items = { -- Items being sold on the Blackmarket
    ['weapon_pistol'] = {
        name = "Pistol",
        description = "A small pistol",
        price = 10000,
    },
    ['lockpick'] = {
        name = "Shit Lockpick",
        description = "A lockpick that will probably fucking break",
        price = 100,
    },
    ['10kgoldchain'] = {
        name = "Neck Piece",
        description = "A shiny gold chain",
        price = 100,
    },
    ['iphone'] = {
        name = 'iPhone',
        description = 'A shiny iPhone',
        price = 325,
    },
    ['laptop'] = {
        name = 'Gaming Laptop',
        description = 'A shiny gaming laptop',
        price = 830,
    }
}

Config.PickupLocations = { -- Pickup locations for the items when an order is placed
    [1] = {
        coords = vector3(12.33, -1299.86, 29.24),
        name = 'Pickup Location 1',
        length = 1.0, width = 1.0,
        heading = 350.36,
        minZ = 28.24, maxZ = 30.24,
    },
    [2] = {
        coords = vector3(234.35, -107.94, 74.35),
        name = 'Pickup Location 2',
        length = 1.0, width = 1.0,
        heading = 166.36,
        minZ = 73.35, maxZ = 75.35,
    }
}