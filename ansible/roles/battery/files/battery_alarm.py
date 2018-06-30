#!/usr/bin/env python

from collections import namedtuple
import subprocess


def main():
    if not ac():
        check_batteries()

def ac():
    ac_online = '/sys/class/power_supply/AC/online'
    with open(ac_online, 'r') as f:
        if f.readline().strip() == '1':
            return True
    return False

def check_batteries():
    for battery in BATTERIES:
        capacity = None
        with open(battery.capacity, 'r') as f:
            capacity = f.read()

        now = None
        with open(battery.now, 'r') as f:
            now = f.read()

        if capacity and now:
            pct_avail = float(now) / float(capacity) * 100.0
            if pct_avail < THRESHOLD:
                beep()
                print('Battery {0} capacity is less than 10% ({1})'.format(battery.name,
                                                                           int(pct_avail)))
        else:
            print('Error while retrieving capacity of battery {0}'.format(battery.name))

def beep():
    # Pentatonic scale: high to low
    dur = 150
    cmd = ['beep']
    for hz in ['880.0', '783.99', '659.25', '587.33', '523.25']:
        cmd.append('-n')
        cmd.append('-f')
        cmd.append(str(hz))
        cmd.append('-l')
        cmd.append(str(dur))
    subprocess.check_call(cmd)

PowerSupply = namedtuple('PowerSupply', ['name', 'capacity', 'now'])

BATTERIES = [
    PowerSupply(name='BAT0',
                capacity='/sys/class/power_supply/BAT0/energy_full',
                now='/sys/class/power_supply/BAT0/energy_now'),
    PowerSupply(name='BAT1',
                capacity='/sys/class/power_supply/BAT1/energy_full',
                now='/sys/class/power_supply/BAT1/energy_now'),
]

THRESHOLD = float(10.0)


if __name__ == '__main__':
    main()
