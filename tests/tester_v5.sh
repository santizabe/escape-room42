#!/bin/bash

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Compile function
# Args:
#   $1 - Path to the C file to compile
#   $2 - (Optional) Path to the output executable file (default: "executable")
#   $3 - (Optional) Additional C file for compilation
# Returns:
#   0 on success, 1 on failure
compile() {
  local c_file=$1
  local output_file=${2:-"executable"}
  local additional_file=${3:-}
  local traces_dir="../traces"
  local traces_file="$traces_dir/traces.txt"

  # Compile the C file (with optional additional file)
  if [[ -n "$additional_file" ]]; then
	gcc -Wall -Wextra -Werror "$c_file" "$additional_file" -o "$output_file" 2> "$traces_file"
  else
	gcc -Wall -Wextra -Werror "$c_file" -o "$output_file" 2> "$traces_file"
  fi

  if [[ $? -ne 0 ]]; then
	# Compilation failed
	echo -e "${RED}error${NC}"
	echo "Compilation failed. Check $traces_file for details." >> "$traces_file"
	return 1
  fi

  return 0
}

# Tester function
tester() {
  local c_file=$1
  local reference_executable=$2
  local input_file=${3:-} # Optional third argument
  local additional_file=${4:-} # Optional additional C file
  local executable="executable"
  local traces_dir="../traces"
  local traces_file="$traces_dir/traces.txt"
  local user_answer="user_answer.txt"
  local reference_output="reference.txt"

  # Ensure traces directory exists
  mkdir -p "$traces_dir"

  # Clear output files
  > "$user_answer"
  > "$reference_output"

  # Compile the user's C file
  compile "$c_file" "$executable" "$additional_file"
  if [[ $? -ne 0 ]]; then
	cleanup "$executable" "$user_answer" "$reference_output"
	return 1
  fi

  # If an input file is provided, iterate through its lines
  if [[ -n "$input_file" && -f "$input_file" ]]; then
	while IFS= read -r line; do
	  # Pass each line as input to both executables and append the outputs
	  ./"$executable" "$line" >> "$user_answer" 2>> "$traces_file"
	  "$reference_executable" "$line" >> "$reference_output"
	done < "$input_file"
  else
	# No input file, execute both without arguments
	./"$executable" >> "$user_answer" 2>> "$traces_file"
	"$reference_executable" >> "$reference_output"
  fi

  # Compare the outputs
  diff "$user_answer" "$reference_output" > /dev/null
  if [[ $? -ne 0 ]]; then
	# Differences found
	echo -e "${RED}error${NC}"
	echo "Output mismatch. Check $traces_file for details." >> "$traces_file"
	diff "$user_answer" "$reference_output" >> "$traces_file"
	cleanup "$executable" "$user_answer" "$reference_output"
	return 1
  fi

  # Success case
  echo -e "${GREEN}Success${NC}"
  cleanup "$executable" "$user_answer" "$reference_output"
  return 0
}

# Cleanup function
# Args:
#   List of files to delete
cleanup() {
  for file in "$@"; do
	[[ -f "$file" ]] && rm "$file"
  done
}

# Countdown function
countdown() {
  local seconds=60
  echo "Retrying in one minute..."
  while ((seconds > 0)); do
	echo -ne "\rTime left: $seconds seconds. Press Ctrl+C to exit. "
	sleep 1
	((seconds--))
  done
  echo
}

# Main script logic
user_files=(
  "../ex00/the_answer.c"
  "../ex02/to_life.c"
  "../ex03/the_universe.c"
  "../ex04/and_everything.c"
)
reference_executables=(
  "../answers/ex00"
  "../answers/ex02"
  "../answers/ex03"
  "../answers/ex04"
)
additional_files=(
  "../src/ex00_main.c" # Additional file for the first test
  ""                       # No additional file for the others
  ""
  ""
)

index=0
while true; do
  echo -n "Enter command: "
  read user_input
  if [[ "$user_input" == "grademe" ]]; then
	if [[ $index -lt ${#user_files[@]} ]]; then
	  tester "${user_files[$index]}" "${reference_executables[$index]}" "" "${additional_files[$index]}"
	  if [[ $? -ne 0 ]]; then
		countdown
	  else
		((index++))
		if [[ $index -eq ${#user_files[@]} ]]; then
		  echo -e "${GREEN}Congratulations! All tests passed.${NC}"
		  exit 0
		fi
	  fi
	fi
  else
	echo "Command not recognized"
  fi
done
