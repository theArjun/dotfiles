#!/usr/bin/env bash
# Print the output of the nepcal command for tmux-powerline
run_segment() {
	nepcal_output=$(nepcal d | awk '{for(i=1;i<NF;i++) printf "%s ", $i; printf "\n"}')
	echo "${nepcal_output}"
}
