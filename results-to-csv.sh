#!/bin/bash

RESULTS_ROOT=${1:-/opt/speedtest-results}

echo "Date,Download (bytes/sec),Upload (bytes/sec),Ping Latency (ms)" > "$RESULTS_ROOT/../all_results.csv"

for json in "$RESULTS_ROOT"/*.json; do
    cat $json | jq -r '(.timestamp|rtrimstr("Z")) + "," + (.download.bandwidth|tostring) + "," + (.upload.bandwidth|tostring) + "," + (.ping.latency|tostring)' >> "$RESULTS_ROOT/../all_results.csv";
done
