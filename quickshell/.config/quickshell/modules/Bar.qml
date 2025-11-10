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

            // required property ShellScreen modelData

            screen: scope.modelData
            color: "transparent"
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

            // Keys.onPressed: console.log("PRESSSS")

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
                x: barLayout.x
                y: barLayout.y
                // width: barWin - barLayout.width
                width: barLayout.width
                height: barLayout.height
                intersection: Intersection.Combine
                // intersection: Intersection.Xor

                regions: regions.instances
            }

            Variants {
                id: regions

                model: menus.children

                Region {
                    required property Item modelData

                    x: modelData.x
                    y: modelData.y
                    width: modelData.width
                    height: modelData.height

                    onShapeChanged: console.log(x, y, width, height)
                }
            }

            PersistentProperties {
                id: menuVisible
                reloadableId: "menuVisible"

                property bool start: false
            }

            function isMenuVisible(): bool {
                return menuVisible.start;
            }

            HyprlandFocusGrab {
                windows: [barWin]
                active: barWin.isMenuVisible()
                onCleared: {
                    menuVisible.start = false;
                }
            }

            Menus {
                id: menus
                bar: barLayout
                menuVisible: menuVisible
            }

            Item {
                id: barLayout

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                height: 26

                BarLayout {
                    screen: barWin.screen
                    menuVisible: menuVisible
                }
            }
        }
    }
}
