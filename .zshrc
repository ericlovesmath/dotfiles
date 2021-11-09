# Trans rights

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Faster searching through history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt appendhistory
setopt extendedglob local_options
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

autoload -Uz promptinit && promptinit

timezsh() { repeat 10 { /usr/bin/time $SHELL -i -c exit } }

# Exports for various programs
source $HOME/.cargo/env
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
#export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"
#export PATH=/usr/local/opt/python/libexec/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PROMPT_EOL_MARK=''

source $HOME/.zsh_aliases
