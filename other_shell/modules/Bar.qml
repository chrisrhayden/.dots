import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs

PanelWindow {
    id: root
    required property ShellScreen modelData

    anchors {
        // left: true
        // right: true
        bottom: true
    }

    implicitWidth: modelData.width - (14 * 2)
    implicitHeight: 20

    color: Style.colors.bg

    Item {
        width: root.implicitWidth
        height: root.implicitHeight

        RowLayout {
            id: main_bar
            anchors.fill: parent
            Layout.fillHeight: true
            Layout.fillWidth: true

            Item {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft

                WorkSpaces {
                    screen: root.modelData
                }
            }
            Item {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter

                Clock {}
            }

            Item {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight

                Bluetooth {
                    anchors.right: parent.right
                    win: root
                }
            }
        }
    }
}
