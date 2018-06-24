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
  apt-get install -y ansible
}

install_git() {
  apt-get install -y git
}

clone_repo() {
  repo_dir="${1}/deploy"
  if [ ! -d "$repo_dir" ]; then
    sudo -u "$SUDO_USER" /bin/sh -c \
      "mkdir -p $1 && \
       git clone https://github.com/mmikitka/deploy.git $repo_dir"
  fi
}

run_ansible() {
  sudo -u "$SUDO_USER" /bin/sh -c "ansible-playbook -K $1"
}

if [ $# -ne 1 ]; then
  echo "Usage: $(basename $0) git_base_dir"
  exit 1
fi

main "$1"
