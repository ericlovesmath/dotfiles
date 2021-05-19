#echo "NAME: $USER 
#DATE: $(date)
#
#$(fortune -s)
#"

ZSH_THEME="powerlevel10k/powerlevel10k"

#plugins=(git)

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#export PATH=/usr/local/opt/python/libexec/bin:$PATH

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# conda initialize: disabled <<<

#export PATH=/usr/local/anaconda3/bin:$PATH
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('~/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "~/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "~/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="~/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup

# conda initialize >>>

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

. ~/.zsh_aliases
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
