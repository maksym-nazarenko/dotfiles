if [ -r ~/.zsh/git-completion.bash ]; then
    zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
    fpath=(~/.zsh $fpath)
    # autoload -Uz compinit && compinit
fi

if [ -r ~/.zsh/git-prompt.sh ]; then
    source ~/.zsh/git-prompt.sh
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export RPROMPT='%*'
    setopt PROMPT_SUBST
    export PS1='%F{yellow}%3~%f$(__git_ps1 " [%s]") '$'\n> '
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# activate completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

/usr/bin/which -s aws_completer && complete -C $(which aws_completer) aws

[ -d ~/.zshrc.d ] && source ~/.zshrc.d/*

[ -r ~/.zshrc.local ] && source ~/.zshrc.local

if [ -d "$HOME/go/bin" ]; then
    PATH="$PATH:$HOME/go/bin"
fi
