import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const audio = await Service.import("audio")
const systemtray = await Service.import("systemtray")
const hyprland = await Service.import("hyprland")

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
    attribute: [["with_date", false]],
    on_primary_click: button => {
        button._with_date = !button._with_date
    },
}).on("clicked", self => self.label = new_time(self._with_date))
    .poll(1000, self => self.label = new_time(self._with_date))

const audio_str = () => {
    let icon = audio.speaker.stream.is_muted ? "󰝟" : "󰕾"

    const vol_num = audio.speaker.volume ? audio.speaker.volume : 0
    const percent = Math.round(vol_num * 100)
    return `${icon} ${percent}%`
}

const vol_change = arg => Utils.execAsync(`volume ${arg}`)

const audio_button = () => Widget.Button({
    class_name: "box can-hover",
    on_secondary_click: () => vol_change("--mute"),
    on_scroll_up: () => vol_change("--up"),
    on_scroll_down: () => vol_change("--down"),
    child: Widget.Label({ label: "100" }).hook(audio.speaker, self => {
        self.label = audio_str()
    })
})

const sys_tray_item = item => Widget.Button({
    class_name: "box can-hover",
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip-markup"),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event)
})

const sys_tray = () => Widget.Box({
    children: systemtray.bind("items").as(i => i.map(sys_tray_item)),
})

const right_box = () => {
    let children = [sys_tray(), audio_button(), time()];

    return Widget.Box({
        class_name: "right-box",
        hpack: "end",
        hexpand: true,
        children,
    })
}
// end right box }}}

// hyprland {{{
const dispatch = (ws) => hyprland.messageAsync(`dispatch workspace ${ws}`)

function hypr_ws_buttons(monitor_id, btns) {
    const active_ws = hyprland.monitors.find(mon => mon["id"] === monitor_id)["activeWorkspace"]["id"]

    btns.forEach(btn => {
        btn.visible = false

        for (let ws of hyprland.workspaces) {
            if (ws["monitorID"] === monitor_id && ws["id"] === btn.attribute) {
                btn.visible = true
                btn.class_name = ws["id"] === active_ws
                    ? "can-hover hypr-ws-focus"
                    : "can-hover hypr-ws"
            }
        }
    })
}

function hyprland_setup(monitor_id) {
    return Widget.Box({
        class_name: "hyprland",
        children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
            attribute: i,
            label: `${i}`,
            on_clicked: () => dispatch(i),
            visible: false,
        })),
        setup: self => self
            .hook(hyprland, () => hypr_ws_buttons(monitor_id, self.children))
    })
}

// end hyprland }}}

const Bar = monitor => Widget.Window({
    monitor,
    class_name: "main-bar",
    name: `bar${monitor}`,
    anchor: ['bottom', 'left', 'right'],
    exclusivity: "ignore",
    child: Widget.CenterBox({
        start_widget: hyprland_setup(monitor),
        end_widget: right_box(),
    })
})

const scss = App.configDir + "/theme.scss"
const style = App.configDir + "/theme.css"
Utils.exec(`sassc ${scss} ${style}`)

let bars = [Bar(0), Bar(1)]

App.config({ windows: bars, style: style })
