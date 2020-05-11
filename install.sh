#!/bin/bash
#
# minydot
#

error()
{
    [ -n "$*" ] &&
        echo $* >&2

    exit 1
}

log_install()
{
    local to=${1}
    local permission=${2}

    echo " install    ${to}"
}

install_file()
{
    local from=${1}
    local to=${2}

    log_install ${to} ${permission}
    cp -a ${from} ${to}
}

install_dir()
{
    local from=${1}
    local to=${2}

    log_install ${to}
    cp -a ${from} ${to}
}

git_clone()
{
    local from=${1}
    local to=${2}

    echo " clone      ${to} (from: ${from})"
    git clone ${1} ${2} >/dev/null 2>&1
}

[ ! -x "$(which cp 2>/dev/null)" ] && error 'unable to locate cp'
[ ! -x "$(which git 2>/dev/null)" ] && error 'unable to locate git'

install_file bash/profile   ${HOME}/.profile
install_file bash/bashrc    ${HOME}/.bashrc
install_file tmux/tmux.conf ${HOME}/.tmux.conf
install_file vim/vimrc      ${HOME}/.vimrc
install_dir  vim/vim        ${HOME}/.vim

git_clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
