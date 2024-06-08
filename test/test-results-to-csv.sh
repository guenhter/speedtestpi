#!/bin/bash

if [ "$EUID" -eq 0 ]; then
  echo "This script must not be run as root." >&2
  exit 1
fi

EXIT_CODE=0
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )")


function test_resulting_csv() {
    printf "\n== Test resulting csv ==\n"
    TEMP_DIR=$(mktemp -d)

    mkdir "$TEMP_DIR/jsons"
    cp "$SCRIPT_DIR"/resources/*.json "$TEMP_DIR/jsons"


    # Execute script under test
    bash "$SCRIPT_DIR"/../scripts/results-to-csv.sh "$TEMP_DIR/jsons"


    # Assertions
    if ! [ -f "$TEMP_DIR/all_results.csv" ]; then
        printf "  Test failed - '$TEMP_DIR/all-results.json' not found\n"
        EXIT_CODE=1
    fi

    if ! cmp -s "$TEMP_DIR/all_results.csv" "$SCRIPT_DIR"/resources/expeced.csv; then
        printf "   Test failed - all_results.csv != $SCRIPT_DIR/resources/expeced.csv\n"
        EXIT_CODE=1
    fi

    rm -rf "$TEMP_DIR"
}


function test_resulting_csv_if_error_file_is_there() {
    printf "\n== Test resulting csv if error json file available ==\n"
    TEMP_DIR=$(mktemp -d)

    mkdir "$TEMP_DIR/jsons"
    cp "$SCRIPT_DIR"/resources/*.json "$TEMP_DIR/jsons"
    printf "speedtest-error-result3.json" > "$TEMP_DIR/jsons/some-error.json"


    # Execute script under test
    bash "$SCRIPT_DIR"/../scripts/results-to-csv.sh "$TEMP_DIR/jsons"


    # Assertions
    if ! [ -f "$TEMP_DIR/all_results.csv" ]; then
        printf "  Test failed - '$TEMP_DIR/all-results.json' not found\n"
        EXIT_CODE=1
    fi

    if ! cmp -s "$TEMP_DIR/all_results.csv" "$SCRIPT_DIR"/resources/expeced.csv; then
        printf "   Test failed - all_results.csv != $SCRIPT_DIR/resources/expeced.csv\n"
        EXIT_CODE=1
    fi

    rm -rf "$TEMP_DIR"
}



test_resulting_csv
test_resulting_csv_if_error_file_is_there

exit "$EXIT_CODE"
