--[[

    WindUI Example (wip)
    
]]


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()
    end
end


WindUI:Popup({
    Title = "Welcome to the WindUI!",
    Icon = "bird",
    Content = "Hello!",
    Buttons = {
        {
            Title = "Hahaha",
            Icon = "bird",
        }
    }
})

-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = ".ftgs hub  |  WindUI Example",
    Author = "by .ftgs • Footagesus",
    Folder = "ftgshub",
    Icon = "bird",
    NewElements = true,
    --Size = UDim2.fromOffset(700,700),
    
    HideSearchBar = false,
    
    OpenButton = {
        Title = "Open .ftgs hub UI", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    }
})


--Window:SetUIScale(.8)

-- */  Tags  /* --
do
    Window:Tag({
        Title = "v" .. WindUI.Version,
        Icon = "github",
        Color = Color3.fromHex("#6b31ff")
    })
end

-- */  Theme (soon)  /* --
do
    --[[WindUI:AddTheme({
        Name = "Stylish",
        
        Accent = Color3.fromHex("#3b82f6"), 
        Dialog = Color3.fromHex("#1a1a1a"), 
        Outline = Color3.fromHex("#3b82f6"),
        Text = Color3.fromHex("#f8fafc"),  
        Placeholder = Color3.fromHex("#94a3b8"),
        Button = Color3.fromHex("#334155"), 
        Icon = Color3.fromHex("#60a5fa"), 
        
        WindowBackground = Color3.fromHex("#0f172a"),
        
        TopbarButtonIcon = Color3.fromHex("#60a5fa"),
        TopbarTitle = Color3.fromHex("#f8fafc"),
        TopbarAuthor = Color3.fromHex("#94a3b8"),
        TopbarIcon = Color3.fromHex("#3b82f6"),
        
        TabBackground = Color3.fromHex("#1e293b"),    
        TabTitle = Color3.fromHex("#f8fafc"),
        TabIcon = Color3.fromHex("#60a5fa"),
        
        ElementBackground = Color3.fromHex("#1e293b"),
        ElementTitle = Color3.fromHex("#f8fafc"),
        ElementDesc = Color3.fromHex("#cbd5e1"),
        ElementIcon = Color3.fromHex("#60a5fa"),
    })--]]
    
    -- WindUI:SetTheme("Stylish")
end

-- */  Custom Theme Customization  /* --
do
    --[[
        Custom theme customization allows you to override specific theme properties
        without creating a full theme. Changes are applied immediately to all UI elements.
        All methods return true on success, false on failure.
    ]]
    
    -- ============================================
    -- Basic Theme Properties
    -- ============================================
    
    -- Example: Set custom accent color
    -- WindUI:SetCustomAccent(Color3.fromHex("#30ff6a"))
    
    -- Example: Set custom background with solid color
    -- WindUI:SetCustomBackground(Color3.fromHex("#1a1a1a"))
    
    -- Example: Set custom background with gradient
    -- WindUI:SetCustomBackground(WindUI:Gradient({
    --     ["0"] = { Color = Color3.fromHex("#0f0c29"), Transparency = 0 },
    --     ["100"] = { Color = Color3.fromHex("#302b63"), Transparency = 0.1 },
    -- }, {
    --     Rotation = 45,
    -- }))
    
    -- Example: Set custom text color
    -- WindUI:SetCustomText(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom button color
    -- WindUI:SetCustomButton(Color3.fromHex("#52525b"))
    
    -- Example: Set custom button with gradient
    -- WindUI:SetCustomButton(WindUI:Gradient({
    --     ["0"] = { Color = Color3.fromHex("#30FF6A"), Transparency = 0 },
    --     ["100"] = { Color = Color3.fromHex("#e7ff2f"), Transparency = 0 },
    -- }, {
    --     Rotation = 60,
    -- }))
    
    -- Example: Set custom icon color
    -- WindUI:SetCustomIcon(Color3.fromHex("#a1a1aa"))
    
    -- Example: Set custom dialog background
    -- WindUI:SetCustomDialog(Color3.fromHex("#161616"))
    
    -- Example: Set custom outline color (used for borders, outlines, etc.)
    -- WindUI:SetCustomOutline(Color3.fromHex("#FFFFFF"))
    
    -- Example: Set custom hover color (used for hover states)
    -- WindUI:SetCustomHover(Color3.fromHex("#3a3a3a"))
    
    -- Example: Set custom placeholder color (used for input placeholders)
    -- WindUI:SetCustomPlaceholder(Color3.fromHex("#7a7a7a"))
    
    -- ============================================
    -- Window Topbar Properties
    -- ============================================
    
    -- Example: Set custom window topbar title color
    -- WindUI:SetCustomWindowTopbarTitle(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom window topbar author color
    -- WindUI:SetCustomWindowTopbarAuthor(Color3.fromHex("#a1a1aa"))
    
    -- Example: Set custom window topbar icon color
    -- WindUI:SetCustomWindowTopbarIcon(Color3.fromHex("#30ff6a"))
    
    -- Example: Set custom window topbar button icon color
    -- WindUI:SetCustomWindowTopbarButtonIcon(Color3.fromHex("#a1a1aa"))
    
    -- Example: Set custom window background color (the main window frame)
    -- WindUI:SetCustomWindowBackground(Color3.fromHex("#0f172a"))
    
    -- Example: Set custom window topbar background color (the topbar container itself)
    -- WindUI:SetCustomWindowTopbarBackground(Color3.fromHex("#1a1a1a"))
    
    -- ============================================
    -- Tab Properties
    -- ============================================
    
    -- Example: Set custom tab background color
    -- WindUI:SetCustomTabBackground(Color3.fromHex("#1e293b"))
    
    -- Example: Set custom tab title color
    -- WindUI:SetCustomTabTitle(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom tab icon color
    -- WindUI:SetCustomTabIcon(Color3.fromHex("#60a5fa"))
    
    -- ============================================
    -- Element Properties
    -- ============================================
    
    -- Example: Set custom element background color
    -- WindUI:SetCustomElementBackground(Color3.fromHex("#1e293b"))
    
    -- Example: Set custom element title color
    -- WindUI:SetCustomElementTitle(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom element description color
    -- WindUI:SetCustomElementDesc(Color3.fromHex("#cbd5e1"))
    
    -- Example: Set custom element icon color
    -- WindUI:SetCustomElementIcon(Color3.fromHex("#60a5fa"))
    
    -- ============================================
    -- Popup Properties
    -- ============================================
    
    -- Example: Set custom popup background color
    -- WindUI:SetCustomPopupBackground(Color3.fromHex("#1a1a1a"))
    
    -- Example: Set custom popup title color
    -- WindUI:SetCustomPopupTitle(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom popup content color
    -- WindUI:SetCustomPopupContent(Color3.fromHex("#a1a1aa"))
    
    -- Example: Set custom popup icon color
    -- WindUI:SetCustomPopupIcon(Color3.fromHex("#30ff6a"))
    
    -- ============================================
    -- Dialog Properties
    -- ============================================
    
    -- Example: Set custom dialog background color
    -- WindUI:SetCustomDialogBackground(Color3.fromHex("#161616"))
    
    -- Example: Set custom dialog title color
    -- WindUI:SetCustomDialogTitle(Color3.fromHex("#ffffff"))
    
    -- Example: Set custom dialog content color
    -- WindUI:SetCustomDialogContent(Color3.fromHex("#a1a1aa"))
    
    -- Example: Set custom dialog icon color
    -- WindUI:SetCustomDialogIcon(Color3.fromHex("#30ff6a"))
    
    -- ============================================
    -- Toggle & Checkbox Properties
    -- ============================================
    
    -- Example: Set custom toggle color
    -- WindUI:SetCustomToggle(Color3.fromHex("#33C759"))
    
    -- Example: Set custom checkbox color
    -- WindUI:SetCustomCheckbox(Color3.fromHex("#0091ff"))
    
    -- Example: Set custom checkbox icon color
    -- WindUI:SetCustomCheckboxIcon(Color3.fromHex("#ffffff"))
    
    -- ============================================
    -- Generic Property Setter & Utilities
    -- ============================================
    
    -- Example: Set any custom property (for properties not covered above)
    -- WindUI:SetCustomProperty("WindowBackground", Color3.fromHex("#0f172a"))
    -- WindUI:SetCustomProperty("TabBackground", Color3.fromHex("#1e293b"))
    -- WindUI:SetCustomProperty("ElementBackground", Color3.fromHex("#1e293b"))
    
    -- Example: Get all current custom overrides
    -- local overrides = WindUI:GetCustomOverrides()
    -- print("Current overrides:", overrides)
    
    -- Example: Clear a specific custom property
    -- WindUI:ClearCustomProperty("Accent")
    
    -- Example: Clear all custom overrides
    -- WindUI:ClearCustomOverrides()
end



-- */ Other Functions /* --
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


-- */  About Tab  /* --
do
    local AboutTab = Window:Tab({
        Title = "About WindUI",
        Icon = "info",
    })
    
    local AboutSection = AboutTab:Section({
        Title = "About WindUI",
    })
    
    AboutSection:Image({
        Image = "https://repository-images.githubusercontent.com/880118829/428bedb1-dcbd-43d5-bc7f-3beb2e9e0177",
        AspectRatio = "16:9",
        Radius = 9,
    })
    
    AboutSection:Space({ Columns = 3 })
    
    AboutSection:Section({
        Title = "What is WindUI?",
        TextSize = 24,
        FontWeight = Enum.FontWeight.SemiBold,
    })

    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[WindUI is a stylish, open-source UI (User Interface) library specifically designed for Roblox Script Hubs.
Developed by Footagesus (.ftgs, Footages).
It aims to provide developers with a modern, customizable, and easy-to-use toolkit for creating visually appealing interfaces within Roblox.
The project is primarily written in Lua (Luau), the scripting language used in Roblox.]],
        TextSize = 18,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 }) 
    
    
    -- Default buttons
    
    AboutTab:Button({
        Title = "Export WindUI JSON (copy)",
        Color = Color3.fromHex("#a2ff30"),
        Justify = "Center",
        IconAlign = "Left",
        Icon = "", -- removing icon
        Callback = function()
            tableToClipboard(WindUI)
            WindUI:Notify({
                Title = "WindUI JSON",
                Content = "Copied to Clipboard!"
            })
        end
    })
    AboutTab:Space({ Columns = 1 }) 
    
    
    AboutTab:Button({
        Title = "Destroy Window",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            Window:Destroy()
        end
    })
end

-- */  Elements Section  /* --
local ElementsSection = Window:Section({
    Title = "Elements",
})
local ConfigUsageSection = Window:Section({
    Title = "Config Usage",
})
local OtherSection = Window:Section({
    Title = "Other",
})


-- */ Using Nebula Icons /* --
do
    local NebulaIcons = loadstring(game:HttpGetAsync("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()
    
    -- Adding icons (e.g. Fluency)
    WindUI.Creator.AddIcons("fluency",    NebulaIcons.Fluency)
    --               ^ Icon name          ^ Table of Icons
    
    -- You can also add nebula icons
    WindUI.Creator.AddIcons("nebula",    NebulaIcons.nebulaIcons)
    
    -- Usage ↑ ↓
    
    local TestSection = Window:Section({
        Title = "Custom icons usage test (nebula)",
        Icon = "nebula:nebula",
    })
end



-- */  Toggle Tab  /* --
do
    local ToggleTab = ElementsSection:Tab({
        Title = "Toggle",
        Icon = "arrow-left-right"
    })
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example"
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Checkbox",
        Type = "Checkbox",
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Checkbox",
        Desc = "Checkbox example",
        Type = "Checkbox",
    })
    
    ToggleTab:Space()
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Locked = true,
    })
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example",
        Locked = true,
    })
end


-- */  Button Tab  /* --
do
    local ButtonTab = ElementsSection:Tab({
        Title = "Button",
        Icon = "mouse-pointer-click",
    })
    
    
    local HighlightButton
    HighlightButton = ButtonTab:Button({
        Title = "Highlight Button",
        Icon = "mouse",
        Callback = function()
            print("clicked highlight")
            HighlightButton:Highlight()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Desc = "With description",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Button",
        Desc = "Button example",
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Button",
        Locked = true,
    })
    
    
    ButtonTab:Button({
        Title = "Button",
        Desc = "Button example",
        Locked = true,
    })
end


-- */  Input Tab  /* --
do
    local InputTab = ElementsSection:Tab({
        Title = "Input",
        Icon = "text-cursor-input",
    })
    
    
    InputTab:Input({
        Title = "Input",
        Icon = "mouse"
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        --Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Desc = "Input example",
        Type = "Textarea",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Locked = true,
    })
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
        Locked = true,
    })
end


-- */  Dropdown Tab  /* --
do
    local DropdownTab = ElementsSection:Tab({
        Title = "Dropdown",
        Icon = "logs",
    })
    
    
    DropdownTab:Dropdown({
        Title = "Advanced Dropdown (example)",
        Values = {
            {
                Title = "New file",
                Desc = "Create a new file",
                Icon = "file-plus",
                Callback = function() 
                    print("Clicked 'New File'")
                end
            },
            {
                Title = "Copy link",
                Desc = "Copy the file link",
                Icon = "copy",
                Callback = function() 
                    print("Clicked 'Copy link'")
                end
            },
            {
                Title = "Edit file",
                Desc = "Allows you to edit the file",
                Icon = "file-pen",
                Callback = function() 
                    print("Clicked 'Edit file'")
                end
            },
            {
                Type = "Divider",
            },
            {
                Title = "Delete file",
                Desc = "Permanently delete the file",
                Icon = "trash",
                Callback = function() 
                    print("Clicked 'Delete file'")
                end
            },
        }
    })
    
    DropdownTab:Space()
    
    -- Example: Dynamic dropdown with function data source
    local dynamicDropdown = DropdownTab:Dropdown({
        Title = "Dynamic Dropdown",
        Desc = "Fetches data from function or ModuleScript",
        -- Option 1: Use a function to fetch data
        Values = function()
            -- Fetch data from game (e.g., players, items, etc.)
            local players = {}
            for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                table.insert(players, {
                    Title = player.Name,
                    Icon = "user"
                })
            end
            return players
        end,
        -- Option 2: Use a ModuleScript path (string)
        -- Values = "MyDataModule", -- Will search for ModuleScript in game
        -- Option 3: Use static table
        -- Values = {{ Title = "Option 1" }, { Title = "Option 2" }},
        Callback = function(option)
            print("Selected:", option.Title)
        end
    })
    
    DropdownTab:Space()
    
    DropdownTab:Space()
    
    -- Example button to refresh data from source
    DropdownTab:Button({
        Title = "Refresh from Data Source",
        Icon = "refresh-cw",
        Desc = "Refetches data from function/ModuleScript",
        Callback = function()
            -- Refresh data from the original DataSource
            dynamicDropdown:RefreshData()
            WindUI:Notify({
                Title = "Data Refreshed",
                Content = "Dropdown data refreshed from source!",
                Duration = 2
            })
        end
    })
    
    DropdownTab:Space()
    
    -- Example button to update dropdown with new values
    DropdownTab:Button({
        Title = "Update Dropdown Values",
        Icon = "refresh-cw",
        Desc = "Manually set new values",
        Callback = function()
            -- Update the dropdown with new values
            dynamicDropdown:SetValues({
                { Title = "New Option A", Icon = "star" },
                { Title = "New Option B", Icon = "heart" },
                { Title = "New Option C", Icon = "zap" },
                { Title = "New Option D", Icon = "moon" },
            })
            WindUI:Notify({
                Title = "Dropdown Updated",
                Content = "Dropdown values have been updated!",
                Duration = 2
            })
        end
    })
    
    DropdownTab:Space()
    
    -- Example: Dropdown with ModuleScript data source
    --[[
    local moduleDropdown = DropdownTab:Dropdown({
        Title = "ModuleScript Dropdown",
        Desc = "Fetches data from a ModuleScript",
        Values = "MyDataModule", -- Searches for ModuleScript named "MyDataModule"
        Callback = function(option)
            print("Selected:", option.Title)
        end
    })
    --]]
    
end



--[[  idk. VideoFrame is not working with custom video on exploits
      I don't know why
    
-- */  Video Tab  /* --
do
    local VideoTab = ElementsSection:Tab({
        Title = "Video",
        Icon = "video",
    })
    
    VideoTab:Video({
        Title = "My Video Hahahah", -- optional
        Author = ".ftgs", -- optional
        Video = "https://cdn.discordapp.com/attachments/1337368451865645096/1402703845657673878/VID_20250616_180732_158.webm?ex=68fc5f01&is=68fb0d81&hm=f4f0a88dbace2d3cef92535b2e57effae6d4c4fc444338163faafa7f3fdac529&"
    })
end

--]]


-- */  Config Usage  /* --
do -- config elements
    local ConfigElementsTab = ConfigUsageSection:Tab({
        Title = "Config Elements",
        Icon = "square-dashed-mouse-pointer",
    })
    
    -- All elements are taken from the official documentation: https://footagesus.github.io/WindUI-Docs/docs
    
    -- Saving elements to the config using `Flag`
    
    -- Example: Colorpicker with ThemeProperty to display current UI color
    -- ConfigElementsTab:Colorpicker({
    --     Title = "Accent Color",
    --     Desc = "Customize the accent color",
    --     ThemeProperty = "Accent", -- Automatically gets current Accent color from theme
    --     Callback = function(color)
    --         WindUI:SetCustomAccent(color)
    --         -- UI updates immediately!
    --     end
    -- })
    --
    -- ConfigElementsTab:Space()
    --
    ConfigElementsTab:Colorpicker({
        Flag = "ColorpickerTest",
        Title = "Colorpicker",
        Desc = "Colorpicker Description",
        Default = Color3.fromRGB(0, 255, 0),
        Transparency = 0,
        Locked = false,
        Callback = function(color) 
            print("Background color: " .. tostring(color))
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Dropdown({
        Flag = "DropdownTest",
        Title = "Advanced Dropdown",
        Values = {
            {
                Title = "Category A",
                Icon = "bird"
            },
            {
                Title = "Category B",
                Icon = "house"
            },
            {
                Title = "Category C",
                Icon = "droplet"
            },
        },
        Value = "Category A",
        Callback = function(option) 
            print("Category selected: " .. option.Title .. " with icon " .. option.Icon) 
        end
    })
    ConfigElementsTab:Dropdown({
        Flag = "DropdownTest2",
        Title = "Advanced Dropdown 2",
        Values = {
            {
                Title = "Category A",
                Icon = "bird"
            },
            {
                Title = "Category B",
                Icon = "house"
            },
            {
                Title = "Category C",
                Icon = "droplet",
                Locked = true,
            },
        },
        Value = "Category A",
        Multi = true,
        Callback = function(options) 
            local titles = {}
            for _, v in ipairs(options) do
                table.insert(titles, v.Title)
            end
            print("Selected: " .. table.concat(titles, ", "))
        end
    })
    
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Input({
        Flag = "InputTest",
        Title = "Input",
        Desc = "Input Description",
        Value = "Default value",
        InputIcon = "bird",
        Type = "Input", -- or "Textarea"
        Placeholder = "Enter text...",
        Callback = function(input) 
            print("Text entered: " .. input)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Keybind({
        Flag = "KeybindTest",
        Title = "Keybind",
        Desc = "Keybind to open ui",
        Value = "G",
        Callback = function(v)
            Window:SetToggleKey(Enum.KeyCode[v])
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Slider({
        Flag = "SliderTest",
        Title = "Slider",
        Step = 1,
        Value = {
            Min = 20,
            Max = 120,
            Default = 70,
        },
        Callback = function(value)
            print(value)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Toggle({
        Flag = "ToggleTest",
        Title = "Toggle",
        Desc = "Toggle Description",
        --Icon = "house",
        --Type = "Checkbox",
        Default = false,
        Callback = function(state) 
            print("Toggle Activated" .. tostring(state))
        end
    })
end

do -- config panel
    local ConfigTab = ConfigUsageSection:Tab({
        Title = "Config Usage",
        Icon = "folder",
    })

    local ConfigManager = Window.ConfigManager
    local SaveConfigName = "default"
    local LoadConfigName = "default"

    -- Input field for naming configs to save
    local SaveConfigNameInput = ConfigTab:Input({
        Title = "Config Name (Save)",
        Desc = "Enter a name for your config",
        Icon = "file-cog",
        Value = SaveConfigName,
        Callback = function(value)
            SaveConfigName = value or "default"
        end
    })

    ConfigTab:Space()

    -- Dropdown to see all available configs (optional - user can select from this)
    local configDropdown
    local selectedConfigFromDropdown = nil
    local function UpdateConfigDropdown()
        local AllConfigs = ConfigManager:AllConfigs()
        
        -- Convert array of strings to dropdown format
        local dropdownValues = {}
        for _, configName in ipairs(AllConfigs) do
            table.insert(dropdownValues, {
                Title = configName,
                Icon = "file"
            })
        end
        
        if configDropdown then
            configDropdown:SetValues(dropdownValues)
            -- Try to maintain current selection if it still exists
            if selectedConfigFromDropdown and table.find(AllConfigs, selectedConfigFromDropdown) then
                configDropdown:Select(selectedConfigFromDropdown)
            end
        else
            configDropdown = ConfigTab:Dropdown({
                Title = "Select Config (Optional)",
                Desc = "Choose a config from the dropdown, or type one below",
                Values = dropdownValues,
                Callback = function(option)
                    selectedConfigFromDropdown = option and option.Title or nil
                    if selectedConfigFromDropdown then
                        LoadConfigNameInput:Set(selectedConfigFromDropdown)
                        LoadConfigName = selectedConfigFromDropdown
                    end
                end
            })
        end
    end

    -- Initialize dropdown
    UpdateConfigDropdown()

    ConfigTab:Space()

    -- Input field for loading configs by name (optional - user can type here)
    local LoadConfigNameInput = ConfigTab:Input({
        Title = "Load Config by Name",
        Desc = "Type the name of the config to load, or select from dropdown above",
        Icon = "folder-open",
        Value = LoadConfigName,
        Callback = function(value)
            LoadConfigName = value or ""
            -- Clear dropdown selection when user types manually
            selectedConfigFromDropdown = nil
        end
    })

    ConfigTab:Space()

    -- Save Config Button
    ConfigTab:Button({
        Title = "Save Config",
        Icon = "save",
        Justify = "Center",
        Callback = function()
            if not SaveConfigName or SaveConfigName == "" then
                WindUI:Notify({
                    Title = "Error",
                    Desc = "Please enter a config name",
                    Icon = "x",
                    Duration = 3
                })
                return
            end

            Window.CurrentConfig = ConfigManager:CreateConfig(SaveConfigName)
            if Window.CurrentConfig:Save() then
                WindUI:Notify({
                    Title = "Config Saved",
                    Desc = "Config '" .. SaveConfigName .. "' saved successfully",
                    Icon = "check",
                    Duration = 3
                })
                -- Update dropdown to show new config
                UpdateConfigDropdown()
            else
                WindUI:Notify({
                    Title = "Error",
                    Desc = "Failed to save config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    ConfigTab:Space()

    -- Load Config Button (uses dropdown selection if available, otherwise uses textbox)
    ConfigTab:Button({
        Title = "Load Config",
        Icon = "refresh-cw",
        Justify = "Center",
        Callback = function()
            -- Priority: Use dropdown selection if available, otherwise use textbox value
            local configToLoad = selectedConfigFromDropdown or LoadConfigName
            
            if not configToLoad or configToLoad == "" then
                WindUI:Notify({
                    Title = "Error",
                    Desc = "Please select a config from the dropdown or enter a config name",
                    Icon = "x",
                    Duration = 3
                })
                return
            end

            -- Use the new LoadConfigByName method
            local success, result = ConfigManager:LoadConfigByName(configToLoad)
            
            if success then
                WindUI:Notify({
                    Title = "Config Loaded",
                    Desc = "Config '" .. configToLoad .. "' loaded successfully",
                    Icon = "check",
                    Duration = 3
                })
                -- Update save name to match loaded config
                SaveConfigName = configToLoad
                SaveConfigNameInput:Set(SaveConfigName)
                -- Update dropdown selection
                selectedConfigFromDropdown = configToLoad
                if configDropdown then
                    configDropdown:Select(configToLoad)
                end
            else
                WindUI:Notify({
                    Title = "Error",
                    Desc = result or "Failed to load config",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
end




-- */  Other  /* --
do
    local InviteCode = "ftgs-development-hub-1300692552005189632"
    local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

    local Response = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "WindUI/Example",
            ["Accept"] = "application/json"
        }
    }).Body)
    
    local DiscordTab = OtherSection:Tab({
        Title = "Discord",
    })
    
    if Response and Response.guild then
        DiscordTab:Section({
            Title = "Join our Discord server!",
            TextSize = 20,
        })
        local DiscordServerParagraph = DiscordTab:Paragraph({
            Title = tostring(Response.guild.name),
            Desc = tostring(Response.guild.description),
            Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
            Thumbnail = "https://cdn.discordapp.com/banners/1300692552005189632/35981388401406a4b7dffd6f447a64c4.png?size=512",
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy link",
                    Icon = "link",
                    Callback = function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                    end
                }
            }
        })
        
    end
end