import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    IpcHandler {
        target: "keybindCheatsheet"

        function open(): void {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
        }

        function toggle(): void {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
        }

        function cheatsheet(): void {
            KeybindsService?.loadCheatsheet();
        }
    }

    Component.onCompleted: {
        console.info("KeybindCheatsheetDaemon: initialized successfully")
    }
}
