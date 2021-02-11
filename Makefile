
ROOT_DIR := ${CURDIR}
INSTALL_SYMLINK := ln -sf


configure/brew:
	brew bundle
.PHONY: configure/brew

configure/vscode:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/vscode/settings.json $$HOME/Library/Application\ Support/Code/User/settings.json
	code --install-extension \
		aws-scripting-guy.cform \
		eamodio.gitlens \
		golang.go \
		hashicorp.terraform \
		IBM.output-colorizer \
		ivory-lab.jenkinsfile-support \
		k--kato.intellij-idea-keybindings \
		marcostazi.VS-code-vagrantfile \
		ms-azuretools.vscode-docker \
		redhat.vscode-yaml \
		ryu1kn.partial-diff \
		wholroyd.HCL \
		wholroyd.jinja

.PHONY: configure/vscode

configure/git:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/.gitconfig $$HOME/.gitconfig
.PHONY: configure/git

configure/bash:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile $$HOME/.profile
	$(INSTALL_SYMLINK) $(ROOT_DIR)/bash/.profile.d $$HOME/.profile.d
.PHONY: configure/bash

configure/fish:
	$(INSTALL_SYMLINK) $(ROOT_DIR)/fish/maks.fish $$HOME/.config/fish/conf.d/maks.fish
.PHONY: configure/fish

configure: configure/brew configure/bash configure/fish configure/git configure/vscode
.PHONY: configure
