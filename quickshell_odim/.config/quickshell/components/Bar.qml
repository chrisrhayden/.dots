import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: bar
    required property ShellScreen screen

    anchors.fill: parent

    Rectangle {
        Layout.alignment: Qt.AlignLeft
        Layout.fillHeight: true

        RowLayout {
            id: ws_item
            anchors.fill: parent

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                Start {}
            }
            Item {
                Layout.fillHeight: true

                WorkSpaces {
                    screen: bar.screen
                }
            }
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
