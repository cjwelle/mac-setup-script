#!/usr/bin/env bash

brews=(
  afflib
  ansible
  archey
  augeas
  autoconf
  automake
  aws-rotate-key
  aws-shell
  awscli
  bash-completion
  bash-snippets
  boost
  cairo
  cheat
  coreutils
  dfc
  docker
  findutils
  fish
  fontconfig
  fpp
  freetype
  fribidi
  fzf
  gd
  gdbm
  gettext
  gflags
  git
  git-extras
  git-fresh
  git-lfs
  glib
  glog
  gnuplot
  go
  graphite2
  harfbuzz
  hstr
  htop
  httpie
  icu4c
  iftop
  ilmbase
  imagemagick
  jansson
  jpeg
  jq
  kubernetes-cli
  libarchive
  libcerf
  libde265
  libevent
  libewf
  libffi
  libheif
  libidn2
  libmagic
  libomp
  libpng
  libpq
  librdkafka
  libtiff
  libtool
  libunistring
  libyaml
  lighttpd
  little-cms2
  lldpd
  lnav
  lua
  lynx
  lz4
  lzlib
  lzo
  mackup
  mas
  micro
  moreutils
  mosh
  mtr
  ncdu
  ncurses
  nmap
  node
  nspr
  nss
  oniguruma
  openexr
  openjpeg
  openldap
  openssl
  openssl@1.1
  osquery
  pango
  pcre
  pcre2
  perl
  pgcli
  pixman
  poppler
  postgresql
  postgresql@10
  protobuf
  pv
  python
  python@2
  qt
  rapidjson
  readline
  rocksdb
  ruby
  saml2aws
  shared-mime-info
  shellcheck
  sleuthkit
  snappy
  sqlite
  ssdeep
  stormssh
  telnet
  thefuck
  thrift
  tmux
  trash
  tree
  vagrant-completion
  vim
  webp
  wget
  x265
  xz
  yara
  yarn
  yubico-piv-tool
  zstd
)

casks=(
  adobe-acrobat-reader
  adobe-air
  aerial
  angry-ip-scanner
  arq
  atlauncher
  atom
  authy
  bartender
  butt
  cakebrew
  divvy
  dropbox
  duet
  epic
  firefox
  font-source-code-pro
  gimp
  github
  google-backup-and-sync
  google-chrome
  hostbuddy
  iterm2
  java
  macdown
  microsoft-office
  mindjet-mindmanager
  monity-helper
  muzzle
  nightowl
  numi
  osxfuse
  resilio-sync
  skype
  spotify
  steam
  superduper
  sync
  transmission-remote-gui
  transmit
  twitch
  unetbootin
  vagrant
  vagrant-manager
  veracrypt
  virtualbox
  viscosity
  visual-studio-code
  vlc
  vmware-fusion
  zoomus
)

pips=(
  ansi2html
  ansible
  asn1crypto
  awscli
  bcrypt
  botocore
  cffi
  cfn-flip
  Click
  colorama
  cryptography
  docutils
  enum34
  future
  futures
  Glances
  idna
  ipaddress
  Jinja2
  jmespath
  MarkupSafe
  ohmu
  paramiko
  pip
  powerline-shell
  protobuf
  psutil
  PyAFF
  pyasn1
  pycparser
  PyNaCl
  python-dateutil
  python-magic
  pythonpy
  PyYAML
  rsa
  s3cmd
  s3transfer
  scandir
  setuptools
  six
  urllib3
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
  ansible-vault
  atom-beautify
  atom-cform
  atom-cform-yaml
  atom-cli-diff
  atom-debugger
  atom-ide-debugger-python
  atom-ide-ui
  atom-json-color
  atom-material-syntax-dark
  atom-material-ui
  atom-node-debugger
  atom-yamljson
  autocomplete-ansible
  autocomplete-modules
  autocomplete-python
  autocomplete-xml
  busy-signal
  debugger
  environment
  git-plus
  git-status
  git-time-machine
  intentions
  language-ansible
  language-json-comments
  language-yaml-cloudformation
  linter-js-yaml
  linter-ui-default
  merge-conflicts
  minimap
  minimap-git-diff
  pretty-json
  ramda-syntax
  sort-lines
  sort-selected-elements
  sublime-style-column-selection
  split-diff
  sync-settings
  tree-view-git-branch
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
  echo "Please enter in your password."
  echo -n Password:
  read -s password
  echo
}


# if test ! $(which brew); then
#   echo "Install Xcode"
#   xcode-select --install
#
#   echo "Install Homebrew"
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# else
#   echo "Update Homebrew"
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
    echo "Execute: $exec"
    if ${exec} ; then
      echo "Installed $pkg"
    else
      echo "Failed to execute: $exec"
    fi
  done
}

# echo "Update ruby"
# ruby -v
# brew install gpg
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | bash -s stable
# ruby_version='2.6.0'
# rvm install ${ruby_version}
# rvm use ${ruby_version} --default
# ruby -v
# sudo gem update --system

echo "Install Java"
brew cask install java

echo "Install packages"
brew info ${brews[@]}
install 'brew install' ${brews[@]}

echo "Install software"
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

### TODO: Redo the bash/fish echo variable.
# echo "Upgrade bash"
# brew install bash
# sudo bash -c "echo $(brew --prefix)/bin/bash >> /private/etc/shells"
# mv ~/.bash_profile ~/.bash_profile_backup
# mv ~/.bashrc ~/.bashrc_backup
# mv ~/.gitconfig ~/.gitconfig_backup
# cd; curl -#L https://github.com/barryclark/bashstrap/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,screenshot.png}
# source ~/.bash_profile

echo "Set git defaults"
for config in "${git_configs[@]}"; do
  git config --global ${config}
done
gpg --keyserver hkp://pgp.mit.edu --recv ${gpg_key}

### TODO: Come back and review Mac CLI install.
# echo "Install mac CLI [NOTE: Say NO to bash-completions since we have fzf]!"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"

echo "Update packages"
pip3 install --upgrade pip setuptools wheel
mac update

echo "Cleanup"
brew cleanup
brew cask cleanup

read -p "Run `mackup restore` after DropBox has done syncing ..."
echo "Done!"
