#!/bin/sh

set -ea

main() {
  playbook="$1"
  enforce_root
  install_ansible
  run_ansible "$playbook"
}

enforce_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "You must run this root: try \"sudo $(basename -- $0)\""
    exit 1
  fi
}

install_ansible() {
  cat <<EOF > /etc/apt/sources.list.d/ansible.list
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
EOF
  apt-key list | grep "Launchpad PPA for Ansible" > /dev/null
  if [ $? -ne 0 ]; then
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
  fi
  apt-get update
  apt-get install -y ansible
}

run_ansible() {
  sudo -u "$SUDO_USER" /bin/sh -c "ansible-playbook $1"
}

if [ $# -ne 1 ]; then
  echo "Usage: $(basename $0) playbook.yml"
  exit 1
fi

main "$1"
