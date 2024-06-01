#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

doIt;
unset doIt;


[ ! -f "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cmdtime" ] && git clone https://github.com/tom-auger/cmdtime ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/cmdtime
[ ! -f "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
[ ! -f "~/.zsh/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

if [ ! -f "~/.fzf" ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all
fi

# installs fnm (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | bash
# download and install Node.js
fnm use --install-if-missing 22

sudo chsh "$(id -un)" --shell "/usr/bin/zsh"
