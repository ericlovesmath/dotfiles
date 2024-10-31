#!/bin/zsh

mkv_sub_getshort() {
    sub=$1
    sub="${sub%.${sub:e}}"
    sub="$(sed 's/^.*[[:punct:]]//g' <<< "$sub")"
    echo $sub
}

mkv_maker() {
    local c=0
    for i in *srt; do
        LOCAL_SUB[((++c))]="$i"
        LOCAL_SUB_SHORT[$c]="$(mkv_sub_getshort "$i")"
    done

    local W="   "
    printf "ffmpeg -i *mp4"
    printf "$(for i in ${LOCAL_SUB[*]}; do printf "${W}-i \"$i\""; done)"
    printf "$(for i in $(seq $((${#LOCAL_SUB} + 1))); do printf "${W}-map $((i - 1))"; done)"
    printf "${W}-c copy"
    printf "$(for i in $(seq ${#LOCAL_SUB}); do ((--i)); printf "${W}-metadata:s:s:$i language=${LOCAL_SUB_SHORT[$((i + 1))]%.srt}"; done)"
    printf "${W}output.mkv"

    unset LOCAL_SUB LOCAL_SUB_SHORT
}

mkv_maker
