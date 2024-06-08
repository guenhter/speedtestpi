#!/bin/bash

RESULTS_ROOT=/opt/speedtest-results

mkdir -p "$RESULTS_ROOT"

OUT_FILE="$RESULTS_ROOT/$(date +\%Y-\%m-\%dT\%H:\%M).json"
ERROR_LOG="$RESULTS_ROOT/errors"

speedtest -f json --accept-license --accept-gdpr 1>"$OUT_FILE" 2>&1
