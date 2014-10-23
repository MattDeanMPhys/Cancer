#!/bin/bash

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

./test

T="$(($(date +%s)-T))"
echo "Time in seconds: ${T}"
