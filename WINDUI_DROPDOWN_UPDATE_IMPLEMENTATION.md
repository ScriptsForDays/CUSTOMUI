# WindUI Dropdown Dynamic Update Implementation Guide

## Overview

WindUI Custom (CUSTOMUI) now supports **Rayfield-style dynamic dropdowns** with automatic data fetching from functions, ModuleScripts, or manual updates. This guide covers all the implementation methods available.

## Features

✅ **Automatic Data Fetching** - Dropdowns can fetch data from functions or ModuleScripts automatically  
✅ **Manual Updates** - Use `SetValues()` to update dropdown options dynamically  
✅ **Data Refresh** - Use `RefreshData()` to refetch from original data source  
✅ **Selection Preservation** - Current selection is preserved when possible during updates  
✅ **Search Filter Clearing** - Search filters are automatically cleared when updating  

## Implementation Methods

### Method 1: Function-Based Values (Automatic Fetching)

The dropdown automatically calls a function to fetch data when created:

```lua
local playerDropdown = Tab:Dropdown({
    Title = "Select Player",
    Desc = "Fetches players from game",
    Values = function()
        -- This function is called automatically by WindUI
        local players = {}
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            table.insert(players, {
                Title = player.Name,
                Icon = "user"
            })
        end
        return players
    end,
    Callback = function(option)
        print("Selected player:", option.Title)
    end
})

-- Refresh data from the function later
playerDropdown:RefreshData()
```

**How it works:**
- The function is called automatically when the dropdown is created
- WindUI handles all the rendering
- Use `RefreshData()` to refetch data from the function

**Pros:**
- Automatic data fetching
- Easy to refresh with `RefreshData()`
- Library handles all rendering

