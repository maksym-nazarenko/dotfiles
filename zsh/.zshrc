
if [ -r ~/.zsh/git-completion.bash ]; then
    zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
    fpath=(~/.zsh $fpath)
    autoload -Uz compinit && compinit
fi

if [ -r ~/.zsh/git-prompt.sh ]; then
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    source ~/.zsh/git-prompt.sh
    export RPROMPT='%*'
    setopt PROMPT_SUBST
    export PS1='%F{yellow}%~%f$(__git_ps1 " [%s]") '
fi
