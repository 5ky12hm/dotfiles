#!/usr/bin/env zsh

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "command not found: $1. aborting..."
        exit 1
    fi
}
check_prog stow

cd "$(dirname $0)" || {
	echo "failed to change directory. aborting..."
	exit 1
}

for f in *
do
	[ "${f}" = 'README.md' ] && continue
	[ "${f}" = 'install.sh' ] && continue
	[ "${f}" = 'uninstall.sh' ] && continue
	[ "${f}" = 'LICENSE' ] && continue

	stow -v --target "${HOME}" --delete "${f}"
done

echo 'dotfiles uninstallation has been completed !'
