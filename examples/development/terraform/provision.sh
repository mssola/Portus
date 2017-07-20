#!/bin/bash

# Helper functions

log()   { echo ">>> $1" ; }

tcp_port_open() {
  netstat -aln | awk '$6 == "LISTEN" && $4 ~ "[\\.\\:]'$1'$"' | grep -q tcp &> /dev/null
}

wait_for_port() {
  local port=$1
  until tcp_port_open "$port" ; do
    log "(waiting for port $port to be open...)"
    sleep 5
  done
}

# Parse options

ROLE=
MASTER=

while [ $# -gt 0 ] ; do
  case $1 in
    -r|--role)
      ROLE="$2"
      shift
      ;;
    -m|--master)
      MASTER="$2"
      shift
      ;;
    *)
      abort "Unknown argument $1"
      ;;
  esac
  shift
done

log "Installing packages"
zypper -n --no-gpg-checks --quiet --no-color install salt-master salt-minion

log "Setting up the salt minion"
echo "master: $MASTER" > "/etc/salt/minion.d/minion.conf"
echo "grains_refresh_every: 10" > "/etc/salt/minion.d/grains_refresh.conf"
echo -e "roles:\n  - $ROLE" > /etc/salt/grains

log "Setting up the salt master"
cat <<EOF > /etc/salt/master.d/master.conf
user: root
auto_accept: True
interface: 0.0.0.0
timeout: 20

file_roots:
  base:
    - /srv/Portus/examples/development/terraform/salt
EOF

log "Starting salt services"
systemctl start salt-master
wait_for_port 4505
systemctl start salt-minion
systemctl enable salt-master salt-minion
