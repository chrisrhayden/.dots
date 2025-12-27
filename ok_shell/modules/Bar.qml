pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import QtQuick

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        PanelWindow {
            id: barWin
            focusable: true

            screen: scope.modelData
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore

            HyprlandFocusGrab {
                id: hypr_focus

                active: menuVisible.start

                windows: [barWin]
                onCleared: {
                    menuVisible.start = false;
                }
            }

            GlobalShortcut {
                name: "open_start_menu"
                description: "open the start menu"
                onPressed: {
                    let moniter = Hyprland.monitorFor(barWin.screen);
                    if (moniter === Hyprland.focusedMonitor) {
                        menuVisible.start = !menuVisible.start;
                    }
                }
            }

            mask: Region {
                x: 0
                y: 0
                width: barWin.width
                height: barWin.height - barLayout.height
                intersection: Intersection.Xor

                regions: regions.instances
            }
            // mask: Region {
            //     x: barLayout.x
            //     y: barLayout.y
            //     width: barLayout.width
            //     height: barLayout.height
            //     intersection: Intersection.Combine
            //
            //     regions: regions.instances
            // }

            Variants {
                id: regions

                model: menus.children

                Region {
                    required property Item modelData

                    x: modelData.x
                    y: modelData.y
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            anchors {
                left: true
                right: true
                top: true
                bottom: true
            }

            margins {
                right: 14
                left: 14
                // right: 8
                // left: 8
            }

            PersistentProperties {
                id: menuVisible
                reloadableId: "menuVisible"

                property bool start: false
            }

            MouseArea {
                anchors.fill: parent

                focus: true
                Keys.priority: Keys.BeforItem
                Keys.onPressed: evt => {
                    if (evt.key === Qt.Key_Escape) {
                        menuVisible.start = false;
                    }
                }

                Menus {
                    id: menus
                    menuVisible: menuVisible

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: barLayout.top
                }

                BarLayout {
                    id: barLayout
                    height: 26

                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }

                    screen: barWin.screen
                    menuVisible: menuVisible
                }
            }
        }
    }
}
// }
