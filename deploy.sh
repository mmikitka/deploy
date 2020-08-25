#!/bin/sh

set -eaux

usage() {
  echo "Usage : $(basename $0) [options] [--] DEPLOY_REPO_PATH

    Options:
    -h|help   Display this message
    -t|tags   Comma-separated list of Ansible playbook tags (e.g., base,extras)"
}

main() {
  deploy_repo_path="$1"
  shift

  install_ansible
  install_git
  clone_repo "$deploy_repo_path"
  run_ansible "${deploy_repo_path}/ansible/playbook.yml" "$@"
}

install_ansible() {
  if [ "$OS_RELEASE" = "arch" ]; then
    sudo pacman -Sy --noconfirm ansible
  else
    sudo apt-get install -y ansible
  fi
}

install_git() {
  if [ "$OS_RELEASE" = "arch" ]; then
    sudo pacman -Sy --noconfirm git
  else
    sudo apt-get install -y git
  fi
}

clone_repo() {
  repo_dir="$1"
  if [ ! -d "$repo_dir" ]; then
    mkdir -p $1
    git clone https://github.com/mmikitka/deploy.git $repo_dir
  fi
}

run_ansible() {
  playbook_path="$1"
  shift

  if [ $# -gt 0 -a "$@" != "" ]; then
    ansible-playbook --tags=${@} $playbook_path
  else
    ansible-playbook $playbook_path
  fi
}

OS_RELEASE=$(grep "^ID=" /etc/os-release | cut -d= -f2)

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
