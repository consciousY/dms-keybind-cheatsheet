# Keybind Cheatsheet Plugin for DankMaterialShell (DMS)

A sleek, lightweight composite Quickshell plugin for **DankMaterialShell** that provides a DankBar pill and Control Center shortcut to open DMS keybind settings and the cheatsheet modal.

![DMS Keybind Cheatsheet](screenshot.png)

## Why This Plugin?

While DMS provides keybind settings and cheatsheet features via CLI/IPC or through the launcher (such as `dankLauncherKeys`), **Keybind Cheatsheet** brings them front-and-center as an interactive desktop surface:
- 🖱️ **Always Accessible**: Dedicated pill in your DankBar — left-click to open Settings, right-click to launch the visual Cheatsheet overlay.
- 🎛️ **Control Center Integration**: Dedicated tile and detail panel for quick toggling alongside your system controls.
- 📡 **IPC Daemon Target**: Exposes `dms ipc call keybindCheatsheet cheatsheet` and `open`/`toggle`.
- ⚙️ **Configurable**: Toggle bar label visibility or right-click behaviors via **DMS Settings → Plugins**.

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

## Adding to DankBar

1. Open **DMS Settings** (<kbd>Super</kbd> + <kbd>,</kbd>).
2. Go to **Appearance → DankBar Layout**.
3. Add `keybindCheatsheet` to your desired section (e.g., right or center).

---

## Optional: Global Hotkey Binding

If you wish to trigger the settings or cheatsheet via a global compositor hotkey (such as <kbd>Super</kbd> + <kbd>K</kbd>), you can optionally add them to your compositor config:

### Hyprland (`~/.config/hypr/dms/binds-user.lua` or `hyprland.conf`)
```lua
-- Super + K: Pop up Keybind Settings window
hl.bind("SUPER + K", hl.dsp.exec_cmd("dms ipc call settings focusOrToggleWith keybinds"))

-- Super + Shift + K: Toggle Keybinds Cheatsheet overlay
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd("dms ipc call keybindCheatsheet cheatsheet"))
```

### Niri (`config.kdl`)
```kdl
binds {
    Mod+K { spawn "dms" "ipc" "call" "settings" "focusOrToggleWith" "keybinds"; }
    Mod+Shift+K { spawn "dms" "ipc" "call" "keybindCheatsheet" "cheatsheet"; }
}
```

---

## Supported Compositors

The cheatsheet overlay natively supports compositors with DMS cheatsheet providers:
- **Hyprland**
- **Niri**
- **MangoWC**
- **Aqueous**

*(On other compositors, the plugin gracefully falls back to opening the Keybinds Settings tab).*

---

## License

MIT License — see [LICENSE](LICENSE) for details.
