# 1.6.61 (Custom Enhanced)
## Changelog:
- Fixed Dropdown Tab Desc Width
- Added `Locked` to Dropdown Tabs;
- Added `:LockValues({})` to `Dropdown`
- Added more theme tags (more soon)
- Reworked `Toggle` and `Checkbox`

## Custom Enhancements (by ScriptsForDays):
- Added `:SetValues()` method to Dropdown for dynamic value updates
- Added custom accent customization methods:
  - `WindUI:SetCustomAccent()`
  - `WindUI:SetCustomBackground()`
  - `WindUI:SetCustomText()`
  - `WindUI:SetCustomButton()`
  - `WindUI:SetCustomIcon()`
  - `WindUI:SetCustomDialog()`
  - `WindUI:SetCustomOutline()`
  - `WindUI:SetCustomProperty()` (generic method)
  - `WindUI:ClearCustomOverrides()`
  - `WindUI:ClearCustomProperty()`
  - `WindUI:GetCustomOverrides()`
- Enhanced dropdown updates to handle open menus and search filters
- Custom overrides persist when switching themes