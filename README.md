# Submission Reminder App

The **Submission Reminder App** is a *Bash-based* tool designed to manage and track student assignment submissions.

## Features

- **Environment Setup Script (`create_environment.sh`)**
  - Prompts for the user’s **name**.
  - Creates a custom directory `submission_reminder_{yourName}`.
  - Populates the structure with required files and directoriesfolders.
  - Makes `.sh` files **executable**executable.
  - Adds **read**read and **write**write permissions to `.env` and `.txt` files.

- **Reminder System (`startup.sh`, `reminder.sh`, `functions.sh`)**
  - Reads a list of students from `submissions.txt`.
  - Uses configuration (`config.env`) to identify the assignment to check.
  - Displays students who have **not submitted**submitted.

- **Assignment Update Script (`copilot_shell_script.sh`)**
  - Checks for the virtual environment folder and prompts to run `create_environment.sh` if it does not exist.
  - Asks the user to select the virtual environment if multiple directories are found.
  - Allows users to update the **assignment name**name.
  - Validates against **empty**empty assignment names, prompting re-entry if invalid.
  - Automatically reruns the app with the updated configuration.
  - Updates the `ASSIGNMENT` value in `config.env`.

## Directory Structure

The application uses a nested directory structure created by `create_environment.sh`. For example, if run from `submission_reminder_Wisdom` with the user name `John`, the structure is:

```bash
submission_reminder_Wisdom/
├── copilot_shell_script.sh
├── create_environment.sh
├── README.md
└── submission_reminder_John/
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


# How the App Works

📥 **Run `create_environment.sh`**

- Prompts for your name and creates a directory:  
  `submission_reminder_{yourName}`

- Sets up necessary subfolders and populates them with provided script and data files.

- Ensures all `.sh` files are executable.

---

## 🧭 Menu Options

- ✅ **Launch `startup.sh`**
- 🔁 **Run `copilot_shell_script.sh`**
- ♻️ **Restart `create_environment.sh`**
- ❌ **Exit**

```bash
$ bash create_environment.sh
Welcome to Wisdom's Submission Reminder App!

Please enter your name: helen

Creating a virtual environment for you...
Directory created: submission_reminder_helen

All files and directories successfully set up.

Choose what you want to do next:
1) Launch startup.sh
2) Run copilot_shell_script.sh
3) Restart environment setup
4) Exit
```

## 📦 Based on User Selection - `startup.sh` is Launched

- Loads `config.env` to retrieve the current assignment name.
- Calls `reminder.sh` to check for students who haven’t submitted.
- Lists all students who haven't submitted the assignment.
- Displays a message if no students are found.

### Menu Options:
- 🔁 **Rerun the reminder**
- ♻️ **Restart environment setup**
- 📝 **Change assignment via `copilot_shell_script.sh`**
- ❌ **Exit**

---

## 📝 Run `copilot_shell_script.sh`

- Checks for the virtual environment to use.
- Prompts for a **new assignment name**.
- Prevents saving if the assignment name is left blank.
- Updates `config.env` using `sed`.
- Displays the user option menu to continue.

---

## ❗ Error Handling

- **Existing directory**:
  - User is notified.
  - Prompt: _"Do you want to delete and recreate it?"_  
    or  
    _"Proceed with the existing setup?"_

- **Missing files** (`submissions.txt`, `config.env`):
  - Displays clear error messages.

- **Invalid menu choices**:
  - Returns user-friendly feedback.

- **Script execution**:
  - Uses **absolute paths** to prevent execution issues.

- **Major operations**:
  - Wrapped in conditionals for **graceful failure**.

---

## 🌿 Git Branching Workflow

### 🪜 Steps Followed:
- All code developed in a dedicated branch: `feature/setup`.
- Finalized scripts merged into the `main` branch.

---

## 📂 Files in `main` Branch

- `create_environment.sh`  
- `copilot_shell_script.sh`  
- `README.md`

### 📁 Dynamically Generated During Setup:

The following are auto-created and populated by `create_environment.sh`:
- `app/`
- `modules/`
- `assets/`
- `config/`

---

### 👨‍💻 Created by: Wisdom *(Linux class - C2)*

This project demonstrates:

- 🐚 Shell scripting mastery  
- ⚙️ Bash logic design  
- 🧩 Modular file execution  
- 🖥️ User-centric CLI interaction

---

## 📁 Repository Format

```bash
submission_reminder_app_Helen751/
├── create_environment.sh
├── copilot_shell_script.sh
├── README.md
```

