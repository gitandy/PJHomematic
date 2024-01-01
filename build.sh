#!/bin/bash

echo "Get version info..."
VERSION=$(git describe --tags)
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "master" ]; then BRANCH=""; fi
STATUS=$(git status -s -uno --porcelain)
if [ -z "$STATUS" ]; then UNCLEAN="False"; else UNCLEAN="True"; fi
echo "__version_str__ = '$VERSION'" > src/homematic/__version__.py
echo "__version__ = __version_str__[1:].split('-')[0]" >> src\homematic\__version__.py
echo "__branch__ = '$BRANCH'" >> src/homematic/__version__.py
echo "__unclean__ = $UNCLEAN" >> src/homematic/__version__.py
echo "Version: $VERSION $BRANCH $UNCLEAN"

source ./venv/bin/activate

echo
echo "Build package..."
python -m pip install --upgrade build
python -m build
echo "...Done!"
