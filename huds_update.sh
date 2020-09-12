#!/bin/bash
set -e

TAGNAME="archive"
TAGDATE=$(date +%d-%m-%Y)

echo "Initializing submodules..."
git submodule init > /dev/null 2>&1

echo "Updating submodules from remote repositories..."
git submodule update --recursive --remote > /dev/null 2>&1
sleep 10

echo "Committing changes..."
git commit -a -m "Updated all HUDs to the latest releases." > /dev/null 2>&1

echo "Removing existing Git tag..."
git tag --delete "$TAGNAME" > /dev/null 2>&1 || true
git push --delete origin "$TAGNAME" > /dev/null 2>&1 || true

echo "Adding new tag..."
git tag -s "$TAGNAME" -m "Release of $TAGDATE." > /dev/null 2>&1

echo "Pushing changes..."
git push -u origin master > /dev/null 2>&1
git push -u origin --tags > /dev/null 2>&1

echo "Completed."
