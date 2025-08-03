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

    # Workaround as long as 24.04 is not supported
    sed -i 's/noble/jammy/g' /etc/apt/sources.list.d/ookla_speedtest-cli.list
    apt-get update

    apt-get -y install speedtest

    chmod +x "$SCRIPT_DIR"/scripts/*.sh
    cp "$SCRIPT_DIR"/scripts/*.sh /usr/local/bin/

    # Create speedtest results directory
    mkdir -p /var/lib/speedtest

    sudo tee  /etc/cron.d/speedtest <<'EOF'
*/10 * * * * root /usr/local/bin/speedtest-periodic.sh
EOF
}

function install_iperf_server_daemon() {
    printf "\n== Installing iperf server ==\n"

    # This avoids user interaction when installing iperf and tell it
    echo "iperf3 iperf3/start_daemon boolean true" | debconf-set-selections
    apt-get -y install iperf3
}


install_periodic_speedtest
install_iperf_server_daemon
