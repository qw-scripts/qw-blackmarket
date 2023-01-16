# ![qw-scripts Banner](https://i.imgur.com/68jLFg3.png)

## qw-scripts discord

<https://dsc.gg/qw-scripts>

# qw-blackmarket
QBCore Customizable blackmarket System

# Installation
**PLEASE DOWNLOAD FROM THE LATEST BUILD [HERE](https://github.com/qw-scripts/qw-blackmarket/releases/latest)**

# Crypto Setup

**Using QBCore Crypto**

Add the following function export to `qb-crypto/server/main.lua`

```lua
function GetCurrentCryptoWorth()
    return Crypto.Worth[coin]
end

exports('GetCurrentCryptoWorth', GetCurrentCryptoWorth)
```

**Using Renewed Phone Crypto**

Add the following function export to `qb-phone/server/crypto.lua`

```lua
local function GetCryptoValue(type)
    local v = Config.CryptoCoins[GetConfig(type)]
    local value = v.value

    return value
end

exports('GetCryptoValue', GetCryptoValue)
```

I would highly using the qb-phone that Renewed-Scripts released, you can find the script here: [https://github.com/Renewed-Scripts/qb-phone](https://github.com/Renewed-Scripts/qb-phone) 

# Preview
https://vimeo.com/789457492
