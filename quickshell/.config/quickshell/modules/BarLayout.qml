import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components

RowLayout {
    id: bar

    required property ShellScreen screen
    required property PersistentProperties menuVisible

    anchors.fill: parent

    Item {
        Layout.fillHeight: true

        RowLayout {
            anchors.fill: parent
            uniformCellSizes: false
            spacing: 0

            Item {
                Layout.fillHeight: true
                Layout.minimumWidth: childrenRect.width

                StyleRect {
                    id: root

                    property bool startWindow: false

                    anchors.centerIn: parent

                    width: parent.height
                    height: parent.height

                    hovered: mouseArea.containsMouse

                    StyleText {
                        anchors.centerIn: parent
                        hovered: mouseArea.containsMouse

                        text: "󰣇"
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: bar.menuVisible.start = !bar.menuVisible.start
                    }
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
