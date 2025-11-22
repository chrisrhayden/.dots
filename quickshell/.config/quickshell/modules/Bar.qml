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
            }

            PersistentProperties {
                id: menuVisible
                reloadableId: "menuVisible"

                property bool start: false
            }

            // Interactions {
            //     id: interactions
            //     anchors.fill: parent
            //
            //     menuVisible: menuVisible

            // Menus {
            //     id: menus
            //     menuVisible: menuVisible
            //
            //     anchors.top: parent.top
            //     anchors.left: parent.left
            //     anchors.right: parent.right
            //     anchors.bottom: barLayout.top
            // }

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
// }
