# common
alias open='xdg-open $@ 2> /dev/null'
alias ssh='ssh -Y -A'

# vi
alias vi='gvim -v'
alias vim='gvim -v'

# emacs
alias e='emacsclient -a= -t -c'
alias ew='emacsclient -a= -n -c'
alias se='sudo emacsclient -a= -t -c'
alias sew='sudo emacsclient -a= -n -c'

# disable C-S/C-Q permamently to avoid terminal freeze
# stty -ixon

