#!/bin/bash
## Usage: speedtest-periodic.sh [SPEEDTEST_RESULTS_FOLDER]
##
## This script runs the actual speedtest and redirect its output
## into a json. The filename of the resulting json is the current
## time at minute precision.
## In case error occurs, the error is just written to the resulting
## json, even if it is not valid json syntax.
##

RESULTS_ROOT=${1:-/var/lib/speedtest}
MEASURES_DIR="$RESULTS_ROOT/measures"

mkdir -p "$MEASURES_DIR"

OUT_FILE="$MEASURES_DIR/$(date +\%Y-\%m-\%dT\%H:\%M).json"
ERROR_LOG="$MEASURES_DIR/errors"

speedtest -f json --accept-license --accept-gdpr 1>"$OUT_FILE" 2>&1
