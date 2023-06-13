#!/bin/bash

mkdir -p files

# Retreive data from application and save locally for parsing
curl http://localhost:5000/data > data.json

# Count number of entries in data file
entries=`jq -r '.samples | length' data.json` 

# Iterate through entries and create files. Clean any newline characters
for (( i=0 ; i<$entries ; i++ )); do
    sha=`jq -r '.samples['$i'] .id' data.json`
    jq -r '.samples['$i'] .name' data.json | tr -d '\n' > files/$sha.txt
done

# Run a test to verify that the hash of file contents matches the filename
cd files
for file in *; do
	echo Checking file integrity of $file...
    if [ "$(sha256sum $file | awk '{print $1}').txt" == "$file" ]
    then
    	echo ">> SHA256 checksum match"
    else
     	echo ">> WARNING!!! SHA256 checksum mismatch"
    fi
done