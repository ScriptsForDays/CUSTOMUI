# CUSTOMUI

Custom enhanced version of [WindUI](https://github.com/Footagesus/WindUI) - A modern UI library for Roblox Script Hubs.

## About

This repository contains a custom-enhanced version of WindUI with additional features for dynamic UI updates and advanced customization.

## Custom Features

### Dynamic Dropdown Updates
- **`dropdown:SetValues(newValues)`** - Update dropdown values dynamically
- Preserves current selection when possible
- Works with both single-select and multi-select dropdowns
- Automatically updates UI even when menu is open

### Custom Accent Customization
Override theme properties without creating full custom themes:

- `WindUI:SetCustomAccent(color)` - Set custom accent color
- `WindUI:SetCustomBackground(color)` - Set custom background (supports gradients)
- `WindUI:SetCustomText(color)` - Set custom text color
- `WindUI:SetCustomButton(color)` - Set custom button color
- `WindUI:SetCustomIcon(color)` - Set custom icon color
- `WindUI:SetCustomDialog(color)` - Set custom dialog background
- `WindUI:SetCustomOutline(color)` - Set custom outline color
- `WindUI:SetCustomProperty(name, value)` - Set any theme property
- `WindUI:ClearCustomOverrides()` - Clear all custom overrides
- `WindUI:ClearCustomProperty(name)` - Clear specific override
- `WindUI:GetCustomOverrides()` - Get all current overrides

## Installation

```lua
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/ScriptsForDays/CUSTOMUI/main/WindUI/dist/main.lua'))()
```

## Documentation

See the [WindUI Documentation](https://footagesus.github.io/WindUI-Docs/) for base features.

For custom features, see [main_example.lua](WindUI/main_example.lua) for usage examples.

## Original Repository

Based on [WindUI by Footagesus](https://github.com/Footagesus/WindUI)

## License

MIT License - See [LICENSE](WindUI/LICENSE) file for details.

