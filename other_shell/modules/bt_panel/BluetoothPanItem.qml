import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth

import qs

WrapperItem {
    id: root

    required property BluetoothDevice modelData

    property string connected_icon: {
        if (modelData.state === BluetoothDeviceState.Connected) {
            Style.bluetooth_icons.connected;
        } else {
            Style.bluetooth_icons.off;
        }
    }

    RowLayout {
        Text {
            color: "black"
            text: root.connected_icon
            font: Style.icon_font
        }
        Text {
            text: "|"
            font: Style.bar_font
        }
        Text {
            text: root.modelData.name
            color: "black"
            font: Style.bar_font
        }
    }
}
