# Submission Reminder App

The Submission Reminder App is a Bash-based tool designed to manage and track student assignment submissions.
## Features

- **Check Submission Status**: Displays a list of students who have not submitted a specific assignment, along with the assignment name and days remaining.
- **Dynamic Assignment Updates**: Allows users to change the assignment name in `config.env` and recheck submission statuses.
- **Automated Setup**: Includes a script to create the directory structure and necessary files.
- **Flexible Execution**: Scripts can be run from any directory, with automatic path resolution.

## Directory Structure

The application uses a nested directory structure, created by `create_environment.sh`. For example, if run from `submission_reminder_Wisdom` with the user name `John`, the structure is:

```bash

submission_reminder_Wisdom/
├── copilot_shell_script.sh
├── create_environment.sh
|-- README.md
└── submission_reminder_{InputName}/
    ├── app/
    │   └── reminder.sh
    ├── modules/
    │   └── functions.sh
    ├── assets/
    │   └── submissions.txt
    ├── config/
    │   └── config.env
    └── startup.sh
```

- **`copilot_shell_script.sh`**: Updates the assignment name in `config.env` and runs `startup.sh` to check submissions.
- **`create_environment.sh`**: Sets up the directory structure and files.
- **`submission_reminder_{InputName}/`**: Contains the core application files:
  - **`app/reminder.sh`**: Outputs assignment details and calls `check_submissions` to display reminders.
  - **`modules/functions.sh`**: Defines the `check_submissions` function to process `submissions.txt`.
  - **`assets/submissions.txt`**: CSV file with student submission data (e.g., `Chinemerem,Shell Navigation,not submitted`).
  - **`config/config.env`**: Configuration file specifying the assignment name and days remaining (e.g., `ASSIGNMENT="Shell Navigation"`).
  - **`startup.sh`**: Main script to run the application, sourcing `config.env` and executing `reminder.sh`.

## Prerequisites

- **Operating System**: macOS or Linux (tested on macOS with `zsh` and `bash`).
- **Permissions**: Write access to the directory where the app is set up (e.g., `submission_reminder_Wisdom`).

## Setup Instructions


1. Clone the repo and run the following:

   ```bash
   chmod +x create_environment.sh
   ./create_environment.sh
    ```

2. Navigate to the created directory and run:

    ```bash
    chmod +x startup.sh
    ./startup.sh
    ```

3. Run the *copilot_shell_script.sh* script:

    ```bash
    chmod +x copilot_shell_script.sh
    ./ copilot_shell_script.sh
    ```

*feel free to contribute & fork*

*a branch was used feature/setup during development*
