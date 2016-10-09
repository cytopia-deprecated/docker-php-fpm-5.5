#!/bin/sh -eu

# Check Dockerfile
if [ ! -f "Dockerfile" ]; then
	echo "Dockerfile not found."
	exit 1
fi

# Get docker Name
if ! grep -q 'image=".*"' Dockerfile > /dev/null 2>&1; then
	echo "No 'image' LABEL found"
	exit
fi
NAME="$( grep 'image=".*"' Dockerfile | sed 's/^[[:space:]]*//g' | awk -F'"' '{print $2}' )"

DID="$(docker ps | grep "cytopia/${NAME}" | awk '{print $1}')"
docker exec -i -t "${DID}" env TERM=xterm /bin/bash -l

