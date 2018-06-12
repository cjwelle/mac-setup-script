#!/usr/bin/env bash

brews=(
  ansible
  archey
  aws-shell
  awscli
  bash-completion
  bash-snippets
  cheat
  coreutils
  dfc
  findutils
  fish
  fontconfig
  fpp
  fzf
  git
  git-extras
  git-fresh
  git-lfs
  gnuplot
  go
  haskell-stack
  hh
  htop
  httpie
  iftop
  imagemagick
  jq
  kubernetes-cli
  lighttpd
  lnav
  mackup
  macvim
  mas
  micro
  moreutils
  mosh
  mtr
  ncdu
  nmap
  node
  osquery
  pgcli
  poppler
  postgresql
  pv
  python
  python3
  shellcheck
  stormssh
  thefuck
  tmux
  trash
  tree
  vagrant-completion
  vim
  wget
  yarn
  xz
)

casks=(
  adobe-acrobat-reader
  adobe-air
  aerial
  angry-ip-scanner
  atlauncher
  atom
  authy
  basecamp
  cakebrew
  cleanmymac
  commander-one
  divvy
  docker
  dropbox
  epic
  filezilla
  firefox
  geekbench
  gimp
  github
  google-backup-and-sync
  google-chrome
  hobo
  hostbuddy
  hyper
  ihosts
  iina
  istat-menus
  istat-server
  iterm2
  java
  jetbrains-toolbox
  keka
  launchrocket
  licecap
  macdown
  microsoft-office
  mindjet-mindmanager
  minikube
  monity-helper
  muzzle
  osxfuse
  pandora
  private-eye
  qlcolorcode
  qlmarkdown
  qlstephen
  quicklook-csv
  quicklook-json
  resilio-sync
  royal-tsx
  satellite-eyes
  screens
  screens-connect
  serial
  sidekick
  skype
  slack
  sling
  snagit
  sourcetree
  spotify
  steam
  superduper
  switchhosts
  sync
  transmission
  transmission-remote-gui
  transmit
  unetbootin
  vagrant
  vagrant-manager
  veracrypt
  virtualbox
  virtualbox-extension-pack
  viscosity
  visual-studio-code
  vlc
  vmware-fusion
  webstorm
  xbench
  xquartz
  zoomus
)

pips=(
  pip
  ansible
  bcrypt
  glances
  ohmu
  powerline-shell
  pythonpy
  PyYAML
  setuptools
  siz
  wheel
)

gems=(
  bundle
  json
  nokogiri
  sqlite3
  travis
)

npms=(
  fenix-cli
  gitjk
  kill-tabs
  n
)

apm=(
  ansible-galaxy
  ansible-snippets
  ansible-vault@
  asciidoc-assistant
  asciidoc-image-helper
  asciidoc-preview
  atom-beautify
  atom-cform
  atom-cform-yaml
  atom-json-color
  atom-material-syntax-dark
  atom-material-ui
  atom-yamljson
  autocomplete-ansible
  autocomplete-asciidoc
  autocomplete-modules
  autocomplete-python
  autocomplete-xml
  git-plus
  git-projects
  git-status
  git-time-machine
  language-ansible
  language-asciidoc
  language-json-comments
  language-yaml-cloudformation
  merge-conflicts
  pretty-json
  project-plus
  project-viewer
  ramda-syntax
  sort-lines
  sync-settings
  synced-sidebar
  tree-view-git-branch
  tree-view-git-status
)

gpg_key='966831710CA34AAA'
git_configs=(
  "branch.autoSetupRebase always"
  "color.ui auto"
  "core.autocrlf input"
  "core.pager cat"
  "credential.helper osxkeychain"
  "merge.ff false"
  "pull.rebase true"
  "push.default simple"
  "rebase.autostash true"
  "rerere.autoUpdate true"
  "rerere.enabled true"
  "user.name cjwelle"
  "user.email cjwelle@gmail.com"
  "user.signingkey ${gpg_key}"
)

vscode=(
  donjayamanne.python
  dragos.scala-lsp
  lukehoban.Go
  ms-vscode.cpptools
  rebornix.Ruby
  redhat.java
)

fonts=(
  font-source-code-pro
)

######################################## End of app list ########################################
set +e
set -x

function password {
  prompt "Please enter in your password."
  echo -n Password:
  read -s password
  echo
}

function prompt {
  read -p "Installing $1 ..."
}

# if test ! $(which brew); then
#   prompt "Install Xcode"
#   xcode-select --install
#
#   prompt "Install Homebrew"
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# else
#   prompt "Update Homebrew"
#   brew update
#   brew upgrade
# fi
# brew doctor

function install {
  cmd=$1
  shift
  for pkg in $@;
  do
    exec="$cmd $pkg"
    prompt "Execute: $exec"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
    fi
  done
}

# prompt "Update ruby"
# ruby -v
# brew install gpg
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash -s stable
# ruby_version='2.6.0'
# rvm install ${ruby_version}
# rvm use ${ruby_version} --default
# ruby -v
# sudo gem update --system

prompt "Install Java"
brew cask install java

prompt "Install packages"
brew info ${brews[@]}
install 'brew install' ${brews[@]}

prompt "Install software"
brew tap caskroom/versions
brew cask info ${casks[@]}
install 'brew cask install' ${casks[@]}
install 'pip install' --upgrade ${pips[@]}
install 'gem install' ${gems[@]}
install 'npm install --global' ${npms[@]}
install 'code --install-extension' ${vscode[@]}
brew tap caskroom/fonts
install 'brew cask install' ${fonts[@]}
install 'apm install' ${apm[@]}

### TODO: Redo the bash/fish prompt variable.
# prompt "Upgrade bash"
# brew install bash
# sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
# mv ~/.bash_profile ~/.bash_profile_backup
# mv ~/.bashrc ~/.bashrc_backup
# mv ~/.gitconfig ~/.gitconfig_backup
# cd; curl -#L https://github.com/barryclark/bashstrap/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,screenshot.png}
# source ~/.bash_profile

prompt "Set git defaults"
for config in "${git_configs[@]}"; do
  git config --global ${config}
done
gpg --keyserver hkp://pgp.mit.edu --recv ${gpg_key}

### TODO: Come back and review Mac CLI install.
# prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"

prompt "Update packages"
pip3 install --upgrade pip setuptools wheel
mac update

prompt "Cleanup"
brew cleanup
brew cask cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"
