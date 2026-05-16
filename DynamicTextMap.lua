---@diagnostic disable: undefined-global

ExBoss = ExBoss or {}
ExBoss.Locale = ExBoss.Locale or {}

local Locale = ExBoss.Locale

local function GetEffectiveLocale()
    if ExBoss and ExBoss.GetEffectiveLocale then
        local locale = tostring(ExBoss:GetEffectiveLocale() or "zhCN"):gsub("%s+", "")
        if locale == "enGB" then
            return "enUS"
        end
        if locale == "zhTW" then
            return "zhCN"
        end
        if locale == "enUS" or locale == "zhCN" then
            return locale
        end
    end
    return "zhCN"
end

local function Trim(text)
    return tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

function Locale.TranslateBossDynamicText(text)
    if type(text) ~= "string" then
        return text
    end
    if GetEffectiveLocale() ~= "enUS" then
        return text
    end

    local key = Trim(text)
    if key == "" then
        return text
    end

    local L = ExBoss and ExBoss.L
    local mapped = L and L[key] or nil
    if type(mapped) == "string" and mapped ~= "" and mapped ~= key then
        return mapped
    end
    return text
end
