# Raspberry PI as Speedtester

This scripts setup a Raspberry PI to
* periodically (default 10 minutes) make an internet speedtest and store the results locally as json
* act as an iPerf3 Server to be used for testing the LAN speed (the setup is interactive: Select "Yes" when iperf ask if it should install a daemon)

## iperf3

To trigger iperf3 on client side, run this command:

```bash
iperf3 -c [SERVER_IP]
```

## Contribution

Contribution are always welcome in any form.

You acknowledge and agree that the owner reserve the right to change the license of the Work, including but not limited to all Contributions previously submitted by You, at any time without the need for approval from You or any other contributor.

## Known Issues

* "speedtest" is not yet released for Ubuntu 24.04
* iperf3 non-interactive installation issue: https://bugs.launchpad.net/ubuntu/+source/iperf3/+bug/1996617
