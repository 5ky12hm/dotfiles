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
CURRENT_DIRPATH=$(pwd)
DOTFILES_DIRPATH="${HOME}/.dotfiles"
if [ "${CURRENT_DIRPATH}" != "${DOTFILES_DIRPATH}" ]; then
	mv "${CURRENT_DIRPATH}" "${DOTFILES_DIRPATH}" &> /dev/null
fi
cd "${DOTFILES_DIRPATH}" || {
	echo "directory not found: ${DOTFILES_DIRPATH}. aborting..."
	exit 1
}

OS_NAME="$(uname -s)"
for f in *
do
	[ "${f}" = 'README.md' ] && continue
	[ "${f}" = 'install.sh' ] && continue
	[ "${f}" = 'uninstall.sh' ] && continue
	[ "${f}" = 'LICENSE' ] && continue

	# transition to neovim
	[ "${f}" = 'vim' ] && continue

	case "${OS_NAME}" in
		Darwin)
			[ "${f}" = 'colima' ] && continue
			;;
	esac

	stow -v --target="${HOME}" --no-folding "${f}"
done

if hash brew > /dev/null 2>&1; then
	DOCKER_PLUGIN_DIR="${HOME}/.docker/cli-plugins"
	mkdir -p "${DOCKER_PLUGIN_DIR}"
	ln -sfn "$(brew --prefix)/opt/docker-compose/bin/docker-compose" "${DOCKER_PLUGIN_DIR}/docker-compose"
fi

echo 'dotfiles installation has been completed !'
