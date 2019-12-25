#!/bin/bash
if [ "$DEBUG" == "True" ]; then
    npm run debug
else
    npm run start
fi