import Quickshell
import QtQuick

import qs

import Quickshell.Bluetooth

Item {
    id: root
    required property BluetoothDevice modelData
    required property QtObject win
    height: parent.height
    width: dev_icon.width + 8

    Rectangle {
        height: parent.height
        width: dev_icon.width + 8

        color: mouse_area.containsMouse ? Style.colors.bg_hover : Style.colors.bg
        radius: Style.radius

        Column {
            anchors.centerIn: parent
            height: parent.height
            width: dev_icon.width
            spacing: 1

            Text {
                id: dev_icon
                height: parent.height * 0.6
                color: mouse_area.containsMouse ? Style.colors.fg_hover : Style.colors.fg
                text: Style.bluetooth_icons.headphones
                font.family: Style.icon_font.family
            }

            Item {
                height: (parent.height * 0.4) - 2
                width: parent.width

                Rectangle {
                    height: parent.height
                    width: parent.width
                    color: Style.colors.fg
                    radius: 2
                }

                Rectangle {
                    height: parent.height
                    width: parent.width * root.modelData.battery

                    radius: 2
                    anchors.bottom: parent.bottom
                    color: mouse_area.containsMouse ? Style.colors.fg_hover : Style.colors.bg_hover
                }
            }
        }
    }

    BluetoothPanel {
        id: pan
        anchor.item: root
        anchor.gravity: Edges.Top | Edges.Left
        anchor.rect.x: root.x
        device: root.modelData
    }

    Timer {
        id: bt_timer

        running: false
        repeat: false

        onTriggered: function () {
            pan.btn_hover = false;
        }
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if (bt_timer.running) {
                bt_timer.stop();
            }
            pan.btn_hover = true;
        }
        onExited: {
            bt_timer.interval = 200;
            bt_timer.running = true;
        }

        onWheel: function (wheel) {
            if (wheel.angleDelta.y > 0) {
                pan.increase();
            } else {
                pan.decrease();
            }
        }
    }
}
