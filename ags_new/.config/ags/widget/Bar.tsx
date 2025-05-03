import { App, Astal, Gdk } from "astal/gtk4"

import { WorkSpace } from "./WorkSpace"
import { Time } from "./Time"
import { EndBox } from "./EndBox"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

    let mon_connector: string = gdkmonitor.get_connector()!

    return <window
        visible
        cssClasses={["Bar"]}
        gdkmonitor={gdkmonitor}
        // exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={BOTTOM | LEFT | RIGHT}
        application={App}>
        <centerbox cssName="centerbox">
            <WorkSpace monitor={mon_connector} />
            <Time />
            <EndBox />
        </centerbox>
    </window>
}
