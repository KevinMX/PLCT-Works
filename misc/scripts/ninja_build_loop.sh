#!/bin/bash
counter=0
while true; do 
        counter=$((counter + 1))
        echo "build $counter started"
        ninja clean; ninja

        if [ $? -ne 0 ]; then
                echo "build $counter failed"
                break
        fi

        echo "build $counter succeeded"
done