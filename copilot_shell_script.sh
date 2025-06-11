#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prompt user for the new assignment name
read -p "Hey, Please enter the new assignment name: " assignment_name

# Validate input (non-empty)
if [ -z "$assignment_name" ]; then
  echo "Error: Assignment name cannot be empty."
  exit 1
fi

# Extract the parent directory name (e.g., submission_reminder_Wisdom)
parent_dir_name=$(basename "$(dirname "$SCRIPT_DIR")")

# Check if the parent directory matches submission_reminder_*
if [[ "$parent_dir_name" == submission_reminder_* ]]; then
  target_dir="$SCRIPT_DIR"
  
  # Look for a nested submission_reminder_* directory
  nested_dirs=("$SCRIPT_DIR"/submission_reminder_*)
  if [ -d "${nested_dirs[0]}" ] && [ "${#nested_dirs[@]}" -eq 1 ]; then
    target_dir="${nested_dirs[0]}"
  else
    echo "Error: Could not find a single submission_reminder_* directory in $SCRIPT_DIR"
    exit 1
  fi
fi

# Check if the target directory exists
if [ ! -d "$target_dir" ]; then
  echo "Error: Directory $target_dir not found."
  exit 1
fi

# Path to config.env in the target directory
config_file="$target_dir/config/config.env"

# Check if config.env exists
if [ ! -f "$config_file" ]; then
  echo "Error: $config_file not found."
  exit 1
fi

# Replace the ASSIGNMENT value on row 2 using sed
sed -i '' "2s/ASSIGNMENT=\".*\"/ASSIGNMENT=\"$assignment_name\"/" "$config_file" || {
  echo "Error: Failed to update $config_file"
  exit 1
}
echo "Updated ASSIGNMENT to \"$assignment_name\" in $config_file"

# Check if startup.sh exists and is executable in the target directory
startup_script="$target_dir/startup.sh"
if [ ! -x "$startup_script" ]; then
  echo "Error: $startup_script not found or not executable."
  exit 1
fi

# Rerun startup.sh to check submissions for the new assignment
echo "Running startup.sh to check submissions for $assignment_name..."
bash "$startup_script" || {
  echo "Error: Failed to run startup.sh"
  exit 1
}
