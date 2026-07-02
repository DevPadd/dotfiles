import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Networking
import Quickshell.Services.SystemTray
import Quickshell.Widgets

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        implicitHeight: 30

        color: "#000000"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 22
            anchors.rightMargin: 22
            anchors.topMargin: 5
            anchors.bottomMargin: 5

            // ─── LEFT: Workspaces 1-5 ─────────────────────────────
            RowLayout {
                Layout.alignment: Qt.AlignLeft
                spacing: 10

                Repeater {
                    model: 5
                    Text {
                        required property int index
                        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                        text: (index + 1)
                        color: isActive ? "#ffffff" : "#808080"

                        font {
                            family: "JetBrainsMono Nerd Font"
                            weight: Font.Medium
                            pixelSize: 14
                        }
                    }
                }
            }

            // ─── CENTER: Clock & Date ──────────────────────────────
            Item {
                anchors.centerIn: parent
                Text {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(clock.date, "hh:mm MM月dd日(") + ["日", "月", "火", "水", "木", "金", "土"][clock.date.getDay()] + ")"

                    color: "#ffffff"
                    font {
                        family: "JetBrainsMono Nerd Font"
                        weight: Font.Medium
                        pixelSize: 14
                    }
                }
            }

            // ─── RIGHT: Battery, Internet, App Tray ────────────────
            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                spacing: 14

                RowLayout {
                    spacing: 6

                    Repeater {
                        model: SystemTray.items

                        Rectangle {

                            width: 20
                            height: 18
                            color: "transparent"

                            Image {
                                anchors.fill: parent
                                source: modelData.icon
                                fillMode: Image.PreserveAspectFit
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    // Triggers the primary action (e.g., opens the app's window)
                                    modelData.activate();
                                }
                                onPressAndHold: {
                                    // Triggers secondary action (e.g., middle click/menu)
                                    modelData.secondaryActivate();
                                }
                            }
                        }
                    }
                }

                // internet
                Text {
                    text: Networking.connectivity === NetworkConnectivity.Full ? "󰖩" : "󰖪"
                    color: Networking.connectivity === NetworkConnectivity.Full ? "#ffffff" : "#808080"
                    font {
                        family: "JetBrainsMono Nerd Font"
                        weight: Font.Medium
                        pixelSize: 14
                    }
                }

                // Battery
                Text {
                    id: batteryText
                    property real percent: UPower.displayDevice?.percentage !== undefined ? UPower.displayDevice.percentage * 100 : 0
                    property bool charged: UPower.displayDevice?.state === UPowerDeviceState.FullyCharged
                    text: batteryText.charged ? "100%" : Math.round(batteryText.percent) + "%"
                    color: "#ffffff"
                    font {
                        family: "JetBrainsMono Nerd Font"
                        weight: Font.Medium
                        pixelSize: 14
                    }
                }

                // Internet (SSID or No connection)

                // App tray (placeholder — plain text label, no nerd icons)
                // Text {
                //     text: "Tray"
                //     color: "#ffffff"
                //     font {
                //         family: "JetBrainsMono Nerd Font"
                //         weight: Font.Medium
                //         pixelSize: 14
                //     }
                // }
            }
        }
    }
}
