local HttpService = game:GetService("HttpService")

local Window 
local WindUI

local ConfigManager
ConfigManager = {
    Folder = nil,
    Path = nil,
    Configs = {},
    Parser = {
        Colorpicker = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Default:ToHex(),
                    transparency = obj.Transparency or nil,
                }
            end,
            Load = function(element, data)
                if element and element.Update then
                    element:Update(Color3.fromHex(data.value), data.transparency or nil)
                end
            end
        },
        Dropdown = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Value,
                }
            end,
            Load = function(element, data)
                if element and element.Select then
                    element:Select(data.value)
                end
            end
        },
        Input = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Value,
                }
            end,
            Load = function(element, data)
                if element and element.Set then
                    element:Set(data.value)
                end
            end
        },
        Keybind = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Value,
                }
            end,
            Load = function(element, data)
                if element and element.Set then
                    element:Set(data.value)
                end
            end
        },
        Slider = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Value.Default,
                }
            end,
            Load = function(element, data)
                if element and element.Set then
                    element:Set(tonumber(data.value))
                end
            end
        },
        Toggle = {
            Save = function(obj)
                return {
                    __type = obj.__type,
                    value = obj.Value,
                }
            end,
            Load = function(element, data)
                if element and element.Set then
                    element:Set(data.value)
                end
            end
        },
    }
}

function ConfigManager:Init(WindowTable)
    if not WindowTable.Folder then
        warn("[ WindUI.ConfigManager ] Window.Folder is not specified.")
        return false
    end
    
    Window = WindowTable
    -- Get WindUI reference from Window object
    if WindowTable.WindUI then
        WindUI = WindowTable.WindUI
    end
    
    ConfigManager.Folder = Window.Folder
    ConfigManager.Path = tostring(ConfigManager.Folder) .. "/config/"
    
    -- Removed WindUI folder creation - folders created at root level only
    -- Only create folders if they don't already exist
    if not isfolder(ConfigManager.Folder .. "/config/") then
        if not isfolder(ConfigManager.Folder) then
            makefolder(ConfigManager.Folder)
        end
        if not isfolder(ConfigManager.Folder .. "/config/") then
            makefolder(ConfigManager.Folder .. "/config/")
        end
    end
    
    local files = ConfigManager:AllConfigs()
    
    for _, f in next, files do
        if isfile and readfile and isfile(f .. ".json") then
            ConfigManager.Configs[f] = readfile(f .. ".json")
        end
    end
    
    return ConfigManager
end

