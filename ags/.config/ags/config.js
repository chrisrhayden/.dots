import App from 'resource:///com/github/Aylur/ags/app.js';
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js';
// import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
import { Widget } from 'resource:///com/github/Aylur/ags/widget.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

// right box {{{

const short_time = {
    hour: "numeric",
    minute: "2-digit",
}

const long_time = {
    month: "short",
    weekday: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
}

const new_time = with_date => {
    const opts = with_date ? long_time : short_time
    return new Date().toLocaleTimeString("en-us", opts)
}

const time = () => Widget.Button({
    class_name: "box can-hover",
    properties: [["with_date", false]],
    on_primary_click: button => {
        button._with_date = !button._with_date
    },
    label: new_time(false),
    connections: [
        [1000, button => button.label = new_time(button._with_date)],
        ["clicked", button => button.label = new_time(button._with_date)],
    ]
})

const audio_str = () => {
    let icon = Audio.speaker?.stream?.is_muted ? "󰝟" : "󰕾"

    const vol_num = Audio.speaker?.volume ? Audio.speaker?.volume : 0
    const percent = Math.round(vol_num * 100)
    return `${icon} ${percent}%`
}

const vol_change = arg => Utils.execAsync(`volume ${arg}`)

const audio = () => Widget.Button({
    class_name: "box can-hover",
    on_secondary_click: () => vol_change("--mute"),
    on_scroll_up: () => vol_change("--up"),
    on_scroll_down: () => vol_change("--down"),
    child: Widget.Label({
        label: audio_str(),
        connections: [
            [Audio, self => {
                self.label = audio_str()
            }, "speaker-changed"],
        ]
    })
})

const sys_tray_item = item => Widget.Button({
    class_name: "box can-hover",
    child: Widget.Icon({
        class_name: "icons",
        binds: [["icon", item, "icon"]]
    }),
    binds: [["tooltip-markup", item, "tooltip-markup"]],
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
})

const sys_tray = () => Widget.Box({
    binds: [[
        "children",
        SystemTray,
        "items",
        items => items.map(sys_tray_item)
    ]]
})

const battery_progress = () => Widget.CircularProgress({
    className: 'progress',
    child: Widget.Icon({
        binds: [['icon', Battery, 'icon-name']],
    }),
    binds: [
        ['value', Battery, 'percent', p => p > 0 ? p / 100 : 0],
        ['className', Battery, 'charging', c => c ? 'charging' : ''],
    ],
});

const right_box = () => {
    let children = [sys_tray(), audio()];

    if (hostname === "Odimm") {
        children.push(battery_progress())
    }

    children.push(time())

    return Widget.Box({
        class_name: "right-box",
        hpack: "end",
        hexpand: true,
        children,
    })
}
// end right box }}}

// hyprland {{{
const dispatch = (ws) => Utils.execAsync(`hyprctl dispatch workspace ${ws}`)

const hypr_ws_buttons = (mon_id, box) => {
    let active_ws = null
    let mon_name = null

    for (let mon of Hyprland.monitors) {
        if (mon_id === mon["id"]) {
            mon_name = mon["name"]
            active_ws = mon["activeWorkspace"]["id"]
            break
        }
    }

    if (!active_ws || !mon_name) {
        return
    }

    const ws_data = btn => {
        btn.visible = false
        btn.class_name = "can-hover hypr-ws"

        for (let ws of Hyprland.workspaces) {
            if (ws["monitor"] === mon_name && ws["id"] === btn["id"]) {
                btn.visible = true

                if (ws["id"] === active_ws) {
                    btn.class_name = "can-hover hypr-ws-focus"
                }
            }
        }
    }

    box.children.forEach(ws_data)
}

const hypr_ws_setup = () => {
    return Array.from({ length: 10 }, (_, i) => i + 1)
        .map(i => Widget.Button({
            class_name: "can-hover hypr-ws",
            setup: btn => btn["id"] = i,
            label: `${i}`,
            on_clicked: () => dispatch(i),
        }))
}

const hyprland = monitor => Widget.Box({
    class_name: "hyprland",
    children: hypr_ws_setup(),
    connections: [[Hyprland, box => hypr_ws_buttons(monitor, box)]]
})
// end hyprland }}}

const Bar = monitor => Widget.Window({
    monitor,
    class_name: "main-bar",
    name: `bar${monitor}`,
    anchor: ['bottom', 'left', 'right'],
    exclusivity: "ignore",
    child: Widget.CenterBox({
        start_widget: hyprland(monitor),
        end_widget: right_box(),
    })
})

const hostname = Utils.exec("hostnamectl hostname")
const scss = App.configDir + "/theme.scss"
const style = App.configDir + "/theme.css"
Utils.exec(`sassc ${scss} ${style}`)

let bars = [Bar(0)]

if (hostname != "Odimm") {
    bars.push(Bar(1))
    // bars.append(Bar(1))
}

export default {
    style,
    bars,
}
