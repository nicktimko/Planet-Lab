apt-get update
apt-get install -yqq \
  apache2 \
  python \
  python-pip \
  ruby1.9.1 \
  postgresql-9.3 \
  libpq-dev \
  postgresql-server-dev-9.3 \
  python-dev \
  graphviz \
  git \
  build-essential linux-image-extra-$(uname -r) \
  libdb-dev libz-dev libreadline-dev \
  libncursesw5-dev libssl-dev libgdbm-dev \
  libsqlite3-dev libbz2-dev liblzma-dev \
  libc6-dev tk-dev

sudo gem install foreman
sudo -u postgres createuser -rs vagrant

PYENV_INSTALLER="https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer"
curl -sSL $PYENV_INSTALLER | su vagrant -s /bin/bash

echo 'LS_COLORS=$LS_COLORS:"di=0;35:"' >> ~/.bashrc # because I hate dark blue.

cat <<'EOF' >> /home/vagrant/.bashrc
LS_COLORS=$LS_COLORS:"di=0;35:"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

cd /vagrant
EOF

su - vagrant -c '$HOME/.pyenv/bin/pyenv install 2.7.10'
su - vagrant -c '$HOME/.pyenv/bin/pyenv global 2.7.10'
su - vagrant -c '$HOME/.pyenv/shims/pip install --upgrade pip'
su - vagrant -c '$HOME/.pyenv/shims/pip install -r /vagrant/backend/requirements.txt'
su - vagrant -c '$HOME/.pyenv/shims/pip install -r /vagrant/backend/test_requirements.txt'
