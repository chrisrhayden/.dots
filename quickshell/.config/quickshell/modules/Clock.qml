import Quickshell
import QtQuick

import qs.components

StyleRect {
    id: clock

    anchors.centerIn: parent
    height: parent.height
    width: text.width

    readonly property string short_time: "hh:mm AP"
    readonly property string long_time: "MMM ddd yy-MM-dd hh:mm AP"
    property bool short_bool: true

    hovered: mouseArea.containsMouse

    SystemClock {
        id: sys_clock
        precision: SystemClock.Seconds
    }

    StyleText {
        id: text
        anchors.centerIn: parent
        hovered: mouseArea.containsMouse

        leftPadding: 4
        rightPadding: 4

        font.weight: Font.Bold

        text: Qt.formatDateTime(sys_clock.date, clock.short_bool ? clock.short_time : clock.long_time)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: clock.short_bool = !clock.short_bool
    }
}
