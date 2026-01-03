import QtQuick

import Quickshell.Services.UPower

import qs

Item {
    id: u_power
    property string icon: ""

    Component.onCompleted: {
        let percent = UPower.displayDevice.percentage * 100;
        let pow_type = UPower.displayDevice.type;
        u_power.icon = percentage_icon(percent, pow_type);
    }

    function percentage_icon(percent, pow_type) {
        let icon_type = pow_type == 0 ? Style.bat_char_icons : Style.bat_dis_icons;

        if (percent < 5) {
            return icon_type.bat_0;
        } else if (percent < 10) {
            return icon_type.bat_1;
        } else if (percent < 25) {
            return icon_type.bat_2;
        } else if (percent < 40) {
            return icon_type.bat_3;
        } else if (percent < 55) {
            return icon_type.bat_4;
        } else if (percent < 70) {
            return icon_type.bat_5;
        } else if (percent < 85) {
            return icon_type.bat_6;
        } else {
            return icon_type.bat_full;
        }
    }

    Connections {
        target: UPower.displayDevice

        function onPercentageChanged(): void {
            let percent = UPower.displayDevice.percentage * 100;
            let pow_type = UPower.displayDevice.type;
            u_power.icon = u_power.percentage_icon(percent, pow_type);
        }
    }
}
