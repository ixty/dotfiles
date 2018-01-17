# ========================================================== #
# MBH bashrc
# ========================================================== #

# ========================================================== #
# colors
# ========================================================== #
C_RST="\[\017\]\[\033[0m\]"
C_GRY="\[\033[1;30m\]"
C_RED="\[\033[31m\]"
C_GRN="\[\033[32m\]"
C_YLW="\[\033[33m\]"
C_BLU="\[\033[34m\]"
C_MAG="\[\033[35m\]"
C_CYN="\[\033[36m\]"
C_WHT="\[\033[37m\]"

# ========================================================== #
# get a color based on hostname + username
# ========================================================== #
PCOLS=($C_BLU $C_RED $C_CYN $C_YLW $C_MAG $C_GRN $C_WHT)
PCOLH=$(echo $USER@$(hostname) | sha1sum | cut -d" " -f1)
PCOLI=$(expr $((16#$PCOLH)) % 7)
C_COL=${PCOLS[$PCOLI]}


# ========================================================== #
# my prompt - color based on user/host - errno
# ========================================================== #
C_POK="${C_GRY}>${C_RST}"
C_PNO="${C_RED}>${C_RST}"
C_PRM="if [ \$? = 0 ]; then echo \"${C_POK}\"; else echo \"${C_PNO}\"; fi"
PS1="${C_RST}${C_GRY}(${C_RST}\u${C_COL}~${C_RST}\H${C_GRY})${C_RST} \w \`${C_PRM}\` "
# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'


# ========================================================== #
# aliases
# ========================================================== #
export lopts='--color=auto'
eval "`dircolors`"
alias ls='ls $lopts'
alias ll='ls $lopts -l'
alias lla='ls $lopts -la'
alias lh='ls $lopts -lh'
alias la='ls $lopts -la'
alias grep='grep --color'
alias less='less -r'
alias ggg='gdb -ex=r --args'
alias hexsort="tr [a-f] [A-F] | awk ' { printf "%80s\n",$1 } ' | sort | awk ' { print $1 } ' "
alias webshare='python -m SimpleHTTPServer 8080'
alias splitwords="tr -s '[[:punct:][:space:]]' '\n'"
alias tolower="tr '[:upper:]' '[:lower:]'"
alias ownmbh="chown -R mbh: ~mbh"

alias monon='ifconfig wlan0 down; iwconfig wlan0 mode monitor; ifconfig wlan0 up'
alias monoff='ifconfig wlan0 down; iwconfig wlan0 mode managed; ifconfig wlan0 up'
alias masquerade='iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE'
alias cowsay='/usr/games/cowsay'
alias paraget='xargs -n 1 -P 8 wget -q'
alias json_pp='python -m json.tool'
alias vba='source venv/bin/activate'
alias pdfcompress='convert -density 144 -compress jpeg -quality 30'

wmon() {
    ifconfig $1 down
    iwconfig $1 mode monitor
    ifconfig $1 up
    iwconfig $1 channel 1
}

# ========================================================== #
# env
# ========================================================== #
shopt -s histappend
tabs 4


# ========================================================== #
# env
# ========================================================== #
export EDITOR=nano
export SHELL=bash
export CFLAGS="-fdiagnostics-color=auto -Wno-missing-field-initializers -D_NO_ACQ_SECURITY"
export CXXFLAGS="-fdiagnostics-color=auto -Wno-missing-field-initializers -D_NO_ACQ_SECURITY"


# ========================================================== #
# pager
# ========================================================== #
export PAGER='less -R'
export LESS='-R'
#export LESSOPEN='|~/.lessfilter %s'
export LESS_TERMCAP_mb=$'\e[01;31m'                 # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;12m'            # begin bold
export LESS_TERMCAP_me=$'\e[0m'                     # end mode
export LESS_TERMCAP_so=$'\e[30m\e[42m'              # begin standout-mode - info box
export LESS_TERMCAP_se=$'\e[0m'                     # end standout-mode
export LESS_TERMCAP_us=$'\e[04;38;5;6m'             # begin underline
export LESS_TERMCAP_ue=$'\e[0m'                     # end underline



# ========================================================== #
# notes
# ========================================================== #
# mount -t vboxsf vmshare /path/vmshare
# ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no
# socat - UDP-DATAGRAM:255.255.255.255:24000,broadcast
# route add -net 172.16.0.0 netmask 255.240.0.0 gw 172.23.101.254 dev
# alias tvid='mpv --vo tct'
# alias systemd_unfuck="mount -o remount,ro / && fsck -f -y /dev/mapper/... && fsck -f -y /boot"


# ========================================================== #
# auto load ssh agent
# ========================================================== #
SSH_ENV=$HOME/.ssh/environment
function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add

# ========================================================== #
# add ssh keys
# ========================================================== #
#    ssh-add ~/.ssh/id_github
#    ssh-add ~/.ssh/id_xxx
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -efp ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi


