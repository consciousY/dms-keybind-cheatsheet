import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    function toggleCheatsheet(): void {
        if (!KeybindsService?.cheatsheetAvailable) {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
            return;
        }

        const provider = KeybindsService?.cheatsheetProvider || "hyprland";
        KeybindsService?.loadCheatsheet(provider);

        if (typeof PopoutService?.showKeybindsModal === "function") {
            PopoutService.showKeybindsModal();
            return;
        }

        const loader = PopoutService?.keybindsModalLoader || PopoutService?.hyprKeybindsModalLoader;
        if (loader) {
            loader.active = true;
            if (loader.item) {
                if (loader.item.shouldBeVisible) {
                    loader.item.close();
                } else {
                    loader.item.open();
                }
            } else {
                Qt.callLater(() => {
                    if (loader.item) {
                        loader.item.open();
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
