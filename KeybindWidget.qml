import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    // Control Center Integration
    ccWidgetIcon: "keyboard"
    ccWidgetPrimaryText: I18n.tr("Keybind Cheatsheet")
    ccWidgetSecondaryText: "Super + K"
    ccWidgetIsActive: true

    onCcWidgetToggled: {
        PopoutService?.focusOrToggleSettingsWithTab("keybinds");
    }

    ccDetailContent: Component {
        Rectangle {
            implicitHeight: 140
            radius: Theme.cornerRadius
            color: Theme.surfaceContainerHigh

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Theme.spacingM
                spacing: Theme.spacingS

                StyledText {
                    text: I18n.tr("Keybind Cheatsheet")
                    font.pixelSize: Theme.fontSizeMedium
                    font.weight: Font.DemiBold
                    color: Theme.surfaceText
                }

                StyledText {
                    text: I18n.tr("Press Super + K anywhere to open keybind settings & cheatsheet")
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.surfaceVariantText
                }

                Item { Layout.fillHeight: true }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Theme.spacingS

                    StyledRect {
                        Layout.fillWidth: true
                        height: 36
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
                        Layout.fillWidth: true
                        height: 36
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
                                KeybindsService?.loadCheatsheet();
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
                    text: "Super+K"
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
                    if (mouse.button === Qt.RightButton) {
                        KeybindsService?.loadCheatsheet();
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
