#!/bin/bash
## Usage: results-to-csv.sh [SPEEDTEST_RESULTS_FOLDER]
##
## This script converts all collected speedtest result json's into
## one csv containing selected fields from each result.
## The all_results.csv is stored one hierarchy above the
## SPEEDTEST_RESULTS_FOLDER folder
##

RESULTS_ROOT=${1:-/opt/speedtest-results}

echo "Date,Download (bytes/sec),Upload (bytes/sec),Ping Latency (ms)" > "$RESULTS_ROOT/../all_results.csv"

for json in "$RESULTS_ROOT"/*.json; do
    cat $json | jq -r '(.timestamp|rtrimstr("Z")) + "," + (.download.bandwidth|tostring) + "," + (.upload.bandwidth|tostring) + "," + (.ping.latency|tostring)' >> "$RESULTS_ROOT/../all_results.csv";
done
