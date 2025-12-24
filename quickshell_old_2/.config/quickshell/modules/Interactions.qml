import Quickshell

import QtQuick

MouseArea {
    id: root
    required property PersistentProperties menuVisible
    focus: true

    hoverEnabled: true

    onClicked: () => {
        console.log("Interactions.qml");
        menuVisible.start = false;
    }

    onContainsMouseChanged: () => {
        menuVisible.start = false;
    }
}
