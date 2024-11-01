# Trans rights

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export EDITOR="nvim"
source $HOME/.cargo/env
export PATH="/Users/ericlee/.cargo/bin:$PATH"

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

PROMPT_EOL_MARK=''

# opam configuration
[[ ! -r /Users/ericlee/.opam/opam-init/init.zsh ]] || source /Users/ericlee/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


# Aliases

alias c='clear'
alias lt='du -sh * | sort -hr'
alias ls='ls -N --group-directories-first --color=auto'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias vd='deactivate'
alias restartaudio='sudo killall coreaudiod'
alias restartlogi='pkill LogiVCCoreService; pkill LogiMgrDaemon'
alias zrc='nvim ~/.zshrc -c "e ~/.zsh_aliases" -c "bp"; exec zsh'
alias randint='jot -r 1 $1 $2'
alias py='python'
alias {python,py3}='python3'
alias vrc='cd ~/.config/nvim'
alias ..='cd ./..'
alias ...='cd ./../..'
alias ....='cd ./../../..'
alias {:q,:q!,:wq,:wq!,:Q}='exit'
alias dots='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sus='function _sus(){echo " 　.　　。　　　　•　 　ﾟ　　。 　　.\n　　　.　　　 　　.　　　　　。　　 。　.\n.　　 。　　　　　 ඞ 。 . 　　 • 　　　　•\n　　ﾟ　　 $1 was not An Impostor.　 。　.\n　　'"'"'　　　 1 Impostor remains 　 　　。\n　　ﾟ　　　.　　　. ,　　　　.　 ."};_sus'
alias matlab='/Applications/MATLAB_R2024a.app/bin/matlab -nodisplay -nosplash'
alias s='ls'
alias {help,duck}='open https://i.redd.it/zgdnh7q9u9t41.jpg'
alias duck2='open https://i.kym-cdn.com/photos/images/original/002/429/796/96c.gif'
alias aseprite='nohup /Applications/aseprite/build/bin/aseprite > /dev/null 2>&1&'
alias gh="open \`git remote -v | grep fetch | awk '{print \$2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'\`| head -n1"
alias o='open .'
alias yt-best='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias yt-best-audio='yt-dlp -f "ba" -x --audio-format mp3'
alias journal='cd ~/Desktop/Recreation/2023-journal && nvim ~/Desktop/Recreation/2023-journal/journal.md +"norm G" +ZenMode'
alias food="open 'https://caltechdining.my.canva.site/browne-comfort-equation' 'https://caltechdining.my.canva.site/plant-based-station' 'https://caltechdining.my.canva.site/week-meal-plan-menu'"
alias ff="open -a firefox"
alias {owo,uwu}='echo -e "⣿⣿⣿⣿⣿⣿⣿⣿⣿⢫⣟⡛⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⢋⣭⣭⣭⣭⣭⣉⣙⣻⡆⠻⣿⣿⣮⣻⠿⢟⣛⣋⣭⣭⣭⣿⣿
⡸⣿⣿⣿⣿⣿⣿⣯⣴⣿⣭⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣿
⣷⡹⣿⣿⣿⣿⢛⣛⠻⣿⣿⣿⣿⢛⣛⡻⣿⣿⣿⣿⣿⠟⣼⣿
⣿⢿⣮⡻⢿⢣⣿⢣⣶⢹⣿⣿⣿⢱⣦⢻⣌⢿⡿⠿⠣⣾⣿⣿
⣿⣆⠲⣮⣿⢸⣿⡜⠏⣾⣿⣿⣿⣎⠟⣼⣿⢸⣾⠟⣡⣿⣿⣿
⣿⣿⣿⢸⣫⠙⣿⣿⣿⣷⠶⠿⢿⣿⣿⣏⣉⣩⣧⡘⣿⣿⣿⣿
⣿⣿⣏⣛⣯⣛⠿⢿⣿⣷⣮⠻⢾⣿⢿⠿⣋⣭⣿⣭⣼⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣧⡐⢶⣾⣿⣿⣿⣿⣶⡹⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⡿⠡⢻⣿⣿⣿⣿⣿⣿⣷⢹⣿⣿⣿⣿⣿⣿⣿"'

pset() { $HOME/bin/latex-template/generate_set.py "$@" | pbcopy }
timezsh() { repeat 10 { time zsh -i -c exit } }
0x0() { curl -F "file=@$1" https://0x0.st }

hash -d usaco=$HOME/Desktop/Programming/competitive-programming
hash -d rust=$HOME/Desktop/Programming/rust
hash -d portfolio=$HOME/Desktop/Programming/portfolio-eric-lee
hash -d leetcode=$HOME/Desktop/Programming/leetcode
hash -d tutor=$HOME/Desktop/Academics/Tutoring
hash -d caltech=$HOME/Desktop/Academics/Caltech/junior/fall-2024
hash -d visuals=$HOME/Desktop/Programming/generative-art/src
hash -d firefox="$HOME/Library/Application Support/Firefox/Profiles/wwpdd487.default-release"
hash -d surf=$HOME/Desktop/Academics/Caltech/sophmore/SURF
hash -d jane="$HOME/Desktop/Important/Jane Street"

alias chem="osascript -e 'mount volume \"smb://reismangroup@files.stoltz.caltech.edu\"' && cd ~reisman"
alias unchem="cd $HOME && umount ~reisman"
hash -d reisman="/Volumes/Reisman Group Server"
