#!/bin/sh

# Colors
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
NC='\033[1;37m'
LIGHTBLUE='\033[01;34m'
NC='\033[0m' # No Color

# In directory
PACKAGE_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  function prompt {
    read -p "Setting up $1 ..."
  }
  
    echo "${LIGHTBLUE}================================================"
    echo " CJWelle Mac Installer"
    echo "================================================${NC}\n"

    if test ! $(which brew); then
      prompt "Install Xcode"
      xcode-select --install

      prompt "Install Homebrew"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
      prompt "Update Homebrew"
      brew update
      brew upgrade
    fi
    brew doctor

    git clone https://github.com/cjwelle/mac-setup-script.git --depth 1 && cd mac-setup-script && sh ./setup.sh
  }

  main
