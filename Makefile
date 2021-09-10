
ROOT_DIR := ${CURDIR}
INSTALL_SYMLINK := ln -sf


configure/brew:
	brew bundle
.PHONY: configure/brew

configure/vscode:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/settings.json $$HOME/Library/Application\ Support/Code/User/settings.json
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/keybindings.json $$HOME/Library/Application\ Support/Code/User/keybindings.json
	code --install-extension \
		eamodio.gitlens \
		golang.go \
		hashicorp.terraform \
		IBM.output-colorizer \
		k--kato.intellij-idea-keybindings \
		mongodb.mongodb-vscode \
		redhat.vscode-yaml \
		ryu1kn.partial-diff

.PHONY: configure/vscode

configure/git:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/.gitconfig $$HOME/.gitconfig
.PHONY: configure/git

configure/bash:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile $$HOME/.profile
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile.d $$HOME/.profile.d
.PHONY: configure/bash

configure/zsh:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/zsh/.zshrc $$HOME/.zshrc
	$(INSTALL_SYMLINK) $(ROOT_DIR)/zsh/.zsh $$HOME/.zsh
	curl -tlsv1.2 -o $$HOME/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -tlsv1.2 -o $$HOME/.zsh/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
	curl -tlsv1.2 -o $$HOME/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

.PHONY: configure/zsh

configure/fish:
	@mkdir $$HOME/.fonts
	@curl https://github.com/powerline/fonts/raw/master/DroidSansMono/Droid%20Sans%20Mono%20for%20Powerline.otf -o $$HOME/.fonts/DroidSansMono_Powerline.otf

	@mkdir -p $$HOME/.config/fish/conf.d
	@git clone https://github.com/oh-my-fish/oh-my-fish $$HOME/.oh-my-fish
	@$$HOME/.oh-my-fish/bin/install --offline
	@omf install bobthefish
	$(INSTALL_SYMLINK) $(ROOT_DIR)/fish/maks.fish $$HOME/.config/fish/conf.d/maks.fish
.PHONY: configure/fish

configure/tmux:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/tmux.conf $$HOME/.tmux.conf
.PHONY: configure/tmux

configure: configure/brew configure/bash configure/fish configure/git configure/vscode
.PHONY: configure
