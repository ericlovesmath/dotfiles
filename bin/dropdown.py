#!/usr/bin/env python3
"""
App dropdown script for Yabai
It'll display or hide provided app by name

LICENSE: GPLv3+ by bernardas.alisauskas@pm.me
"""
import json
import subprocess

import click
from click import echo

YABAI = '/usr/local/bin/yabai'


def run(cmd: str):
    return subprocess.run(cmd, shell=True, capture_output=True).stdout


def run_json(cmd: str):
    return json.loads(run(cmd))


@click.command()
@click.argument('app')
@click.option('--scratchpad', '-s', default='4', show_default=True,
              help='hidden workspace name')
def main(app, scratchpad):
    """Dropdown functionality for yabai. Either summon or hide program by app name"""
    echo(f'calling {app}')
    windows = run_json(f'{YABAI} -m query --windows')
    for window in windows:
        if window['app'] == app:
            break
    else:
        echo(f'app "{app}" not found', err=True)
        exit(1)
    if window['visible']:
        # if visible, hide it to scratchpad workspace
        run(f'{YABAI} -m window {window["id"]} --space {scratchpad}')
        echo(f'{app} hidden')
    else:
        # otherwise pull to current workspace and focus
        run(f'{YABAI} -m window {window["id"]} --space mouse && '
            f'{YABAI} -m window --focus {window["id"]}')
        echo(f'{app} revealed')


if __name__ == '__main__':
    main()
