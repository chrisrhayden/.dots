import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import build

RowLayout {
    id: bar

    required property ShellScreen screen
    required property PersistentProperties menuVisible

    Item {
        Layout.fillHeight: true

        RowLayout {
            anchors.fill: parent
            uniformCellSizes: false
            spacing: 4

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                Apps {
                    id: apps
                    startWindow: menuVisible.start
                }
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

        // Component.onCompleted: ts.test()
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
