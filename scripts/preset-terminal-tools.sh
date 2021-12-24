#!/bin/bash
source "$GITHUB_WORKSPACE/scripts/clone-repo.sh"

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "CONFIG_PACKAGE_zsh=y" >> $OPENWRTROOT/.config


mkdir -p $OPENWRTROOT/dl/zsh

pushd $OPENWRTROOT/dl/zsh

## Install oh-my-zsh
# Clone oh-my-zsh repository
gitClone https://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh

# Install extra plugins
gitClone https://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions
gitClone https://github.com/zsh-users/zsh-syntax-highlighting.git ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
gitClone https://github.com/zsh-users/zsh-completions ./.oh-my-zsh/custom/plugins/zsh-completions

# Get .zshrc dotfile
cp $SCRIPT_DIR/.zshrc .
popd

cp -Rf $OPENWRTROOT/dl/zsh files/root

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' $OPENWRTROOT/package/base-files/files/etc/passwd
