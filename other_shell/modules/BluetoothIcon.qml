import Quickshell
import QtQuick
import qs

import Quickshell.Bluetooth

Rectangle {
    id: bt_icon

    height: parent.height
    width: parent.height

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
        // leftPadding: 2
        // rightPadding: 2
        color: mouse_area.containsMouse ? Style.colors.fg_hover : Style.colors.fg
        text: bt_icon.icon
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
    }
}
