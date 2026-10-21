import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    readonly property bool showBarLabel: pluginData?.showBarLabel ?? true
    readonly property bool openCheatsheetOnRightClick: pluginData?.openCheatsheetOnRightClick ?? true
    readonly property bool cheatsheetSupported: KeybindsService?.cheatsheetAvailable ?? false

    function toggleCheatsheet(): void {
        if (!cheatsheetSupported) {
            PopoutService?.focusOrToggleSettingsWithTab("keybinds");
            return;
        }

        const provider = KeybindsService?.cheatsheetProvider || "hyprland";
        KeybindsService?.loadCheatsheet(provider);

        const loader = PopoutService?.keybindsModalLoader;
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

    // Control Center Integration
    ccWidgetIcon: "keyboard"
    ccWidgetPrimaryText: I18n.tr("Keybind Cheatsheet")
    ccWidgetSecondaryText: cheatsheetSupported ? I18n.tr("Settings & Cheatsheet") : I18n.tr("Settings")
    ccWidgetIsActive: true

    onCcWidgetToggled: {
        PopoutService?.focusOrToggleSettingsWithTab("keybinds");
    }

    ccDetailContent: Component {
        Rectangle {
            implicitHeight: detailCol.implicitHeight + Theme.spacingM * 2
            radius: Theme.cornerRadius
            color: Theme.surfaceContainerHigh

            ColumnLayout {
                id: detailCol
                anchors.fill: parent
                anchors.margins: Theme.spacingM
                spacing: Theme.spacingS

                StyledText {
                    text: I18n.tr("Keybind Management")
                    font.pixelSize: Theme.fontSizeMedium
                    font.weight: Font.DemiBold
                    color: Theme.surfaceText
                }

                StyledText {
                    text: root.cheatsheetSupported
                        ? I18n.tr("Quick access to view shortcuts, open settings, or launch the cheatsheet overlay")
                        : I18n.tr("Quick access to view and configure compositor shortcuts in settings")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.surfaceVariantText
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }

                Item { Layout.fillHeight: true }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Theme.spacingS

                    StyledRect {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Theme.buttonHeightS
                        radius: Theme.cornerRadiusSmall
                        color: btn1Mouse.containsMouse ? Theme.surfaceContainerHighest : Theme.surfaceContainer

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: Theme.spacingXS
                            DankIcon {
                                name: "settings"
                                size: Theme.iconSizeSmall
                                color: Theme.primary
                            }
                            StyledText {
                                text: I18n.tr("Settings")
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceText
                            }
                        }

                        MouseArea {
                            id: btn1Mouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                PopoutService?.focusOrToggleSettingsWithTab("keybinds");
                            }
                        }
                    }

                    StyledRect {
                        visible: root.cheatsheetSupported
                        Layout.fillWidth: true
                        Layout.preferredHeight: Theme.buttonHeightS
                        radius: Theme.cornerRadiusSmall
                        color: btn2Mouse.containsMouse ? Theme.surfaceContainerHighest : Theme.surfaceContainer

                        RowLayout {
                            anchors.centerIn: parent
                            spacing: Theme.spacingXS
                            DankIcon {
                                name: "help_outline"
                                size: Theme.iconSizeSmall
                                color: Theme.primary
                            }
                            StyledText {
                                text: I18n.tr("Cheatsheet")
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceText
                            }
                        }

                        MouseArea {
                            id: btn2Mouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.toggleCheatsheet();
                            }
                        }
                    }
                }
            }
        }
    }

    // Horizontal DankBar Pill
    horizontalBarPill: Component {
        StyledRect {
            id: pillRect
            width: pillRow.implicitWidth + Theme.spacingM * 2
            height: parent.widgetThickness
            radius: Theme.cornerRadius
            color: mouseArea.containsMouse ? Theme.surfaceContainerHighest : Theme.surfaceContainerHigh

            RowLayout {
                id: pillRow
                anchors.centerIn: parent
                spacing: Theme.spacingXS

                DankIcon {
                    name: "keyboard"
                    size: Theme.iconSizeSmall
                    color: Theme.primary
                }

                StyledText {
                    visible: root.showBarLabel
                    text: I18n.tr("Keybinds")
                    font.pixelSize: Theme.fontSizeSmall
                    font.weight: Font.Medium
                    color: Theme.surfaceText
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton && root.openCheatsheetOnRightClick && root.cheatsheetSupported) {
                        root.toggleCheatsheet();
                    } else {
                        PopoutService?.focusOrToggleSettingsWithTab("keybinds");
                    }
                }
            }
        }
    }

    // Vertical DankBar Pill
    verticalBarPill: Component {
        StyledRect {
            width: parent.widgetThickness
            height: Theme.iconSizeSmall + Theme.spacingM * 2
            radius: Theme.cornerRadius
            color: vertMouse.containsMouse ? Theme.surfaceContainerHighest : Theme.surfaceContainerHigh

            DankIcon {
                anchors.centerIn: parent
                name: "keyboard"
                size: Theme.iconSizeSmall
                color: Theme.primary
            }

            MouseArea {
                id: vertMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    PopoutService?.focusOrToggleSettingsWithTab("keybinds");
                }
            }
        }
    }
}