**Cons:**
- Function is called during dropdown creation (may be too early if game data isn't loaded)
- Requires game data to be available when dropdown is created

### Method 2: ModuleScript-Based Values (Automatic Fetching)

The dropdown automatically searches for and requires a ModuleScript:

```lua
-- ModuleScript: MyDataModule (in ReplicatedStorage, ServerStorage, etc.)
-- return {
--     { Title = "Item 1", Icon = "package" },
--     { Title = "Item 2", Icon = "package" },
--     { Title = "Item 3", Icon = "package" }
-- }

local itemDropdown = Tab:Dropdown({
    Title = "Select Item",
    Desc = "Fetches items from ModuleScript",
    Values = "MyDataModule", -- Searches for ModuleScript in game
    Callback = function(option)
        print("Selected:", option.Title)
    end
})

-- Refresh data from ModuleScript later
itemDropdown:RefreshData()
```

**ModuleScript Locations Searched:**
- ReplicatedStorage
- ServerStorage
- StarterPlayerScripts
- StarterCharacterScripts
- Workspace

**ModuleScript Return Types:**
- **Table**: Direct use as dropdown values
- **Function**: Function is called and must return a table

**Pros:**
- Centralized data management
- Easy to update by modifying ModuleScript
- Supports both static tables and dynamic functions

**Cons:**
- ModuleScript must exist in game
- Requires proper module structure

### Method 3: Manual Updates with SetValues() (Recommended for Dynamic Data)

Use static initial values, then update manually when data is ready:

```lua
-- Create dropdown with placeholder
local dropdown = Tab:Dropdown({
    Title = "Select Item",
    Desc = "Select an item",
    Values = {{Title = "-- Loading --"}}, -- Placeholder ensures dropdown is visible
    Callback = function(option)
        print("Selected:", option.Title)
    end
})

-- Later, update with actual data
local function updateDropdown()
    local items = getItems() -- Your data fetching function
    local displayValues = {}
    
    for i, item in ipairs(items) do
        displayValues[i] = {
            Title = tostring(item.name),
            Icon = item.icon or "package",
            Desc = item.description or nil
        }
    end
    
    -- Update dropdown
    dropdown:SetValues(displayValues)
    print("Dropdown updated with", #displayValues, "items")
end

-- Call update after game data is loaded
task.spawn(function()
    task.wait(2) -- Wait for game to load
    updateDropdown()
end)
```

**Pros:**
- Works even when game data isn't loaded initially
- More control over when updates happen
- Dropdown is visible immediately (with placeholder)

**Cons:**
- Requires manual update calls
- Need to handle timing of when to update

## Available Methods

### `Dropdown:SetValues(newValues)`

Updates dropdown values dynamically while preserving selection when possible.

**Parameters:**
- `newValues` (table): Array of option tables in format `{{Title = "Option 1"}, {Title = "Option 2"}}`
- If `newValues` is `nil` and a `DataSource` exists, it will refresh from the original source

**Returns:**
- `true` if successful, `false` if validation fails

**Features:**
- Preserves current selection if it still exists in new values
- Clears search filters if dropdown menu is open
- Automatically recalculates UI sizes
- Updates menu position if open

**Example:**
```lua
dropdown:SetValues({
    { Title = "New Option A", Icon = "star" },
    { Title = "New Option B", Icon = "heart" },
    { Title = "New Option C", Icon = "zap" }
})
```

### `Dropdown:RefreshData()`

Refetches data from the original DataSource (function or ModuleScript).

**Returns:**
- `true` if successful, `false` if no DataSource exists

**Example:**
```lua
-- If dropdown was created with function or ModuleScript
dropdown:RefreshData()
```

## Complete Working Examples

### Example 1: Player List with Auto-Refresh

```lua
local playerDropdown = Tab:Dropdown({
    Title = "Select Player",
    Desc = "Choose a player",
    Values = function()
        local players = {}
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            table.insert(players, {
                Title = player.Name,
                Icon = "user",
                Desc = "Level " .. (player.leaderstats and player.leaderstats.Level.Value or "?")
            })
        end
        return players
    end,
    SearchBarEnabled = true,
    Callback = function(option)
        print("Selected player:", option.Title)
    end
})

-- Auto-refresh every 5 seconds
task.spawn(function()
    while true do
        task.wait(5)
        playerDropdown:RefreshData()
    end
end)
```

### Example 2: Items from ModuleScript with Manual Update

```lua
-- Store dropdown reference
_G.ItemDropdown = Tab:Dropdown({
    Title = "Select Item",
    Desc = "Choose an item",
    Values = {{Title = "-- Loading --"}}, -- Placeholder
    Callback = function(option)
        print("Selected item:", option.Title)
    end
})

-- Function to update dropdown
_G.updateItemDropdown = function()
    local items = _G.loadItems() -- Your data fetching function
    
    if #items == 0 then
        warn("[Items] No items found")
        return false
    end
    
    -- Format values for WindUI
    local displayValues = {}
    for i, item in ipairs(items) do
        displayValues[i] = {
            Title = tostring(item.name),
            Icon = item.icon or "package",
            Desc = item.description or nil
        }
    end
    
    -- Update dropdown
    if _G.ItemDropdown and _G.ItemDropdown.SetValues then
        _G.ItemDropdown:SetValues(displayValues)
        print("[Items] Dropdown updated with", #displayValues, "items")
        return true
    else
        warn("[Items] Dropdown or SetValues method not found")
        return false
    end
end

-- Initialize after game loads
task.spawn(function()
    -- Wait for game data
    local Save = require(game.ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client"):WaitForChild("Save"))
    while not Save.Get() do
        task.wait(0.1)
    end
    
    -- Wait for dropdown to be created
    while not _G.ItemDropdown do
        task.wait(0.1)
    end
    
    -- Wait for inventory to load
    task.wait(2)
    
    -- Update dropdown with retry logic
    for i = 1, 5 do
        if i > 1 then
            task.wait(1)
        end
        print("[Items] Update attempt", i)
        if _G.updateItemDropdown() then
            print("[Items] Dropdown successfully initialized!")
            break
        end
    end
    
    -- Periodic refresh for late-loading items
    task.spawn(function()
        while true do
            task.wait(10)
            if _G.ItemDropdown then
                _G.updateItemDropdown()
            end
        end
    end)
end)
```

### Example 3: ModuleScript with Function Return

```lua
-- ModuleScript: ItemDataModule
-- return function()
--     local items = {}
--     -- Fetch items from game
--     for _, item in ipairs(game:GetService("ReplicatedStorage").Items:GetChildren()) do
--         table.insert(items, {
--             Title = item.Name,
--             Icon = "package"
--         })
--     end
--     return items
-- end

local itemDropdown = Tab:Dropdown({
    Title = "Select Item",
    Desc = "Fetches from ModuleScript",
    Values = "ItemDataModule", -- ModuleScript returns a function
    Callback = function(option)
        print("Selected:", option.Title)
    end
})

-- Refresh from ModuleScript
itemDropdown:RefreshData()
```

## Value Format Requirements

Dropdown values must be in this format:

```lua
{
    { Title = "Option 1", Icon = "file", Desc = "Description" },
    { Title = "Option 2", Icon = "folder" },
    { Title = "Option 3" }, -- Icon and Desc are optional
    { Type = "Divider" }, -- Special: Creates a divider
}
```

**Required:**
- `Title` (string): The display text for the option

**Optional:**
- `Icon` (string): Icon name to display
- `Desc` (string): Description text shown below title
- `Callback` (function): Individual callback for this option (for Menu type dropdowns)
- `Locked` (boolean): Whether this option is locked/disabled
- `Type` (string): Set to "Divider" to create a visual separator

## Important Notes

1. **Never use empty Values** - Always provide at least a placeholder: `Values = {{Title = "--"}}`

2. **Format is critical** - Values must be an array of tables with `Title` property

3. **Callback receives option objects** - The Callback function receives the full option object: `option.Title`, `option.Icon`, etc.

4. **Store dropdown references** - Use `_G.DropdownName` or module-level variables to store dropdown references for updates

5. **Handle timing** - Always wait for game data to load before updating dropdowns

6. **Selection preservation** - SetValues() tries to preserve selection by matching titles. If the selected option no longer exists, selection is cleared.

7. **Search filter clearing** - When SetValues() is called while dropdown menu is open, search filters are automatically cleared

## Troubleshooting

**Dropdown not visible:**
- Ensure `Values` is not empty - use `{{Title = "--"}}` as placeholder
- Check that dropdown is created in the correct tab/parent

**SetValues() not found:**
- Ensure you're using WindUI Custom (CUSTOMUI) version with dynamic dropdown support
- Check that dropdown object is properly created

**Values not updating:**
- Ensure you're calling `SetValues()` after dropdown is created
- Check that `displayValues` is in correct format: `{{Title = "..."}}`
- Verify game data is loaded before updating

**Function/ModuleScript not working:**
- For functions: Ensure function returns a table
- For ModuleScripts: Check that module exists in searched locations
- Verify module returns a table or function that returns a table

**Selection not preserved:**
- Selection is matched by `Title` property
- If title changes, selection will be lost
- Multi-select dropdowns preserve all matching selections

## Testing Checklist

- [ ] Dropdown is visible immediately (with placeholder if needed)
- [ ] Function-based Values work and fetch data automatically
- [ ] ModuleScript-based Values work and fetch data automatically
- [ ] SetValues() updates dropdown correctly
- [ ] RefreshData() refetches from DataSource
- [ ] Selection is preserved when possible after update
- [ ] Search filters are cleared when updating
- [ ] Dropdown handles empty data gracefully
- [ ] Periodic refresh works for late-loading items
- [ ] Callback receives correct option objects
- [ ] Multi-select dropdowns work correctly

## References

- [WindUI Custom Documentation](https://ScriptsForDays.github.io/CUSTOMUI/)
- [Dynamic Dropdown Updates](https://ScriptsForDays.github.io/CUSTOMUI/customizations.html)
- [API Reference](https://ScriptsForDays.github.io/CUSTOMUI/api.html)
