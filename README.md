# Raspberry PI Speedtester

This repo setup a Raspberry PI to
* periodically (default 10 minutes) make an **internet speedtest** and store the results locally as json
* act as an **iPerf3** Server to be used for testing the LAN speed (the setup is interactive: Select "Yes" when iperf ask if it should install a daemon)


## Setup

1. Transfer the content of this repository to the Raspberry Pi
1. Run `setup-speedtest-tools.sh` to setup the necessary speedtest tools including the cron job



## Operation

### Speedtester

To run the speedtest, the device must just be powered on and connected via a cable to the network. The speedtest runs by default every 10 minutes and makes one internet speedtest. Each result is stored as separate file in the default locatoin under `/opt/speedtest-results`.

To evaluate the results, the script `/opt/results-to-csv.sh` can be called. It extracts some fields of every result and puts them into one big CSV file under `/opt/all_results.csv`.

To transfer the CSV, just run:

```bash
scp pi@speedtestpi:/opt/all_results.csv .
```

### iperf3

To trigger iperf3 on client side, run this command:

```bash
iperf3 -c [SERVER_IP]
```

## Results

### Periodic Speedtest results

The default location `/opt/speedtest-results` will look like this after having the device connected for some hours or days:

```
pi@speedtestpi:/opt/speedtest-results $ ls
2024-06-03T19:20.json  2024-06-10T21:20.json  2024-06-12T08:20.json
2024-06-03T19:30.json  2024-06-10T21:30.json  2024-06-12T08:30.json
2024-06-09T10:40.json  2024-06-10T21:40.json  2024-06-12T08:40.json
2024-06-09T10:50.json  2024-06-10T21:50.json  2024-06-12T08:50.json
2024-06-09T11:00.json  2024-06-10T22:00.json  2024-06-12T09:00.json
2024-06-09T11:10.json  2024-06-10T22:10.json  2024-06-12T09:10.json
2024-06-09T11:20.json  2024-06-10T22:20.json  2024-06-12T09:20.json
2024-06-09T11:30.json  2024-06-10T22:30.json  2024-06-12T09:30.json
2024-06-09T11:40.json  2024-06-10T22:40.json  2024-06-12T09:40.json
2024-06-09T11:50.json  2024-06-10T22:50.json  2024-06-12T09:50.json
2024-06-09T12:00.json  2024-06-10T23:00.json  2024-06-12T10:00.json
2024-06-09T12:10.json  2024-06-10T23:10.json  2024-06-12T10:10.json
2024-06-09T12:20.json  2024-06-10T23:20.json  2024-06-12T10:20.json
...
```

An individual file looks like this:

```json
{
    "type": "result",
    "timestamp": "2024-06-08T13:15:53Z",
    "ping": {
        "jitter": 0.109,
        "latency": 6.902,
        "low": 6.692,
        "high": 7.036
    },
    "download": {
        "bandwidth": 28921089,
        "bytes": 167802928,
        "elapsed": 5800,
        "latency": {
            "iqm": 12.087,
            "low": 5.750,
            "high": 15.831,
            "jitter": 1.308
        }
    },
    "upload": {
        "bandwidth": 29686541,
        "bytes": 415039819,
        "elapsed": 15009
    },
    "isp": "Some ISP",
    "interface": {
        "internalIp": "1.2.3.4",
        "name": "tap0",
        "macAddr": "00:00:00:00:00:00",
        "isVpn": true,
        "externalIp": "42.42.42.42"
    },
    "server": {
        "id": 44437,
        "host": "speedtest.foo.bar",
        "port": 8080,
        "name": "Foobar",
        "location": "Springfield",
        "country": "Moon",
        "ip": "42.42.42.42"
    },
    "result": {
        "id": "some-uuid",
        "url": "https://www.speedtest.net/result/c/some-uuid",
        "persisted": true
    }
}
```

## Contribution

Contribution are always welcome in any form.

You acknowledge and agree that the owner reserve the right to change the license of the Work, including but not limited to all Contributions previously submitted by You, at any time without the need for approval from You or any other contributor.

## Known Issues

* "speedtest" is not yet released for Ubuntu 24.04
* iperf3 non-interactive installation issue: https://bugs.launchpad.net/ubuntu/+source/iperf3/+bug/1996617
