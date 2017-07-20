# Install RVM

ca-certificates-mozilla:
  pkg.installed:
    - install_recommends: False

fetch-rvm-gpg:
  cmd.run:
    - name: gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    - require:
      - pkg: ca-certificates-mozilla

download-installer:
  pkg.installed:
    - name: curl
  cmd.run:
    - name: |
        curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
        curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc
    - require:
      - pkg: curl
      - cmd: fetch-rvm-gpg

install-rvm:
  cmd.run:
    - name: gpg --verify rvm-installer.asc && bash rvm-installer stable
    - require:
      - cmd: download-installer

source-rvm:
  cmd.run:
    - name: source /etc/profile.d/rvm.sh
    - require:
      - cmd: install-rvm

# Install rubies with RVM

ruby21:
  cmd.run:
    - name: bash -c "source /etc/profile.d/rvm.sh && rvm install ruby 2.1"
    - require:
      - cmd: source-rvm

ruby24:
  cmd.run:
    - name: bash -c "source /etc/profile.d/rvm.sh && rvm install ruby 2.4"
    - require:
      - cmd: source-rvm
