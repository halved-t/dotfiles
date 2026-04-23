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
    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: 5
    margins.left: 5
    margins.right: 5


    implicitHeight: 32

    Rectangle {
        anchors.fill: parent
        radius: 5
        id: root
        property color colBg: "#1e1e2e"
        property color colFg: "#cdd6f4"
        property color colMuted: "#7f849c"
        property color colCyan: "#89dceb"
        property color colBlue: "#89b4fa"
        property color colYellow: "#f9e2af"
        property string fontFamily: "JetBrainsMono Nerd Font"
        property int fontSize: 13
        color: root.colBg

        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            Repeater {
                model: 9
                Text {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    text: index + 1
                    color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted)
                    font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + (index + 1))
                    }
                }
            }

            Item { Layout.fillWidth: true }

            Text {
                id: clock
                color: root.colBlue
                font { family: root.fontFamily; pixelSize: root.fontSize; bold: true }
                text: Qt.formatDateTime(new Date(), "HH:mm | ddd, MMM dd")
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "HH:mm | ddd, MMM dd")
                }
            }
        }
    }
}