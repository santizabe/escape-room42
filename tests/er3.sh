#!/bin/bash

# Countdown function
countdown() {
  local seconds=$1
  while ((seconds > 0)); do
    echo -ne "You have $seconds seconds to respond...\r"
    sleep 1
    ((seconds--))
  done
  echo -ne "Time is up!\n"
}

# Start the countdown in the background
countdown 300 &
COUNTDOWN_PID=$!

# Prompt the user for input
read -t 300 -p "Enter your name: " name

# Kill the countdown process if input is provided
kill $COUNTDOWN_PID 2>/dev/null

# Check the input
if [[ -z "$name" ]]; then
  echo "No input provided."
else
  echo "Hello, $name!"
fi
