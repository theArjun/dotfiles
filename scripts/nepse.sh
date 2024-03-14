stock_icon="󰠟"

run_segment() {
	working_dir="$HOME/workspace/misc/nepse-api/"
	cd $working_dir
	source .venv/bin/activate
	echo -n $stock_icon
	PYTHONWARNINGS=ignore python3 test.py
}
