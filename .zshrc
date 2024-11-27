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

PROMPT_EOL_MARK=''

# Aliases

alias c='clear'
alias lt='du -sh * | sort -hr'
alias ls='ls -N --group-directories-first --color=auto'
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'
alias vd='deactivate'
alias restartaudio='sudo killall coreaudiod'
alias restartlogi='pkill LogiVCCoreService; pkill LogiMgrDaemon'
alias randint='jot -r 1 $1 $2'
alias py='python'
alias {python,py3}='python3'
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
alias food="open 'https://caltechdining.my.canva.site/browne-comfort-equation' 'https://caltechdining.my.canva.site/plant-based-station' 'https://caltechdining.my.canva.site/mealplanmenu'"
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
