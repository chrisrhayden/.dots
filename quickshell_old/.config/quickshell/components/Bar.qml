import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: bar
    required property ShellScreen screen

    anchors.fill: parent

    Item {
        id: ws_item

        Layout.alignment: Qt.AlignLeft
        Layout.fillHeight: true

        WorkSpaces {
            screen: bar.screen
        }
    }
    Item {
        id: clock_item

        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: true

        Clock {}
    }

    Item {
        Layout.alignment: Qt.AlignRight
        Layout.fillHeight: true

        Tray {}
    }
}