function ConfigManager:CreateConfig(configFilename)
    local ConfigModule = {
        Path = ConfigManager.Path .. configFilename .. ".json",
        Elements = {},
        CustomData = {},
        Version = 1.1
    }
    
    if not configFilename then
        return false, "No config file is selected"
    end
    
    function ConfigModule:SetAsCurrent()
        Window:SetCurrentConfig(ConfigModule)
    end

    function ConfigModule:Register(Name, Element)
        ConfigModule.Elements[Name] = Element
    end
    
    function ConfigModule:Set(key, value)
        ConfigModule.CustomData[key] = value
    end
    
    function ConfigModule:Get(key)
        return ConfigModule.CustomData[key]
    end
    
    -- Helper function to serialize Color3 or Gradient to JSON-safe format
    local function serializeColor(color)
        if typeof(color) == "Color3" then
            return {
                __type = "Color3",
                value = color:ToHex()
            }
        elseif typeof(color) == "table" then
            -- Check if it's a Gradient (has ColorSequence and NumberSequence)
            local colorSeq = color.Color
            local transSeq = color.Transparency
            
            if colorSeq and typeof(colorSeq) == "ColorSequence" and transSeq and typeof(transSeq) == "NumberSequence" then
                -- It's a Gradient
                local stops = {}
                
                if colorSeq.Keypoints then
                    for i, keypoint in ipairs(colorSeq.Keypoints) do
                        local pos = math.floor(keypoint.Time * 100)
                        local transparency = 0
                        if transSeq.Keypoints and transSeq.Keypoints[i] then
                            transparency = transSeq.Keypoints[i].Value
                        end
                        stops[tostring(pos)] = {
                            Color = keypoint.Value:ToHex(),
                            Transparency = transparency
                        }
                    end
                end
                
                return {
                    __type = "Gradient",
                    stops = stops,
                    rotation = color.Rotation or 0
                }
            end
        end
        return nil
    end
    
    -- Helper function to deserialize Color3 or Gradient from saved format
    local function deserializeColor(data)
        if not data or not data.__type then
            return nil
        end
        
        if data.__type == "Color3" then
            return Color3.fromHex(data.value)
        elseif data.__type == "Gradient" and WindUI and WindUI.Gradient then
            -- Reconstruct gradient using WindUI:Gradient
            return WindUI:Gradient(data.stops or {}, {
                Rotation = data.rotation or 0
            })
        end
        return nil
    end
    
    function ConfigModule:Save()
        if Window.PendingFlags then
            for flag, element in next, Window.PendingFlags do
                ConfigModule:Register(flag, element)
            end
        end
        
        -- Get CustomOverrides from Creator module
        -- This includes ALL custom theme properties: Accent, Background, Text, Button, Icon, 
        -- Dialog, Outline, Hover, Placeholder, DropdownSelected, and all other custom properties
        local customOverrides = {}
        local Creator = require("../modules/Creator")
        if Creator and Creator.CustomOverrides then
            for property, color in pairs(Creator.CustomOverrides) do
                local serialized = serializeColor(color)
                if serialized then
                    customOverrides[property] = serialized
                end
            end
        end
        
        local saveData = {
            __version = ConfigModule.Version,
            __elements = {},
            __custom = ConfigModule.CustomData,
            __themeOverrides = customOverrides
        }
        
        for name, element in next, ConfigModule.Elements do
            if ConfigManager.Parser[element.__type] then
                saveData.__elements[tostring(name)] = ConfigManager.Parser[element.__type].Save(element)
            end
        end
        
        local jsonData = HttpService:JSONEncode(saveData)
        if writefile then 
            writefile(ConfigModule.Path, jsonData)
        end
        
        return saveData
    end
    
    function ConfigModule:Load()
        if isfile and not isfile(ConfigModule.Path) then 
            return false, "Config file does not exist" 
        end
        
        local success, loadData = pcall(function()
            local readfile = readfile or function() 
                warn("[ WindUI.ConfigManager ] The config system doesn't work in the studio.") 
                return nil 
            end
            return HttpService:JSONDecode(readfile(ConfigModule.Path))
        end)
        
        if not success then
            return false, "Failed to parse config file"
        end
        
        if not loadData.__version then
            local migratedData = {
                __version = ConfigModule.Version,
                __elements = loadData,
                __custom = {}
            }
            loadData = migratedData
        end
        
        if Window.PendingFlags then
            for flag, element in next, Window.PendingFlags do
                ConfigModule:Register(flag, element)
            end
        end
        
        for name, data in next, (loadData.__elements or {}) do
            if ConfigModule.Elements[name] and ConfigManager.Parser[data.__type] then
                task.spawn(function()
                    ConfigManager.Parser[data.__type].Load(ConfigModule.Elements[name], data)
                end)
            end
        end
        
        ConfigModule.CustomData = loadData.__custom or {}
        
        -- Restore CustomOverrides if they were saved
        if loadData.__themeOverrides then
            local Creator = require("../modules/Creator")
            if Creator and Creator.CustomOverrides then
                -- Clear existing overrides first
                Creator.CustomOverrides = {}
                
                -- Helper function to deserialize Color3 or Gradient
                local function deserializeColor(data)
                    if not data or not data.__type then
                        return nil
                    end
                    
                    if data.__type == "Color3" then
                        return Color3.fromHex(data.value)
                    elseif data.__type == "Gradient" then
                        -- Get WindUI reference
                        local windUI = WindUI
                        if not windUI and Window and Window.WindUI then
                            windUI = Window.WindUI
                        end
                        
                        if windUI and windUI.Gradient then
                            -- Convert stops from hex strings to Color3
                            local convertedStops = {}
                            for pos, stop in pairs(data.stops or {}) do
                                convertedStops[pos] = {
                                    Color = Color3.fromHex(stop.Color),
                                    Transparency = stop.Transparency or 0
                                }
                            end
                            return windUI:Gradient(convertedStops, {
                                Rotation = data.rotation or 0
                            })
                        end
                    end
                    return nil
                end
                
                -- Restore each override (including DropdownSelected and all other custom properties)
                for property, colorData in pairs(loadData.__themeOverrides) do
                    local color = deserializeColor(colorData)
                    if color then
                        Creator.CustomOverrides[property] = color
                    end
                end
                
                -- Update theme to apply all overrides (including DropdownSelected)
                if Creator.UpdateTheme then
                    Creator.UpdateTheme(nil, false)
                end
            end
        end
        
        return ConfigModule.CustomData
    end
    
    function ConfigModule:Delete()
        if not delfile then
            return false, "delfile function is not available"
        end
        
        if not isfile(ConfigModule.Path) then
            return false, "Config file does not exist"
        end
        
        local success, err = pcall(function()
            delfile(ConfigModule.Path)
        end)
        
        if not success then
            return false, "Failed to delete config file: " .. tostring(err)
        end
        
        ConfigManager.Configs[configFilename] = nil
        
        if Window.CurrentConfig == ConfigModule then
            Window.CurrentConfig = nil
        end
        
        return true, "Config deleted successfully"
    end
    
    function ConfigModule:GetData()
        return {
            elements = ConfigModule.Elements,
            custom = ConfigModule.CustomData
        }
    end
    
    ConfigModule:SetAsCurrent()
    ConfigManager.Configs[configFilename] = ConfigModule
    return ConfigModule
