#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )")


apt-get update


function install_periodic_speedtest() {
    printf "\n== Installing periodic speedtest ==\n"

    apt-get -y install curl jq vim

    # https://www.speedtest.net/de/apps/cli
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
    apt-get -y install speedtest

    cp "$SCRIPT_DIR/speedtest-periodic.sh" /opt/speedtest-periodic.sh

    sudo tee  /etc/cron.d/speedtest <<'EOF'
*/10 * * * * root /opt/speedtest-periodic.sh
EOF
}

function install_iperf_server_daemon() {
    printf "\n== Installing iperf server ==\n"
    apt-get -y install iperf3
}


install_periodic_speedtest
install_iperf_server_daemon
