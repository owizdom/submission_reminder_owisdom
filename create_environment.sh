#!/bin/bash

# Prompt user for their name
read -p "Please enter your name: " user_name

# Validate input (non-empty)
if [ -z "$user_name" ]; then
  echo "Error: Name cannot be empty."
  exit 1
fi

# Create main directory (nested inside current directory)
main_dir="./submission_reminder_${user_name}"
mkdir -p "$main_dir" || { echo "Error: Failed to create directory $main_dir"; exit 1; }
echo "Created main directory: $main_dir"

# Create subdirectories
mkdir -p "$main_dir/app" "$main_dir/modules" "$main_dir/assets" "$main_dir/config" || {
  echo "Error: Failed to create subdirectories"
  exit 1
}
echo "Created subdirectories: app, modules, assets, config"

# Create and populate config.env
cat > "$main_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
echo "Created config/config.env"

# Create and populate submissions.txt with provided records plus 5 additional
cat > "$main_dir/assets/submissions.txt" << 'EOF'
student,assignment,submission status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
John Izu,Shell Navigation,not submitted
Somto Great,Git,submitted
Michael Chisom,Shell Navigation,not submitted
Noah Kim,Shell Basics,not submitted
Olivia Brown,Shell Navigation,not submitted
EOF
echo "Created assets/submissions.txt with 9 records (4 provided + 5 additional)"

# Create and populate functions.sh
cat > "$main_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
echo "Created modules/functions.sh"

# Create and populate reminder.sh
cat > "$main_dir/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ../config/config.env
source ../modules/functions.sh

# Path to the submissions file
submissions_file="../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
echo "Created app/reminder.sh"

# Create and populate startup.sh
cat > "$main_dir/startup.sh" << 'EOF'
#!/bin/bash

# Startup script for submission reminder app
echo "Starting Submission Reminder App..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Extract the parent directory name (e.g., submission_reminder_Wisdom)
parent_dir_name=$(basename "$(dirname "$SCRIPT_DIR")")

# Check if the parent directory matches submission_reminder_*
if [[ "$parent_dir_name" == submission_reminder_* ]]; then
  # Script is in the nested directory (e.g., /Users/Apple/submission_reminder_Wisdom/submission_reminder_John)
  target_dir="$SCRIPT_DIR"
else
  # Script is in the base directory (e.g., /Users/Apple/submission_reminder_Wisdom)
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

# Source configuration using absolute path
if ! source "$target_dir/config/config.env"; then
  echo "Error: Failed to source $target_dir/config/config.env"
  exit 1
fi

# Change to the app directory using absolute path to ensure relative paths in reminder.sh work
if ! cd "$target_dir/app"; then
  echo "Error: Failed to change to $target_dir/app directory"
  exit 1
fi

# Run the reminder script
if ! bash ./reminder.sh; then
  echo "Error: Failed to run reminder.sh"
  exit 1
fi

echo "Submission Reminder App completed."
EOF
echo "Created startup.sh"

# Make all .sh files executable
chmod +x "$main_dir/app/reminder.sh" "$main_dir/modules/functions.sh" "$main_dir/startup.sh" "$0"
echo "Set executable permissions for all .sh files"

# Test the application by running startup.sh
echo "Testing the application by running startup.sh..."
bash "$main_dir/startup.sh" || {
  echo "Error: Failed to run startup.sh"
  exit 1
}
echo "Environment setup and test completed successfully."