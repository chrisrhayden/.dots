pragma ComponentBehavior: Bound
import QtQuick

import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth

WrapperItem {
    id: root

    height: parent.height
    required property QtObject win

    Row {
        id: b_layout
        height: parent.height

        BluetoothIcon {}

        Repeater {
            model: Bluetooth.devices.values.filter(bd => bd.connected)
            height: parent.height

            BluetoothDev {
                win: root.win
            }
        }
    }
}
