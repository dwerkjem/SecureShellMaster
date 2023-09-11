#!/usr/bin/env bash

# Install script for SecureShellMaster (SSM)

# Check what package manager is installed and os version

echo "Checking OS..."
if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$NAME
	VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
	OS=$(lsb_release -si)
	VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
	VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
	OS=Debian
	VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
	OS=SuSE
elif [ -f /etc/redhat-release ]; then
	OS=RedHat
else
	OS=$(uname -s)
	VER=$(uname -r)
fi

echo "OS is $OS $VER"

# Check if git is installed

echo "Checking if git is installed..."

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
   # ask for confirmation to install git

    read -p "Do you want to install git? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
    	echo "Exiting..."
        exit 1
    fi


  echo 'Installing git...'
  apt-get install git
fi

# Check if python3 is installed

echo "Checking if python3 is installed..."

if ! [ -x "$(command -v python3)" ]; then
  echo 'Error: python3 is not installed.' >&2
   # ask for confirmation to install python3

    read -p "Do you want to install python3? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
    	echo "Exiting..."
        exit 1
    fi
fi

# Check if pip3 is installed

echo "Checking if pip3 is installed..."

if ! [ -x "$(command -v pip3)" ]; then
  echo 'Error: pip3 is not installed.' >&2
   # ask for confirmation to install pip3

    read -p "Do you want to install pip3? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
    	echo "Exiting..."
        exit 1
    fi
fi

# Check if python3-venv is installed

echo "Checking if python3-venv is installed..."

if ! python3 -c "import venv" 2>/dev/null; then
  echo 'Error: python3-venv is not installed.' >&2
  # ask for confirmation to install python3-venv

  read -p "Do you want to install python3-venv? (y/n)" -n 1 -r -t 10
  echo    # (optional) move to a new line

  # Set default value if empty (i.e., if timed out)
  if [ -z "$REPLY" ]; then
    REPLY='y'
  fi

  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Exiting..."
    exit 1
  fi
fi

# Check if java is installed

echo "Checking if java is installed..."

if ! [ -x "$(command -v java)" ]; then
  echo 'Error: java is not installed.' >&2
   # ask for confirmation to install java

    read -p "Do you want to install java? (y/n)" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
    	echo "Exiting..."
        exit 1
    fi

    echo 'Installing open java...'

    apt-get install openjdk-7-jre

    # check which version of java is installed

    echo "Checking java version..."

    if java -version 2>&1 | grep -q '1.7'; then
        echo correct version of java installed
    else
        echo "Error: wrong version of java installed. Please install java 1.7"
        exit 1
    fi
fi

# make sure we are in the right directory

echo "Checking if we are in the right directory..."

wd=$(pwd)
if [ ! -f "$wd/readme.md" ]; then
    echo "Error: You are not in the right directory. Please cd to the directory where you cloned the repository."
    exit 1
fi
# create virtual environment

echo "Creating virtual environment..."

# check if a virtual environment is already installed by searching for the pyvenv.cfg file with a depth of 2

if ! find . -maxdepth 2 -name 'pyvenv.cfg' | grep -q 'pyvenv.cfg'; then
    read -p "Do you want to name the virtual environment? (y/n)" -r -t 5 -p "in 5 seconds the default name will be used"
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Using default name: venv"
        python3 -m venv venv

        echo "Activating virtual environment..."
        source venv/bin/activate
    else
        read -p "Enter name for virtual environment: " venvname
        python3 -m venv $venvname

        echo "Activating virtual environment..."
        source $venvname/bin/activate
    fi

    # if direnv is installed, add venv to .envrc

    if ! [ -x "$(command -v direnv)" ]; then
    echo 'direnv is not installed passing.' >&2
    else
    echo "Adding venv to .envrc..."
    echo "layout python3" >> .envrc
    echo "source venv/bin/activate" >> .envrc
    direnv allow
    fi

else
    echo "Virtual environment already installed. Skipping..."
fi

# install python dependencies

echo "Installing python dependencies..."

pip3 install -r lib/install/requirements.txt

echo "DONE!"