import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    function toggleCheatsheet(): void {
        const provider = KeybindsService?.cheatsheetProvider || CompositorService?.compositor || "hyprland";
        KeybindsService?.loadCheatsheet(provider);
        if (PopoutService?.hyprKeybindsModalLoader) {
            PopoutService.hyprKeybindsModalLoader.active = true;
            if (PopoutService.hyprKeybindsModalLoader.item) {
                if (PopoutService.hyprKeybindsModalLoader.item.shouldBeVisible) {
                    PopoutService.hyprKeybindsModalLoader.item.close();
                } else {
                    PopoutService.hyprKeybindsModalLoader.item.open();
                }
            } else {
                Qt.callLater(() => {
                    if (PopoutService.hyprKeybindsModalLoader?.item) {
                        PopoutService.hyprKeybindsModalLoader.item.open();
                    }
                });
            }
        }
    }

    IpcHandler {
        target: "keybindCheatsheet"

        function open(): void {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
        }

        function toggle(): void {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
        }

        function cheatsheet(): void {
            root.toggleCheatsheet();
        }
    }

    Component.onCompleted: {
        console.info("KeybindCheatsheetDaemon: initialized successfully")
    }
}
