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
        text: I18n.tr("Keybind Cheatsheet Plugin")
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: I18n.tr("Provides quick access to the keybind settings window and interactive cheatsheet overlay from DankBar, Control Center, and IPC.")
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    ToggleSetting {
        settingKey: "showBarLabel"
        label: I18n.tr("Show 'Keybinds' label on bar pill")
        description: I18n.tr("When disabled, only the keyboard icon is shown in the DankBar pill")
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "openCheatsheetOnRightClick"
        label: I18n.tr("Right-click for Cheatsheet overlay")
        description: I18n.tr("Right-clicking the bar icon opens the cheatsheet overlay instead of settings")
        defaultValue: true
    }
}
