import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { bind, GObject } from "astal"
import Tray from "gi://AstalTray"
import Wp from "gi://AstalWp"

const { END } = Gtk.Align

const SYNC = GObject.BindingFlags.SYNC_CREATE

function tray_item(item: Tray.TrayItem): JSX.Element {
    const popover = Gtk.PopoverMenu.new_from_model(item.get_menu_model())
    const icon = new Gtk.Image()
    const button = new Gtk.MenuButton({ popover, child: icon })

    button.set_direction(Gtk.ArrowType.NONE)

    item.bind_property("gicon", icon, "gicon", SYNC)

    popover.insert_action_group("dbusmenu", item.get_action_group())

    button.set_css_classes(["can-hover", "tray-item"])

    return button
}

function SysTray(): JSX.Element {
    const tray = Tray.get_default()

    return <box cssName="sys-tray">
        {bind(tray, "items").as(items => items.map(tray_item))}
    </box>
}

function Volume(): JSX.Element {
    const speaker = Wp.get_default()?.audio.default_speaker!

    const icon = new Gtk.Image()

    speaker.bind_property("volume-icon", icon, "icon-name", SYNC)

    return <box
        cssClasses={["volume-icon", "can-hover"]}
    >
        {icon}
    </box>

}

export function EndBox(): JSX.Element {

    return <box
        cssClasses={["end-box"]}
        spacing={0}
    >
        <Volume />
        <SysTray />
    </box>
}
