import { GLib, Variable } from "astal"
import { Gtk } from "astal/gtk4"

// https://docs.gtk.org/glib/method.DateTime.format.html
const short_time = "%I:%M %p"
const long_time = "%c %Y"

export function Time(): JSX.Element {
    const time_str = Variable(short_time)

    const time_var = Variable(
        GLib.DateTime.new_now_local().format(time_str.get())!
    )

    time_var.poll(1000, () =>
        GLib.DateTime.new_now_local().format(time_str.get())!
    )


    return <box
        valign={Gtk.Align.CENTER}
        spacing={0} cssName="time-box" >
        <menubutton
            direction={Gtk.ArrowType.NONE}
            alwaysShowArrow={false}
            valign={Gtk.Align.CENTER}
            cssClasses={["time-btn", "can-hover"]}
            onButtonPressed={(_, evt) => {
                if (evt.get_button() === 3) {
                    time_str.set(
                        time_str.get() === short_time ? long_time : short_time)
                    time_var.set(
                        GLib.DateTime.new_now_local().format(time_str.get())!)
                }
            }}
            label={time_var()}
        >
            <popover
                hasArrow={false}>
                <Gtk.Calendar />
            </popover>
        </menubutton>
    </box >
}
