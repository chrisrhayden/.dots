import QtQuick
import Quickshell

import "components"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win
            required property var modelData
            screen: modelData

            color: Style.bg

            anchors {
                top: false
                left: true
                right: true
                bottom: true
            }

            margins {
                right: 14
                left: 14
            }

            implicitHeight: 26
            exclusionMode: ExclusionMode.Ignore

            Bar {
                screen: win.screen
            }
        }
    }
}
