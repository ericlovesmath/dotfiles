# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Trans rights

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
ZSH_THEME="powerlevel10k/powerlevel10k"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
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
setopt incappendhistory
setopt extendedglob local_options
setopt completealiases

autoload -Uz promptinit && promptinit

# ZSH Autocomplete, check only once a day
autoload -Uz compinit
() {
  if [[ $# -gt 0 ]]; then
    compinit
  else
    compinit -C
  fi
} ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

zstyle ':completion:*' list-colors '${(@s.:.)LS_COLORS}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# caching completion
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*'            use-cache yes
zstyle ':completion::complete:*'  cache-path ~/

# Exports for various programs
source $HOME/.cargo/env
export EDITOR="nvim"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
PATH="/Users/ericlee/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/ericlee/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/ericlee/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/ericlee/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ericlee/perl5"; export PERL_MM_OPT;
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/ericlee/.cargo/bin:$PATH"
export PATH="/Users/ericlee/.ghc/bin:$PATH"
export PATH="/Users/ericlee/.ghcup/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PROMPT_EOL_MARK=''
source $HOME/.zsh_aliases

# opam configuration
[[ ! -r /Users/ericlee/.opam/opam-init/init.zsh ]] || source /Users/ericlee/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# >>> conda initialize >>>
condainit() { 
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
}
# <<< conda initialize <<<
