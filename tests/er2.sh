#!/bin/bash

# Default countdown time in minutes (10 minutes)
DEFAULT_TIME=10
countdown_time=$DEFAULT_TIME  # Global variable to track the countdown time

# Function to display the countdown
countdown() {
  local total_seconds=$(( countdown_time * 60 ))  # Convert minutes to seconds
  while [ $total_seconds -gt 0 ]; do
    minutes=$(( total_seconds / 60 ))  # Get remaining minutes
    echo -ne "Time remaining: $minutes minutes\n"
    sleep 60
    ((total_seconds--))
  done
  echo -e "\nTime's up!"
}

# Function to check user input
check_input() {
  read -p "Please enter the secret code: " user_input
  # Check if the input is "42"
  if [ "$user_input" != "42" ]; then
    echo "Error: The code is incorrect. Subtracting 1 minute from countdown..."
    countdown_time=$((countdown_time - 1))  # Subtract 1 minute
  else
    echo "Correct code! Continuing with the countdown..."
  fi
}

# Run the countdown in the background
countdown &

# Continuously prompt the user for input
while [ $countdown_time -gt 0 ]; do
  check_input
done

# # Final message once the countdown is done
# echo "The countdown has finished!"
