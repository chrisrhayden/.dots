pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs.modules

Item {
    id: root

    required property PersistentProperties menuVisible
    // anchors.fill: parent

    Item {
        id: startWrapper

        anchors.left: parent.left
        anchors.bottom: parent.bottom

        implicitWidth: 0
        implicitHeight: 0
        width: root.menuVisible.start ? start.implicitWidth : 0
        height: root.menuVisible.start ? start.implicitHeight : 0

        // visible: root.menuVisible.start

        Loader {
            id: start

            active: root.menuVisible.start

            sourceComponent: Apps {
                menuVisible: root.menuVisible
            }
        }
    }
}
