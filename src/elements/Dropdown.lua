local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera

local Creator = require("../modules/Creator")
local New = Creator.New
local Tween = Creator.Tween

local CreateLabel = require("../components/ui/Label").New
local CreateInput = require("../components/ui/Input").New
local CreateDropdown = require("../components/ui/Dropdown").New

local CurrentCamera = workspace.CurrentCamera

local Element = {
    UICorner = 10,
    UIPadding = 12,
    MenuCorner = 15,
    MenuPadding = 5,
    TabPadding = 10,
    SearchBarHeight = 39,
    TabIcon = 18,
}

-- Helper function to fetch data from various sources
local function fetchDropdownData(dataSource)
    if not dataSource then
        return {}
    end
    
    -- If it's already a table, return it
    if type(dataSource) == "table" then
        return dataSource
    end
    
    -- If it's a function, call it
    if type(dataSource) == "function" then
        local success, result = pcall(dataSource)
        if success and type(result) == "table" then
            return result
        end
        return {}
    end
    
    -- If it's a string, try to require it as a ModuleScript path
    if type(dataSource) == "string" then
        local success, module = pcall(function()
            -- Try to find the module in various locations
            local locations = {
                game:GetService("ReplicatedStorage"),
                game:GetService("ServerStorage"),
                game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts"),
                game:GetService("StarterPlayer"):FindFirstChild("StarterCharacterScripts"),
                game:GetService("Workspace"),
            }
            
            for _, location in ipairs(locations) do
                if location then
                    local module = location:FindFirstChild(dataSource, true)
                    if module and module:IsA("ModuleScript") then
                        return require(module)
                    end
                end
            end
            
            -- Try direct require if it's a full path
            local pathParts = dataSource:split(".")
            local current = game
            for _, part in ipairs(pathParts) do
                current = current:FindFirstChild(part)
                if not current then
                    return nil
                end
            end
            if current and current:IsA("ModuleScript") then
                return require(current)
            end
        end)
        
        if success and module then
            -- If module returns a function, call it
            if type(module) == "function" then
                local success2, result = pcall(module)
                if success2 and type(result) == "table" then
                    return result
                end
            -- If module returns a table, use it
            elseif type(module) == "table" then
                return module
            end
        end
    end
    
    return {}
end

