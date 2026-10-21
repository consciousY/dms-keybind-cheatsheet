import QtQuick
import QtQuick.Layouts
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "keybindCheatsheet"

    StyledText {
        width: parent.width
        text: I18n.tr("Keybind Cheatsheet Quick Access")
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: I18n.tr("Global shortcut Super + K is configured in Hyprland to instantly pop up the Keybind Settings & Cheatsheet.")
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    ToggleSetting {
        settingKey: "showBarLabel"
        label: I18n.tr("Show 'Super+K' label on bar pill")
        description: I18n.tr("Displays the shortcut text next to the keyboard icon in the DankBar")
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "openCheatsheetOnRightClick"
        label: I18n.tr("Right-click for Cheatsheet overlay")
        description: I18n.tr("Right-clicking the bar icon opens the cheatsheet overlay instead of settings")
        defaultValue: true
    }
}
