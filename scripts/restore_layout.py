#!/usr/bin/env python3

# github.com/baskerville/bspwm/blob/master/examples/receptacles/extract_canvas

from argparse import ArgumentParser
import sys
import json
import subprocess
import os


def clean_pids(pids):
    ''' split pids then filter out empty strings then cast to a list '''
    return list(filter(lambda p: p, pids.split('\n')))


def run_cmd(cmd):
    ''' mostly just to not have capture_output in every line '''
    return subprocess.run(cmd, capture_output=True)


def get_config_dir():
    ''''''

    if 'XDG_CONFIG_HOME' in os.environ:
        config_dir = os.environ['XDG_CONFIG_HOME']
    else:
        print('Error: XDG_CONFIG_HOME environment variable not set')
        return False

    return os.path.join(config_dir, 'bspwm')


def save_new_layout(state, name):
    config_path = get_config_dir()

    save_path = os.path.join(config_path, 'layouts')

    if not os.path.exists(save_path):
        os.makedirs(save_path)

    save_path = os.path.join(save_path, name + '.json')

    with open(save_path, '+w') as fd:
        json.dump(state, fd)

    return True


def query_cmd(command, option, query):
    ''''''
    finished_query_cmd = run_cmd(['bspc', 'query', command, option, query])

    if finished_query_cmd.returncode != 0:
        # TODO: maybe print the failed cmd
        print('Error: query failed to find anything', file=sys.stderr)
        return False

    if not finished_query_cmd.stdout:
        print('Error: no output from query to work with', file=sys.stderr)
        return False

    return clean_pids(finished_query_cmd.stdout.decode())


def nullify_clients(node):
    if node is None:
        return
    elif node['client'] is None:
        nullify_clients(node['firstChild'])
        nullify_clients(node['secondChild'])
    else:
        node['client'] = None


def make_rules(accumulator, prefix, node, path):
    if node is None:
        return
    elif node['client'] is None:
        make_rules(accumulator, prefix, node, path + ['1'])
        make_rules(accumulator, prefix, node, path + ['2'])

    else:
        client = node['client']
        accumulator.append([
            f'bspc rule --add {client["className"]}:{client["instanceName"]}'
            f'--one-shot node={prefix}{"/".join(path)}'
        ])


# TODO: consider a different approach to accessing the json
def select_current_desktop(state, monitor_id, desktop_id):
    ''' traverse the bsp state and select the current and desktop '''

    if ('monitors' in state) == False:
        print('state malformed, no `monitors` field')
        return False

    for monitor in state["monitors"]:
        if monitor["id"] == monitor_id:
            if ('desktops' in monitor) == False:
                print('state malformed, no `desktops` field in monitor')
                return False

            for desktop in monitor["desktops"]:
                if desktop["id"] == desktop_id:
                    return desktop

    print('Error: did not find anything', file=sys.stderr)
    return False


def store_current(state, name):
    ''' only save the current desktop '''

    monitors = query_cmd('--monitors', '--monitor', 'focused')

    if not monitors:
        return False

    if len(monitors) > 1:
        print('Error: query got too many monitors', file=sys.stderr)
        return False

    monitor_id = int(monitors[0], base=16)

    desktops = query_cmd('--desktops', '--desktop', 'focused')

    if not desktops:
        return False

    if len(desktops) > 1:
        print('Error: query got too many desktops', file=sys.stderr)
        return False

    desktop_id = int(desktops[0], base=16)

    desktop = select_current_desktop(state, monitor_id, desktop_id)

    save_new_layout(desktop, desktop["name"])

    return True


def store_all(state):
    state['clientsCount'] = 0
    state['focusHistory'] = []
    state['stackingList'] = []

    for monitor in state['monitors']:
        for desktop in monitor['desktops']:
            desktop['focusedNodeId'] = 0
            nullify_clients(desktop['root'])


def main(args):
    ''' re/store layout '''
    if args.state:
        source = args.state
    else:
        source = sys.stdin.read()

    if not source:
        quit(1)

    try:
        state = json.loads(source)
    # dont print internal errors to user, bind the error message when/if
    # debugging is used
    except json.decoder.JSONDecodeError:
        print('bad json given to state:', source, file=sys.stderr)
        return False

    if args.name:
        name = args.name
    else:
        name = False

    if args.all:
        save_state = store_all(state)
    else:
        save_state = store_current(state, name)

    if not save_state:
        return False

    # print(json.dumps(save_state))
    return True


def parse_args():
    parser = ArgumentParser()

    parser.add_argument(
        "-s",
        "--state",
        help="the bspwm state to work on",
    )

    parser.add_argument("-a",
                        "--all",
                        help="save all desktops on all monitors",
                        action='store_true')

    parser.add_argument(
        "-n",
        "--name",
        help="the name to save the layout as",
    )

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    # print(args)

    if not main(args):
        quit(1)

    quit(0)
