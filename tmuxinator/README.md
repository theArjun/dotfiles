# Tmuxinator Configurations

[Tmuxinator](https://github.com/tmuxinator/tmuxinator) is a YAML configuration tool that allows you to easily manage and launch tmux sessions with predefined window and pane layouts.

## Installation

```bash
gem install tmuxinator
```

## Common Commands

### Start a session
```bash
mux start <project-name>
```

### Start a session in the foreground (stays attached)
```bash
mux start -a <project-name>
```

### Stop/Kill a session
```bash
mux stop <project-name>
```

### Delete a project configuration
```bash
mux delete <project-name>
```

### List all projects
```bash
mux list
```

### Edit a project configuration
```bash
mux edit <project-name>
```

### Create a new project
```bash
mux new <project-name>
```

## Available Configurations

### soudan.yml
Backend development setup for Soudan project.
```bash
mux start soudan
```

Includes: Editor, Server, Lazygit, Ngrok, Redis, Android Emulators

### easysheet.yml
Multi-service development setup using pnpm.
```bash
mux start easysheet
```

Includes:
- **editor**: Nvim in backend directory
- **backend**: Backend dev server (`pnpm dev`)
- **admin**: Admin panel dev server (`pnpm dev`)
- **frontend**: Frontend dev server (`pnpm dev`)
- **lazygit**: Git UI for version control

## Creating a New Configuration

Create a YAML file in this directory with the following structure:

```yaml
name: my-project
root: ~/workspace/my-project/

startup_window: editor

windows:
  - editor: nvim .
  - server: npm run dev
  - lazygit: lazygit
```

Then start it with: `mux start my-project`

## Tips

- Use `pre_window` to run commands before any window launches (e.g., activating venv)
- Each window can have multiple panes using the `panes` key
- Use `startup_window` to specify which window is active when the session starts
- Relative paths are resolved from the `root` directory
