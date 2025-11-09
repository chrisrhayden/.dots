import Quickshell
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: bar

    required property ShellScreen screen

    anchors.fill: parent

    // uniformCellSizes: true

    Item {
        // Layout.alignment: Qt.AlignLeft
        Layout.fillHeight: true

        RowLayout {
            anchors.fill: parent
            uniformCellSizes: false
            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                Start {}
            }
            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

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

        Clock {}
    }
    Item {
        Layout.alignment: Qt.AlignRight
        Layout.fillHeight: true
        // Layout.fillWidth: true
        // Layout.minimumWidth: childrenRect.width

        RowLayout {
            anchors.fill: parent
            // anchors.left: parent.left
            // height: parent.height
            layoutDirection: Qt.RightToLeft
            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                Tray {}
            }

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                Power {}
            }
        }
    }
}
