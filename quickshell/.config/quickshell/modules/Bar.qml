import Quickshell
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWin

            required property var modelData

            screen: modelData

            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            margins {
                right: 14
                left: 14
            }

            mask: Region {
                item: barLaout
            }

            color: "transparent"

            Item {
                id: barLaout
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                implicitHeight: 26

                BarLayout {
                    screen: barWin.screen
                }
            }
        }
    }
}
