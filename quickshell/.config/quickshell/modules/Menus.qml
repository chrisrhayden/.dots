pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Item {
    id: root

    required property Item bar
    required property PersistentProperties menuVisible

    Item {
        id: startWrapper

        x: root.bar.x
        y: root.bar.y - start.height

        width: root.menuVisible.start ? start.width : 0
        height: root.menuVisible.start ? start.height : 0

        visible: root.menuVisible.start

        Loader {
            id: start

            active: root.menuVisible.start

            sourceComponent: Start {
                menuVisible: root.menuVisible
            }
        }
    }
}
