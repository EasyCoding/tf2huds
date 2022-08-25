#!/bin/bash
set -e

TAGNAME=$(date +%Y.%m.%d)
TAGDATE=$(date +%Y-%m-%d)

echo "Initializing submodules..."
git submodule init

echo "Updating submodules from remote repositories..."
git submodule update --recursive --remote
sleep 10

echo "Committing changes..."
git commit -a -m "Updated all HUDs to the latest releases."

echo "Removing existing Git tag..."
git tag --delete "$TAGNAME" > /dev/null 2>&1 || true
git push --delete origin "$TAGNAME" > /dev/null 2>&1 || true

echo "Adding new tag..."
git tag -s "$TAGNAME" -m "Release of $TAGDATE."

echo "Pushing changes..."
git push -u origin master
git push -u origin --tags

echo "Completed."
