source /data/data/com.termux/files/home/.local/share/pearl/boot/sh/pearl.sh

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
#HIST_STAMPS="dd/mm/yyyy"


##############source $OSH/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
#export LANG=en_GB.UTF-8

export COLORTERM='24bit'
export MICRO_TRUECOLOR='1'

export SD='/storage/426E-0D1D'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
  export VISUAL='micro'
else
  export EDITOR='micro'
  export VISUAL='micro'
fi

# Compilation flags
#export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY="~/.ssh/rsa_id"


# source my functions from:  functions.sh
#funcs=($OSH/functions/functions.sh $funcs)
######source $funcs
# edit them
#alias efuncs="$EDITOR $funcs"

# some colour
#source ~/scripts/colours

GPG_TTY=$(tty)
export GPG_TTY

# goto
source '/data/data/com.termux/files/home/.local/bin/goto'

source '/data/data/com.termux/files/home/omb/aliases/alias_source.sh'

source '/data/data/com.termux/files/home/omb/lib/libinstall.sh'

source '/data/data/com.termux/files/home/functions.sh'

source '/data/data/com.termux/files/home/.local/bin/bashmarks'



# bd (BackDirectory).
alias bd=". bd -si"

# set options for less:
# the short version.
export LESS='-F -i -J -M -R -W -x2 -X -z-2'
# the long version, for readability.
# export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=2 --no-init --window=-2'

#source '~/.commacd.sh'


alias cdir='source cdir.sh'

export FZF_MARKS_KEEP_ORDER=1
source '/data/data/com.termux/files/home/.local/source/fzmarks.bash'


source /data/data/com.termux/files/home/.local/share/icons-in-terminal/icons_bash.sh

source /data/data/com.termux/files/home/.local/lib/composure.sh

#source /data/data/com.termux/files/home/forgit.plugin.sh

alias b='buku --suggest'

export PLAINTEXT_PLAYLIST_MUSIC_DIR=/data/data/com.termux/files/home/music

source /data/data/com.termux/files/home/.local/bin/bashyml

source /data/data/com.termux/files/home/.dotbare/dotbare.plugin.bash
alias dotbare="/data/data/com.termux/files/home/.dotbare/dotbare"

alias deadman='deadman /data/data/com.termux/files/home/.config/deadman.conf'

export BARGS_VARS_PATH='/data/data/com.termux/files/home/.bargs_vars.bash'

#source <(emplace init bash)
#source <(navi widget bash)


export DOTBARE_DIR=/data/data/com.termux/files/home/DotFiles
