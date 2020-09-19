#!/bin/sh

project="$1"
if [ ! -z $project ]; then
    echo "Creating project ${project}"
    project_dir="/mnt/usbcrypt/git/${project}.git"
    mkdir -p $project_dir
    cd $project_dir
    git init --bare
    chmod 750 $project_dir
fi
