#!/bin/bash

RESULTS_ROOT=/opt/speedtest-results

for json in "$RESULTS_ROOT"/*.json; do
    cat $json | jq -r '(.timestamp|rtrimstr("Z")) + "," + (.download.bandwidth|tostring) + "," + (.upload.bandwidth|tostring) + "," + (.ping.latency|tostring)' >> /opt/all_results.csv;
done
