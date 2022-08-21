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

    echo "${LIGHTBLUE}================================================"
    echo " CJWelle Mac Installer"
    echo "================================================${NC}\n"

    if test ! $(which brew); then
      echo "Install Xcode"
      xcode-select --install

      echo "Install Homebrew"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
      echo "Update Homebrew"
      brew update
      brew upgrade
    fi
    brew doctor

    git clone https://github.com/cjwelle/mac-setup-script.git --depth 1 && cd mac-setup-script && sh ./setup.sh

    rm -rf ./mac-setup-script
  }

  main
