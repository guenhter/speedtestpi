#!/bin/bash
## Usage: results-to-csv.sh [SPEEDTEST_RESULTS_FOLDER]
##
## This script converts all collected speedtest result json's into
## one csv containing selected fields from each result.
## The all_results.csv is stored in the root of the
## SPEEDTEST_RESULTS_FOLDER, while individual JSONs are in the measures subfolder
##

RESULTS_ROOT=${1:-/var/lib/speedtest}
MEASURES_DIR="$RESULTS_ROOT/measures"

mkdir -p "$MEASURES_DIR"
echo "Date,Download (bytes/sec),Upload (bytes/sec),Ping Latency (ms)" > "$RESULTS_ROOT/all_results.csv"

for json in "$MEASURES_DIR"/*.json; do
    cat $json | jq -r '(.timestamp|rtrimstr("Z")) + "," + (.download.bandwidth|tostring) + "," + (.upload.bandwidth|tostring) + "," + (.ping.latency|tostring)' >> "$RESULTS_ROOT/all_results.csv";
done
