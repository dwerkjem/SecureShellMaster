#!/usr/bin/env bash

# Find out where we are
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
wd=$(pwd) || { echo "Failed to get working directory"; exit 1; }

# Extract root directory of the project
ROOT_DIR="${DIR%%/SecureShellMaster/*}/SecureShellMaster"

# Check if the script is in the expected directory structure
if [[ $DIR != *"/SecureShellMaster"* ]]; then
    echo "Structure is not as expected (SecureShellMaster/DEV/buildDeps.sh) ran from $wd with DIR=$DIR please run from the root (SecureShellMaster) of the project" 
    exit 1
fi

# Read NonAuto.txt before changing directory
NON_AUTO_CONTENT=$(cat "$DIR/NonAuto.txt") || { echo "Failed to read NonAuto.txt"; exit 1; }

# Change to root directory of the project
cd "$ROOT_DIR" || { echo "Failed to change directory to $ROOT_DIR"; exit 1; }

# Check if target directory exists or create it
mkdir -p lib/install/

# Generate requirements.txt
{
  echo "# Automatically built requirements"
  pip freeze || { echo "pip freeze failed"; exit 1; }
  echo
  echo "# Manual requirements"
  echo "$NON_AUTO_CONTENT"
} > lib/install/requirements.txt