end

function ConfigManager:DeleteConfig(configName)
    if not delfile then
        return false, "delfile function is not available"
    end
    
    local configPath = ConfigManager.Path .. configName .. ".json"
    
    if not isfile(configPath) then
        return false, "Config file does not exist"
    end
    
    local success, err = pcall(function()
        delfile(configPath)
    end)
    
    if not success then
        return false, "Failed to delete config file: " .. tostring(err)
    end
    
    ConfigManager.Configs[configName] = nil
    
    if Window.CurrentConfig and Window.CurrentConfig.Path == configPath then
        Window.CurrentConfig = nil
    end
    
    return true, "Config deleted successfully"
end

function ConfigManager:AllConfigs()
    if not listfiles then return {} end
    
    local files = {}
    if not isfolder(ConfigManager.Path) then
        makefolder(ConfigManager.Path)
        return files
    end
    
    for _, file in next, listfiles(ConfigManager.Path) do
        local name = file:match("([^\\/]+)%.json$")
        if name then
            table.insert(files, name)
        end
    end
    
    return files
end

function ConfigManager:GetConfig(configName)
    return ConfigManager.Configs[configName]
end

-- Load a config by name (creates config module if needed, then loads it)
function ConfigManager:LoadConfigByName(configName)
    if not configName or configName == "" then
        return false, "Config name cannot be empty"
    end
    
    -- Check if config file exists
    local configPath = ConfigManager.Path .. configName .. ".json"
    if not isfile or not isfile(configPath) then
        return false, "Config '" .. configName .. "' does not exist"
    end
    
    -- Get or create the config module
    local configModule = ConfigManager.Configs[configName]
    if not configModule then
        configModule = ConfigManager:CreateConfig(configName)
    end
    
    -- Load the config
    local success, result = pcall(function()
        return configModule:Load()
    end)
    
    if not success then
        return false, "Failed to load config: " .. tostring(result)
    end
    
    if result == false then
        return false, "Config file does not exist or failed to parse"
    end
    
    return true, result
end

-- Check if a config exists by name
function ConfigManager:ConfigExists(configName)
    if not configName or configName == "" then
        return false
    end
    
    local configPath = ConfigManager.Path .. configName .. ".json"
    return isfile and isfile(configPath) or false
end

return ConfigManager