#### Instalación de Ruby (usando *rbenv*):

```
$ sudo apt-get install -y autoconf bison build-essential lib{ssl,yaml,sqlite3}-dev libreadline6{,-dev} zlib1g{,-dev}
$ sudo apt-get install nodejs
$ git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
$ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
$ source ~/.bashrc
$ rbenv install 2.3.0
$ rbenv global 2.3.0
```


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
gem install bundle
gem install rails

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
