#!/bin/bash

# 1. Check if Conky is running and terminate it
if pgrep -x "conky" > /dev/null; then
    echo "Conky is running. Terminating..."
    killall conky
    
    # Wait up to 3 seconds for the processes to completely exit
    for i in {1..3}; do
        if ! pgrep -x "conky" > /dev/null; then
            break
        fi
        sleep 1
    done
else
    echo "Conky is not running."
fi

# 2. Optional: Wait a brief moment before starting to ensure a clean launch
sleep 1

# 3. Start a new Conky instance in the background (daemon mode)
echo "Starting Conky..."
conky -c $HOME/.config/conky/WMaker/WMaker 

exit 0