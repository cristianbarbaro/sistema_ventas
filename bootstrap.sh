#!/bin/bash

# Installing Ruby and rbenv.
sudo apt-get update && apt-get install -y autoconf bison build-essential lib{ssl,yaml,sqlite3,mysqlclient}-dev libreadline6{,-dev} zlib1g{,-dev} git mysql-server-core-5.5
sudo apt-get install -y nodejs
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
rbenv install 2.3.0
rbenv global 2.3.0
