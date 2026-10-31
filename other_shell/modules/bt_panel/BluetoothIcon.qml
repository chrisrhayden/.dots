pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import QtQuick
import qs

import Quickshell.Bluetooth

Item {
    id: root
    height: parent.height
    width: icon_root.width
    // height: 20
    // width: 20

    Rectangle {
        id: icon_root
        Component.onCompleted: {
            console.log("|<><><><>", width);
        }

        height: parent.height
        // height: 20
        width: 20
        // width: text.width + 4
        // anchors.centerIn: parent
        // anchors.fill: parent
        // margin: 4

        color: mouse_area.containsMouse ? Style.colors.bg_hover : Style.colors.bg
        radius: Style.radius

        property string icon: {
            const adapter = Bluetooth.defaultAdapter;

            if (adapter.devices.values.some(dv => dv.connected)) {
                return Style.bluetooth_icons.connected;
            } else if (adapter.enabled) {
                return Style.bluetooth_icons.on;
            } else {
                return Style.bluetooth_icons.off;
            }
        }

        Text {
            id: text
            anchors.centerIn: parent
            font: Style.icon_font
            color: mouse_area.containsMouse ? Style.colors.fg_hover : Style.colors.fg
            text: icon_root.icon
        }
    }

    // BluetoothPan {
    //     // anchor.item: icon_root
    //     anchor.item: root
    //     anchor.gravity: Edges.Top | Edges.Left
    //     // anchor.rect.x: icon_root.x + icon_root.width
    //     anchor.rect.x: root.x
    //     hover: mouse_area.containsMouse
    // }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
    }
}
