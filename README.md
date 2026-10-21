# Keybind Cheatsheet Plugin for DankMaterialShell (DMS)

A sleek, lightweight Quickshell plugin for **DankMaterialShell** that provides instant access to your compositor keybind settings, cheatsheet overlay, and hotkey configuration.

![DMS Keybind Cheatsheet](https://raw.githubusercontent.com/consciousY/dms-keybind-cheatsheet/main/screenshot.png)

## Features

- ⌨️ **Global Shortcut (`Super + K`)**: Instantly pops up the DMS Keybind Settings window anywhere on your desktop.
- 📊 **DankBar Widget**: Minimal, elegant pill showing a keyboard icon and shortcut indicator.
  - **Left-Click**: Focuses or toggles the Keybind Settings window.
  - **Right-Click**: Launches the full-screen interactive Keybinds Cheatsheet overlay.
- 🎛️ **Control Center Tile**: Integrated tile and quick-action panel with direct buttons for settings and cheatsheet.
- ⚙️ **Configurable**: Easily enable/disable pill labels or customize behaviors via **DMS Settings → Plugins**.
- 🚀 **Zero Overhead**: Fully native QML / Quickshell implementation with seamless Hyprland integration.

---

## Installation

### Method 1: Via DMS Plugin Registry (Recommended once published)
```bash
dms plugins install keybindCheatsheet
```

### Method 2: Manual Installation
Clone this repository directly into your DMS plugins directory:

```bash
mkdir -p ~/.config/DankMaterialShell/plugins
git clone https://github.com/consciousY/dms-keybind-cheatsheet.git ~/.config/DankMaterialShell/plugins/KeybindCheatsheet
```

Then scan and enable the plugin:
```bash
dms ipc call plugin-scan scan
dms ipc call plugins enable keybindCheatsheet
```

---

## Hyprland Shortcut Configuration

To bind <kbd>Super</kbd> + <kbd>K</kbd> to pop up the Keybind Settings window, add the following to your `~/.config/hypr/dms/binds-user.lua` (or `hyprland.conf`):

```lua
-- Super + K: Pop up Keybind Settings window
hl.bind("SUPER + K", hl.dsp.exec_cmd("dms ipc call settings focusOrToggleWith keybinds"))

-- Super + Shift + K: Toggle Keybinds Cheatsheet overlay
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"))
```

Reload Hyprland to apply:
```bash
hyprctl reload
```

---

## Adding to DankBar

1. Open **DMS Settings** (<kbd>Super</kbd> + <kbd>,</kbd>).
2. Go to **Appearance → DankBar Layout**.
3. Add `keybindCheatsheet` to your desired section (e.g., right or center).

---

## License

MIT License — see [LICENSE](LICENSE) for details.
