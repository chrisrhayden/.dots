import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth

import qs

PopupWindow {
    id: root

    required property bool hover

    visible: hover

    implicitWidth: bt_pan.width
    implicitHeight: bt_pan.height

    WrapperRectangle {
        id: bt_pan
        anchors.fill: parent
        color: Style.colors.bg_hover
        margin: 8

        Loader {
            sourceComponent: Bluetooth.devices.values.length > 0 ? bt_devices : no_bt_devices
        }
    }

    Component {
        id: no_bt_devices
        Text {
            text: "no devices"
            color: "black"
            font: Style.bar_font
        }
    }

    Component {
        id: bt_devices
        Column {
            Repeater {
                model: Bluetooth.devices

                BluetoothPanItem {}
            }
        }
    }
}
