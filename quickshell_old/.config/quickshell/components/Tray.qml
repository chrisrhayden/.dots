// import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import qs

Row {
    height: parent.height
    anchors.right: parent.right

    Repeater {
        model: SystemTray.items

        Rectangle {
            id: root
            required property SystemTrayItem modelData

            width: parent.height
            height: parent.height

            color: Style.bg

            IconImage {
                asynchronous: true

                anchors.centerIn: parent

                width: parent.height - 4
                height: parent.height - 4

                source: (() => {
                        const [name, path] = root.modelData.icon.split("?path=");

                        let icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);

                        console.log(icon);

                        return icon;
                    })()
            }
        }
    }
}
