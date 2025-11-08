import QtQuick
import qs

Rectangle {
    id: root

    required property string message
    property var onClick: null

    color: Style.bg
    radius: Style.radius

    states: [
        State {
            when: mouseArea.containsMouse
            PropertyChanges {
                root {
                    color: Style.bgHover
                }
            }
        }
    ]

    Text {
        id: innerText
        anchors.centerIn: parent
        font: Style.barFont
        text: root.message
        color: Style.fontDefault

        states: [
            State {
                when: mouseArea.containsMouse
                PropertyChanges {
                    innerText {
                        color: Style.fontHover
                    }
                }
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Component.onCompleted: {
        if (root.onClick) {
            mouseArea.clicked.connect(onClick);
        }
    }
}
