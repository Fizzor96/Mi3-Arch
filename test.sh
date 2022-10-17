#!/bin/bash
FILE=/usr/bin/yay
if [ -f "$FILE" ]
then
    echo "$FILE exists."
else
    echo "Not exist"
fi