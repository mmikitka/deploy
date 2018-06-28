#!/usr/bin/env python

from collections import namedtuple
import subprocess


def send_message(msg):
    subprocess.check_call(['xmessage', '-display', ':0.0', msg])

PowerSupply = namedtuple('PowerSupply', ['name', 'capacity', 'now'])

batteries = [
    PowerSupply(name='BAT0',
                capacity='/sys/class/power_supply/BAT0/energy_full',
                now='/sys/class/power_supply/BAT0/energy_now'),
    PowerSupply(name='BAT1',
                capacity='/sys/class/power_supply/BAT1/energy_full',
                now='/sys/class/power_supply/BAT1/energy_now'),
]

THRESHOLD = float(10.0)

messages = []
for battery in batteries:
    capacity = None
    with open(battery.capacity, 'r') as f:
        capacity = f.read()

    now = None
    with open(battery.now, 'r') as f:
        now = f.read()

    if capacity and now:
        pct_avail = float(now) / float(capacity) * 100.0
        if pct_avail < THRESHOLD:
            messages.append('Battery {0} capacity is less than 10% ({1})'.format(battery.name,
                                                                                 int(pct_avail)))
    else:
        messages.append('Error while retrieving capacity of battery '
                        '{0}'.format(battery.name))

if messages:
    send_message('\n'.join(messages))
