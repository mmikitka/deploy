#!/bin/sh

set -ea

main() {
  git_base_dir="$1"

  enforce_root
  install_ansible
  install_git
  clone_repo "$git_base_dir"
  run_ansible "${git_base_dir}/deploy/ansible/playbook.yml"
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
  apt-key list | grep "Launchpad PPA for Ansible" &> /dev/null
  if [ $? -ne 0 ]; then
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
  fi
  apt-get update
  apt-get install -y --allow-unauthenticated ansible
}

install_git() {
  apt-get install -y git
}

clone_repo() {
  sudo -u "$SUDO_USER" /bin/sh -c \
    "mkdir -p $1 && \
     git clone https://github.com/mmikitka/deploy.git ${1}/deploy"
}

run_ansible() {
  sudo -u "$SUDO_USER" /bin/sh -c "ansible-playbook -K $1"
}

if [ $# -ne 1 ]; then
  echo "Usage: $(basename $0) git_base_dir"
  exit 1
fi

main "$1"
