#!/usr/bin/env bash

brews=(
  ansible
  archey
  awscli
  aws-shell
  chainsawbaby/formula/bash-snippets
  cheat
  coreutils
  dfc
  findutils
  fish
  fontconfig --universal
  fpp
  fzf
  git
  bash-completion
  git-extras
  git-fresh
  git-lfs
  gnuplot --with-qt
  gnu-sed --with-default-names
  go
  haskell-stack
  hh
  htop
  httpie
  iftop
  imagemagick --with-webp
  jq
  lighttpd
  lnav
  kubernetes-cli
  mackup
  macvim
  mas
  micro
  moreutils
  mtr
  ncdu
  nmap
  node
  poppler
  postgresql
  pgcli
  pv
  python
  python3
  osquery
  scala
  sbt
  shellcheck
  stormssh
  thefuck
  tmux
  tree
  trash
  vim --with-override-system-vi
  wget --with-iri
)

casks=(
  adobe-reader
  adobe-air
  aerial
  angry-ip-scanner
  atlauncher
  atom
  authy
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
  google-chrome
  google-drive
  github-desktop
  hosts
  hobo
  hostbuddy
  hyper
  iina
  istat-menus
  istat-server
  iterm2
  launchrocket
  licecap
  java
  jetbrains-toolbox
  kap-beta
  keka
  betterzipql
  qlcolorcode
  qlmarkdown
  qlstephen
  quicklook-json
  quicklook-csv
  macdown
  mindjet-mindmanager
  microsoft-office
  minikube
  monity-helper
  muzzle
  mosh
  osxfuse
  pandora
  private-eye
  resilio-sync
  royal-tsx
  satellite-eyes
  screens
  screens-connect
  serial
  sidekick
  skype
  snagit
  slack
  sling
  spotify
  sqlite
  steam
  superduper
  sync
  teleport
  transmit
  transmission
  transmission-remote-gui
  unetbootin
  vagrant
  vagrant-manager
  veracrypt
  viscosity
  visual-studio-code
  volumemixer
  virtualbox
  virtualbox-extension-pack
  vlc
  webstorm
  xquartz
  xz
  xbench
  zoomus
)

pips=(
  pip
  ansible
  bcrypt
  powerline-shells
  glances
  ohmu
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
  nuclide-installer
)

gpg_key='3E219504'
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
  "user.name pathikrit"
  "user.email pathikritbhowmick@msn.com"
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

function prompt {
  read -p "Hit Enter to $1 ..."
}

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
brew tap homebrew/dupes

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

prompt "Installing secondary packages"
install 'pip install --upgrade' ${pips[@]}
install 'gem install' ${gems[@]}
install 'npm install --global' ${npms[@]}
install 'code --install-extension' ${vscode[@]}
brew tap caskroom/fonts
install 'brew cask install' ${fonts[@]}

prompt "Upgrade bash"
brew install bash
sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
mv ~/.bash_profile ~/.bash_profile_backup
mv ~/.bashrc ~/.bashrc_backup
mv ~/.gitconfig ~/.gitconfig_backup
cd; curl -#L https://github.com/barryclark/bashstrap/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,screenshot.png}
#source ~/.bash_profile

prompt "Set git defaults"
for config in "${git_configs[@]}"
do
  git config --global ${config}
done
gpg --keyserver hkp://pgp.mit.edu --recv ${gpg_key}

prompt "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"

prompt "Update packages"
pip3 install --upgrade pip setuptools wheel
mac update

prompt "Cleanup"
brew cleanup
brew cask cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"
