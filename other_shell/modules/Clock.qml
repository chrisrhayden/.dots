import Quickshell
import QtQuick

import qs

Rectangle {
    id: clock

    height: parent.height
    width: text.width
    anchors.centerIn: parent

    readonly property string short_time: "hh:mm AP"
    readonly property string long_time: "MMM ddd yy-MM-dd hh:mm AP"
    property bool short_bool: true

    color: mouse_area.containsMouse ? Style.colors.bg_hover : Style.colors.bg
    radius: Style.radius

    SystemClock {
        id: sys_clock
        precision: SystemClock.Seconds
    }

    Text {
        id: text
        anchors.centerIn: parent
        leftPadding: 4
        rightPadding: 4

        font: Style.bar_font
        color: mouse_area.containsMouse ? Style.colors.fg_hover : Style.colors.fg
        text: Qt.formatDateTime(sys_clock.date, clock.short_bool ? clock.short_time : clock.long_time)
    }

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
        onClicked: clock.short_bool = !clock.short_bool
    }
}
