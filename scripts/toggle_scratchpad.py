#!/usr/bin/env python3

import subprocess
from sys import argv
import os

dropdown_opts = {
    'cmd_opts': [
        '--config-file',
        os.environ['XDG_CONFIG_HOME'] + '/alacritty/alacritty.yml',
    ],
    'sticky':
    'on',
    'state':
    'fullscreen',
    'focus_desktop':
    True,
}

sticky_note_opts = {
    'cmd_opts': [
        '--config-file',
        os.environ['XDG_CONFIG_HOME'] + '/alacritty/sticky_note.yml',
        '--command', 'znotes'
    ],
    'sticky':
    'on',
    'state':
    'floating',
    'focus_desktop':
    False,
}


def clean_pids(pids):
    ''' split pids then filter out empty strings then cast to a list '''
    return list(filter(lambda p: p, pids.split('\n')))


def run_cmd(cmd):
    ''' mostly just to not have capture_output in every line '''
    return subprocess.run(cmd, capture_output=True)


def find_pids_by_class(class_name):
    '''
    try and find the pid's for the given class

    if this function fails then we dont have a window to toggle but it is not a
    program error
    '''

    class_cmd = run_cmd(['xdotool', 'search', '--class', class_name])

    if class_cmd.returncode != 0:
        class_cmd = run_cmd(['xdotool', 'search', '--classname', class_name])

    if class_cmd.returncode != 0:
        return False

    pids = class_cmd.stdout.decode()

    if not pids:
        return False

    return clean_pids(pids)


def new_window(class_name, opts):
    ''' make a new window with the given class name and settings '''

    # set up the new window to be full screen
    run_cmd([
        'bspc', 'rule', '--add', class_name, f'sticky={opts["sticky"]}',
        f'state={opts["state"]}'
    ])

    # spawn the cmd in the background without waiting for it
    subprocess.Popen([
        'alacritty', '--class', f'{class_name},{class_name}', *opts['cmd_opts']
    ])

    return True


# TODO: find a real solution
def wait_for_bspwm(pids):
    '''
    wait until bspwm sees the new window or something

    python will loop over a signal string, so we can give it just one pid

    if bspwm cant find the pid then toggle will fail so just error if any pids
    cant be find
    '''

    # this is really bad
    for pid in pids:
        for _ in range(500):
            # break if we find the pid
            if run_cmd(['bspc', 'query', '-N', '-n', pid]).returncode == 0:
                break

        # if we reach the end of the loop there was an error
        else:
            print('bspwm couldn\'t find the pid:', pid)
            return False

    return True


def show_logic(pid, opts):
    if opts['focus_desktop']:
        # bring the window/s to the current desktop, this will fail is
        # already true
        run_cmd(['bspc', 'node', pid, '--to-desktop', 'focused'])

    # make sure the window will be the desired state, this will fail if
    # already the desired state
    run_cmd(['bspc', 'node', pid, '--state', opts['state']])

    # toggle the hidden flag, it will be hidden so this will show the
    # window
    toggle_cmd = run_cmd(
        ['bspc', 'node', pid, '--flag', 'hidden=off', '--focus'])

    return toggle_cmd


def toggle_logic(pid, opts):
    ''' toggle hidden based on a given pid '''

    # check if pid is hidden
    query_cmd = run_cmd(['bspc', 'query', '-N', '-n', f'{pid}.hidden'])

    toggle_cmd = None

    # if query_cmd succeeds then the window is hidden
    if query_cmd.returncode == 0:
        toggle_cmd = show_logic(pid, opts)

    else:
        # toggle the hidden flag, the window is not hidden so this will hide it
        toggle_cmd = run_cmd(['bspc', 'node', pid, '--flag', 'hidden=on'])

    return toggle_cmd and toggle_cmd.returncode == 0


def toggle_pids(pids, opts):
    ''' toggle the given pids '''

    for pid in pids:
        if not toggle_logic(pid, opts):
            print('failed to toggle pid:', pid)
            # if there is an error just stop
            return False

    return True


def hide_all_pids(pids):
    ''' hid all the given pids '''

    for pid in pids:
        # this will fail for windows already hidden
        run_cmd(['bspc', 'node', pid, '--flag', 'hidden=on'])

    return True


def show_all_pids(pids, opts):
    ''' show all the given pids '''

    for pid in pids:
        show_logic(pid, opts)

    return True


def main(argv):
    ''' toggle or spawn a window '''

    if argv[1] == 'dropdown':
        opts = dropdown_opts
    else:
        opts = sticky_note_opts

    class_name = argv[1]

    # try and find pids by class name
    pids = find_pids_by_class(class_name)

    if len(argv) > 2:
        if argv[2] == '-h' or argv[2] == '--hid':
            if not pids:
                # nothing to do
                return True

            return hide_all_pids(pids)

        # make a new window regardless
        elif argv[2] == '-n' or argv[2] == '--new':
            if pids:
                show_all_pids(pids, opts)

            return new_window(class_name, opts)

    # if no pids are found then start a new window with the given class name
    if not pids:
        return new_window(class_name, opts)

    # else toggle the requested windows
    return toggle_pids(pids, opts)


if __name__ == '__main__':
    if len(argv) == 1:
        print('pleas give scratch pad class')
        exit(1)

    elif len(argv) > 3:
        print('too many args')
        exit(1)

    else:
        if not main(argv):
            exit(1)