function Element:New(Config)
    -- Handle dynamic data fetching
    local initialValues = Config.Values
    local dataSource = Config.DataSource or Config.Values
    
    -- If Values is not provided or is a function/string, fetch data
    if not initialValues or type(initialValues) == "function" or type(initialValues) == "string" then
        initialValues = fetchDropdownData(dataSource)
    end
    
    local Dropdown = {
        __type = "Dropdown",
        Title = Config.Title or "Dropdown",
        Desc = Config.Desc or nil,
        Locked = Config.Locked or false,
        Values = initialValues,
        DataSource = dataSource, -- Store original data source for refreshing
        MenuWidth = Config.MenuWidth,
        Value = Config.Value,
        AllowNone = Config.AllowNone,
        SearchBarEnabled = Config.SearchBarEnabled or false,
        Multi = Config.Multi,
        Callback = Config.Callback or nil,
        
        UIElements = {},
        
        Opened = false,
        Tabs = {},
        
        Width = 150,
    }
    
    if Dropdown.Multi and not Dropdown.Value then
        Dropdown.Value = {}
    end
    
    local CanCallback = true
    
    Dropdown.DropdownFrame = require("../components/window/Element")({
        Title = Dropdown.Title,
        Desc = Dropdown.Desc,
        Parent = Config.Parent,
        TextOffset = Dropdown.Callback and Dropdown.Width or 20,
        Hover = not Dropdown.Callback and true or false,
        Tab = Config.Tab,
        Index = Config.Index,
        Window = Config.Window,
        ElementTable = Dropdown,
    })
    
    
    if Dropdown.Callback then
        Dropdown.UIElements.Dropdown = CreateLabel("", nil, Dropdown.DropdownFrame.UIElements.Main, nil, Config.Window.NewElements and 12 or 10)
        
        Dropdown.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate = "AtEnd"
        Dropdown.UIElements.Dropdown.Frame.Frame.TextLabel.Size = UDim2.new(1, Dropdown.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset - 18 - 12 - 12,0,0)
        
        Dropdown.UIElements.Dropdown.Size = UDim2.new(0,Dropdown.Width,0,36)
        Dropdown.UIElements.Dropdown.Position = UDim2.new(1,0,Config.Window.NewElements and 0 or 0.5,0)
        Dropdown.UIElements.Dropdown.AnchorPoint = Vector2.new(1,Config.Window.NewElements and 0 or 0.5)
        
        -- New("UIScale", {
        --     Parent = Dropdown.UIElements.Dropdown,
        --     Scale = .85,
        -- })
        
        
        
    end
    
    Dropdown.DropdownMenu = CreateDropdown(Config, Dropdown, Element, CanCallback, "Dropdown")
    
    
    Dropdown.Display = Dropdown.DropdownMenu.Display
    Dropdown.Refresh = Dropdown.DropdownMenu.Refresh
    Dropdown.Select = Dropdown.DropdownMenu.Select
    Dropdown.Open = Dropdown.DropdownMenu.Open
    Dropdown.Close = Dropdown.DropdownMenu.Close
    Dropdown.UpdatePosition = Dropdown.DropdownMenu.UpdatePosition
    
    local DropdownIcon = New("ImageLabel", {
        Image = Creator.Icon("chevrons-up-down")[1],
        ImageRectOffset = Creator.Icon("chevrons-up-down")[2].ImageRectPosition,
        ImageRectSize = Creator.Icon("chevrons-up-down")[2].ImageRectSize,
        Size = UDim2.new(0,18,0,18),
        Position = UDim2.new(
            1,
            Dropdown.UIElements.Dropdown and -12 or 0,
            0.5,
            0
        ),
        ThemeTag = {
            ImageColor3 = "Icon"
        },
        AnchorPoint = Vector2.new(1,0.5),
        Parent = Dropdown.UIElements.Dropdown and Dropdown.UIElements.Dropdown.Frame or Dropdown.DropdownFrame.UIElements.Main
    })
    
    
    
    function Dropdown:Lock()
        Dropdown.Locked = true
        CanCallback = false
        return Dropdown.DropdownFrame:Lock()
    end
    function Dropdown:Unlock()
        Dropdown.Locked = false
        CanCallback = true
        return Dropdown.DropdownFrame:Unlock()
    end
    
    if Dropdown.Locked then
        Dropdown:Lock()
    end
    
    -- Add SetValues method for dynamic updates
    function Dropdown:SetValues(newValues)
        -- If newValues is nil, try to refresh from DataSource
        if not newValues and self.DataSource then
            newValues = fetchDropdownData(self.DataSource)
        end
        
        -- Validate input
        if type(newValues) ~= "table" then
            warn("Dropdown:SetValues - newValues must be a table")
            return false
        end
        
        -- Store old selected value to preserve selection
        local oldSelected = self.Value
        local oldSelectedTitle = nil
        
        if oldSelected then
            if type(oldSelected) == "table" then
                oldSelectedTitle = oldSelected.Title
            else
                oldSelectedTitle = tostring(oldSelected)
            end
        end
        
        -- Update the internal values
        self.Values = newValues
        
        -- Clear search filter if dropdown is open - handled in Refresh
        -- Refresh the dropdown UI
        if self.Refresh then
            self:Refresh(newValues)
        end
        
        -- Try to restore selection if it still exists
        if oldSelectedTitle then
            local found = false
            for _, option in ipairs(newValues) do
                local optionTitle = type(option) == "table" and option.Title or tostring(option)
                if optionTitle == oldSelectedTitle then
                    self.Value = option
                    found = true
                    break
                end
            end
            if not found then
                -- Selection no longer exists, clear it
                if self.Multi then
                    self.Value = {}
                else
                    self.Value = nil
                end
            end
        end
        
        -- Update display
        if self.Display then
            self:Display()
        end
        
        -- Update position if menu is open
        if self.Opened and self.UpdatePosition then
            task.spawn(function()
                task.wait(0.1) -- Wait for UI to update
                self.UpdatePosition()
            end)
        end
        
        return true
    end
    
    -- Add RefreshData method to refetch from DataSource
    function Dropdown:RefreshData()
        if self.DataSource then
            return self:SetValues(nil) -- nil triggers refresh from DataSource
        end
        return false
    end
    
    return Dropdown.__type, Dropdown
end

return Element