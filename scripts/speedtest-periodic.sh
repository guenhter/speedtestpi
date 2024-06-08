#!/bin/bash
## Usage: speedtest-periodic.sh [SPEEDTEST_RESULTS_FOLDER]
##
## This script runs the actual speedtest and redirect its output
## into a json. The filename of the resulting json is the current
## time at minute precision.
## In case error occurs, the error is just written to the resulting
## json, even if it is not valid json syntax.
##

RESULTS_ROOT=${1:-/opt/speedtest-results}

mkdir -p "$RESULTS_ROOT"

OUT_FILE="$RESULTS_ROOT/$(date +\%Y-\%m-\%dT\%H:\%M).json"
ERROR_LOG="$RESULTS_ROOT/errors"

speedtest -f json --accept-license --accept-gdpr 1>"$OUT_FILE" 2>&1
