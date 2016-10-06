# Rails API Rate Limiting Example App

## About the app

A Ruby on Rails 5 example for rate-limiting an API.

## Prerequisites

* Ruby version `2.3.1` or a newer version.
* Redis
* PostgreSQL
* Git

## Installation

### Install on Mac OS X


#### Ruby Installation

Mac OS X ships with Ruby, but it is best to install Ruby via `rbenv`.
Here's how to do that:

```bash
brew install rbenv readline ruby-build
env CONFIGURE_OPTS=--with-readline-dir=`brew --prefix readline` rbenv install 2.3.1
rbenv global 2.3.1
```

Add this to your path, which is usually your `.zhrc` or `.bashrc` file.

```bash
# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export RBENV_ROOT="$HOME/.rbenv"

if [ -d $RBENV_ROOT ]; then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Ruby gems
export PATH=$PATH:$HOME/.rbenv/versions/2.3.1/bin
```

#### Redis Installation

```bash
brew install redis
```

#### PostgreSQL Installation

```bash
brew install postgresql
```

### Install on Debian/ Ubuntu

#### Ruby Installation

Make sure the Linux distro has the latest packages.

```bash
sudo apt-get update
sudo apt-get upgrade
```

Install Rbenv

```bash
sudo apt-get install git-core
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
apt-get install build-essential libssl-dev libcurl4-openssl-dev libreadline-dev -y
rbenv install 2.3.1
rbenv global 2.3.1
```

#### Redis Installation

```bash
sudo apt-get install redis
```

#### PostgreSQL Installation

```bash
sudo apt-get install postgresql
```


#### Common Installation Procedures

This will install the application's dependencies:

```
gem i bundler
cd /path/to/rails_limit
bundle install --no-deployment
```

Create the development and test database:

```
bundle exec rake db:create
```
