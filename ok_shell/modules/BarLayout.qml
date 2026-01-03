// pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

Item {
    id: bar
    required property ShellScreen screen
    required property PersistentProperties menuVisible

    Component {
        id: battery

        Battery {}
    }

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                uniformCellSizes: false
                spacing: 4

                Item {
                    Layout.fillHeight: true
                    Layout.minimumWidth: childrenRect.width

                    AppsBtn {
                        id: apps
                        menuVisible: bar.menuVisible
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

                    Sys {}
                }

                Item {
                    Layout.fillHeight: true
                    Layout.minimumWidth: childrenRect.width
                    Tray {}
                }

                Item {
                    Layout.fillHeight: true
                    Layout.minimumWidth: childrenRect.width

                    Loader {
                        height: parent.height
                        width: sourceComponent.width

                        active: UPower.displayDevice.isLaptopBattery

                        sourceComponent: battery
                    }
                }
            }
        }
    }
}
