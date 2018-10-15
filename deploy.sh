#!/bin/sh

set -ea

usage() {
  echo "Usage : $(basename $0) [options] [--] DEPLOY_REPO_PATH

    Options:
    -h|help   Display this message
    -t|tags   Comma-separated list of Ansible playbook tags (e.g., base,extras)"
}

main() {
  deploy_repo_path="$1"
  shift

  enforce_root
  install_ansible
  install_git
  clone_repo "$deploy_repo_path"
  run_ansible "${deploy_repo_path}/ansible/playbook.yml" "$@"
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
  repo_dir="$1"
  if [ ! -d "$repo_dir" ]; then
    sudo -u "$SUDO_USER" /bin/sh -c \
      "mkdir -p $1 && \
       git clone https://github.com/mmikitka/deploy.git $repo_dir"
  fi
}

run_ansible() {
  playbook_path="$1"
  shift

  if [ $# -gt 0 -a "$@" != "" ]; then
    sudo -u "$SUDO_USER" /bin/sh -c "ansible-playbook --tags=${@} $playbook_path"
  else
    sudo -u "$SUDO_USER" /bin/sh -c "ansible-playbook $playbook_path"
  fi
}

tags=""
while getopts "ht:" opt
do
  case $opt in

    h|help) usage; exit 0;;
    t|tags) tags="$OPTARG";;
    *) echo -e "\n Option does not exist: $OPTARG\n"
       usage; exit 1;;

  esac
done
shift $(($OPTIND-1))

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

main "$1" "$tags"
