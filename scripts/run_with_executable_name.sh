#!/bin/bash

# Check if a program name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <program> [args...]"
  exit 1
fi

# Rename the terminal session
printf "\033]0;%s\007" "$1"

# Run the program
exec "$@"
