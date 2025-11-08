import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: bar
    required property ShellScreen screen

    anchors.fill: parent

    Item {
        Layout.alignment: Qt.AlignLeft
        Layout.fillHeight: true

        RowLayout {
            height: parent.height

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
        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: true
        // Layout.fillWidth: true
        // Layout.horizontalStretchFactor: 1

        Clock {}
    }
    Item {
        Layout.alignment: Qt.AlignRight
        Layout.fillHeight: true
        // Layout.fillWidth: true
        // Layout.horizontalStretchFactor: 1

        Tray {}
    }
}
