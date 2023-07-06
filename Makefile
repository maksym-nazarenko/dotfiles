
ROOT_DIR := ${CURDIR}
INSTALL_SYMLINK := ln -sf


configure/brew:
	brew bundle
.PHONY: configure/brew

configure/vscode:
	mkdir -p $$HOME/Library/Application\ Support/Code/User/snippets
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/settings.json $$HOME/Library/Application\ Support/Code/User/settings.json
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/keybindings.json $$HOME/Library/Application\ Support/Code/User/keybindings.json
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/snippets/go.json $$HOME/Library/Application\ Support/Code/User/snippets/go.json
	code --install-extension \
		eamodio.gitlens \
		golang.go \
		hashicorp.terraform \
		IBM.output-colorizer \
		redhat.vscode-yaml \
		ryu1kn.partial-diff
.PHONY: configure/vscode

configure/vim:
	mkdir -p $$HOME/.config
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vim/nvim $$HOME/.config/nvim
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vim/vimrc $$HOME/.vimrc

configure/git: configure/gpg
	$(INSTALL_SYMLINK) $(ROOT_DIR)/.gitconfig $$HOME/.gitconfig
	$(INSTALL_SYMLINK) $(ROOT_DIR)/git/config.d $$HOME/.gitconfig.d
	$(INSTALL_SYMLINK) $(ROOT_DIR)/git/scripts $$HOME/.gitconfig.scripts
.PHONY: configure/git

configure/bash:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile $$HOME/.profile
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile.d $$HOME/.profile.d
.PHONY: configure/bash

configure/zsh: configure/fonts
	$(INSTALL_SYMLINK) $(ROOT_DIR)/zsh/.zshrc $$HOME/.zshrc
	$(INSTALL_SYMLINK) $(ROOT_DIR)/zsh/.zshrc.d $$HOME/.zshrc.d
	$(INSTALL_SYMLINK) $(ROOT_DIR)/zsh/.zsh $$HOME/.zsh
	curl -tlsv1.2 -o $$HOME/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -tlsv1.2 -o $$HOME/.zsh/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
	curl -tlsv1.2 -o $$HOME/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	/usr/local/opt/fzf/install --key-bindings --completion --no-update-rc
.PHONY: configure/zsh

configure/fonts:
	@mkdir $$HOME/.fonts
	@curl https://github.com/powerline/fonts/raw/master/DroidSansMono/Droid%20Sans%20Mono%20for%20Powerline.otf -o $$HOME/.fonts/DroidSansMono_Powerline.otf

configure/fish: configure/fonts
	@mkdir -p $$HOME/.config/fish/conf.d
	@git clone https://github.com/oh-my-fish/oh-my-fish $$HOME/.oh-my-fish
	@$$HOME/.oh-my-fish/bin/install --offline
	@omf install bobthefish
	$(INSTALL_SYMLINK) $(ROOT_DIR)/fish/maks.fish $$HOME/.config/fish/conf.d/maks.fish
.PHONY: configure/fish

configure/powerline:
	pip3 install --user powerline-status

	mkdir -p $$HOME/.config/powerline
	$(INSTALL_SYMLINK) $(ROOT_DIR)/powerline/themes $$HOME/.config/powerline/themes

configure/tmux: configure/powerline
	$(INSTALL_SYMLINK) $(ROOT_DIR)/tmux.conf $$HOME/.tmux.conf
.PHONY: configure/tmux

configure/gpg:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/gpg/gpg-agent.conf $$HOME/.gnupg/gpg-agent.conf
.PHONY: configure/gpg

configure: configure/brew configure/git configure/bash configure/zsh configure/vscode
.PHONY: configure
