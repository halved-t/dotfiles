import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: rmain
    color: "transparent"
    
    anchors.left: true
    anchors.top: true
    anchors.bottom: true

    margins.top: 5
    margins.left: 5
    margins.bottom: 5

    implicitWidth: 38 

    Rectangle {
        anchors.fill: parent
        radius: 5
        id: root
        property color colBg: "#282a36"
        property color colFg: "#f8f8f2"
        property color colMuted: "#6272a4"
        property color colCyan: "#8be9fd"
        property color colBlue: "#bd93f9"
        property color colYellow: "#f1fa8c"
        property string fontFamily: "JetBrainsMono Nerd Font"
        property int fontSize: 13
        color: Qt.rgba(0.156, 0.165, 0.212, 0.92)

        property string currentVolume: "0%"

        function refreshVol() {
                volume.running = false
                volume.running = true
        }

        Process {
            id: volume
            command: ["sh", "-c", "pactl list sinks | grep 'Volume:' | head -n1 | awk '{print $5}'"]
            running: true
            stdout: StdioCollector  {
                onStreamFinished: root.currentVolume = text.replace(/[\r\n]+/gm, "")
            }
        }

        Timer {
            interval: 75
            running: true
            repeat: true
            onTriggered: {
                root.refreshVol()
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 12

            Repeater {
                model: 10
                Text {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    text: index + 1
                    color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
                    font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
                    Layout.alignment: Qt.AlignHCenter 

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }

            Item { Layout.fillHeight: true }

            Text {
                text: root.currentVolume
                color: root.colYellow
                font { family: root.fontFamily; pixelSize: 11; bold: true }
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("exec pavucontrol")
                }
            }

            Text {
                id: clock
                color: root.colBlue
                font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
                text: Qt.formatDateTime(new Date(), "HH\nmm")
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH\nmm")
                }
            }

            Text {
                text: ""
                color: root.colCyan
                font { family: root.fontFamily; pixelSize: 16; bold: true }
                Layout.alignment: Qt.AlignHCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("exec wofi")
                }
            }
        }
    }
}
