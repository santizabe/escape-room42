#!/bin/bash

# Function to display the countdown
countdown() {

  while [ $DEFAULT_TIME -gt 0 ]; do
    minutes=$(( $1 / 60 ))  # Get remaining minutes
    seconds=$(( $1 % 60 ))  # Get remaining seconds
    echo -ne "Time remaining: $minutes minutes and $seconds seconds\r"
    sleep 1
    ((DEFAULT_TIME--))
  done
  echo -e "\nTime's up!"
}

# Default countdown time in minutes (10 minutes)
DEFAULT_TIME=$((10 * 60))

countdown $DEFAULT_TIME

# Read the string input from the user
read -p "Please enter the secret code: " user_input

# Check if the input is "42"
if [ "$user_input" != "42" ]; then
  echo -e "Error. The code is incorrect. Substracting 1 minute from countdown"
  DEFAULT_TIME=$(($DEFAULT_TIME - 60))
  exit 1
else
    echo "Code accepted. Opening doors .."
fi

