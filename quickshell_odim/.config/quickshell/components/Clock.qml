// import Quickshell.Widgets
import Quickshell
import QtQuick

import qs

Rectangle {
    id: clockRect
    anchors.centerIn: parent

    height: parent.height
    width: clock.width

    color: Style.bg
    radius: Style.radius

    states: [
        State {
            when: clockArea.containsMouse
            PropertyChanges {
                clockRect {
                    color: Style.bgHover
                }
            }
        }
    ]

    Text {
        id: clock
        anchors.centerIn: parent

        leftPadding: Style.padding
        rightPadding: Style.padding

        readonly property string short_time: "hh:mm AP"
        readonly property string long_time: "MMM ddd yy-MM-dd hh:mm AP"
        property bool short_bool: true

        SystemClock {
            id: sys_clock
            precision: SystemClock.Seconds
        }

        font: Style.barFont
        color: Style.fontDefault

        text: Qt.formatDateTime(sys_clock.date, short_bool ? short_time : long_time)

        states: [
            State {
                when: clockArea.containsMouse
                PropertyChanges {
                    clock {
                        color: Style.fontHover
                    }
                }
            }
        ]
    }

    MouseArea {
        id: clockArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: _ => clock.short_bool = !clock.short_bool
    }
}
