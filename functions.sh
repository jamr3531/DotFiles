# convert hex colour codes to 256color codes for use in the terminal.
# usage: 'fromhex A52A2A'
#    or:  fromhex "#A52A2A"
#    or:  BLUE_VIOLET=$(fromhex "#8A2BE2")
# http://unix.stackexchange.com/a/269085/67282
function fromhex {
  hex=$1
  if [[ $hex == "#"* ]]; then
    hex=$(echo $1 | awk '{print substr($0,2)}')
  fi
  r=$(printf '0x%0.2s' "$hex")
  g=$(printf '0x%0.2s' ${hex#??})
  b=$(printf '0x%0.2s' ${hex#????})
  echo -e `printf "%03d" "$(((r<75?0:(r-35)/40)*6*6+(g<75?0:(g-35)/40)*6+(b<75?0:(b-35)/40)+16))"`
}
# bookmark links to a file of your choice.
# change the value of "BOOKMARK_FILE" to whatever file you want bookmarks saved to.
function bookmark {

  BOOKMARK_FILE='/data/data/com.termux/files/home/bm.md'
  BOOKMARK_URL="[$1]"
  BOOKMARK_TITLE="($2)"
  BM_TAGS="${@: 3}"

  echo -e "$BOOKMARK_TITLE\$BOOKMARK_URL\n" >> $BOOKMARK_FILE
    for i in $BM_TAGS; do
      echo "- $i"
    done
unset i
}

# stream a song from youtube with 'youtube-dl' in 'mpv'.
#listen-to-yt(){ if [[ -z "$1" ]]; then echo "Enter a search string!"; else mpv "$(youtube-dl --default-search 'ytsearch1:' \"$1\" --get-url | tail -1)"; fi }
function yt-song {
  if [[ -z "$1" ]]; then
    echo "Enter a search string!"
  else
    mpv "$(youtube-dl --default-search 'ytsearch1:' \"$1\" --get-url | tail -1)"
  fi
}
#### make a playlist option ^^^
#### make a song option:
# stream a spotify playlist with 'spotdl' and 'mpv' (uses: 'youtube-dl' also)
function spotify-playlist {
  if [[ -z "$1" ]]; then
    echo "This function streams a Spotify playlist,"
    echo "Please enter a Spotify playlist URL"
  else
    spotdl -p "$1" --write-to - | spotdl -s - -f - | mpv - --no-video
  fi
}
function write-playlist {
  spotdl -p "$1" --write-to "$2"
  spotdl -l "$2" --write-m3u
}

function file-with-shebang {
  FILE="$1"
  SHEBANG='#!/data/data/com.termux/files/usr/bin/env bash'

  if [[ -f "$FILE" ]]; then
    echo "$FILE exists."
  else
    touch "$FILE"
    echo "$SHEBANG" > "$FILE"
    $EDITOR "$FILE"
  fi
  
  unset FILE
  unset SHEBANG
}
alias script='file-with-shebang'

# list all the directories on your $PATH, sorted by length.
function show-path {
  echo -e ${PATH//:/\\n} | awk '{print length, $0}' | sort -n | cut -f2- -d' '
}

# Find and replace string inside specific files.
function find-replace {
  grep -ril '$SEARCH_PATTERN' src | sed -i 's/$FIND_PATTERN/$REPLACE_PATTERN/g'
}

# Make a new folder and cd into it.
function mc {
  NAME=$1; mkdir -pv "$NAME"; cd "$NAME"
}

# Preserve your fingers from cd ..; cd ..; cd..
function up {
  DEEP=$1; for i in $(seq 1 ${DEEP:-"1"}); do cd ../; done
}

# parse & format ip address without net tools.
function my-ip {
  cat /proc/net/tcp | grep " 0A " | sed 's/^[^:]*: \(..\)\(..\)\(..\)\(..\):\(....\).*/echo $((0x\4)).$((0x\3)).$((0x\2)).$((0x\1)):$((0x\5))/g' | bash
}

# parse m3u file for its total duration.
function play-time {
  awk -F":|," '{RS="#"; sec+=$2}END{h=(sec/3600);m=((sec/60) % 60);s=(s;printf("%02d:%02d:%02d\n", h, m, s)}' $1
}

# find a config file used by a program. 
function find-conf {
  strace -f 2>&1 $1 | grep .conf
}

# show colour codes.
function colorify {
  n=$(bc <<< "$(echo ${1}|od -An -vtu1 -w100000000|tr -d ' ') % 7"); echo -e "\e[3${n}m${1}\e[0m"
}

################################################

function scroll
{
    while read -r ; do echo "$REPLY" ; sleep ${1:-0.25} ; done
}



##### cdl: cd then ls.

function cdl() {
  cd "$@"
  ls
}

##### cda: then ls -A.

function cda() {
  cd "$@"
  ls -A
}

# the same as above but as aliases instead:

#alias cdl='cd "$@" && ls'
#alias cda='cd "$@" && ls -A'

# NOTE (I have cd set to echo the new directory)
# when these are used as a functions
# its still the same BUT...
# when used as an alias: it mutes cd's output,
# could be useful to have cd able to so both,
# silent OR output. You could uncomment the
# aliases & slightly change the names
# so they dont conflict with above, this adds
# a "silent" cd. EXAMPLE:
# the 'cdl' alias could be uncommented
# & then renamed 'cds' (cd silent) etc.

################################################

##### go up a directory
# same as: cd ..
# but IF given an argument (N)
# will go up (N) amount of times.
# EXAMPLE: up 3 = cd ../../..

function up() {
  if [ $# -eq 0 ]; then
    count=1
  else
    count="$1"
  fi
  i=0
  while [ $i -lt $count ]; do
    cd '..'
    i=$((i+1))
  done

  ls
}

################################################

##### gc: git clone. more organised.
# clone into my ~/git directory,
# once cloned, cd's into cloned directory,
# & finally, ls -a when you get there!

function gc() {
  __my_git_dir="$HOME/git"
  __repo_name=`echo "$1" | perl -nle 'm/([^\/]+(?=\.git))/; print $1'`

    git clone "$1" $__my_git_dir/$__repo_name
    cda $__my_git_dir/$__repo_name
}

##### gch: git clone here.
# for standard git clone logic i.e to the directory
# you specify ELSE current directory...

alias gch='git clone'

################################################
#####
function num() {
  if [ $# -lt 1  ]; then
    ls | wc -l
  else
    ls "$1" | wc -l
  fi
}


function aka {
  if [ $# -lt 2 ]; then
    echo "Enter two values:"
    echo "1) the alias name"
    echo "2) the command"
    echo "Note: quote any values that contain spaces"
    echo 'Example: aka la "ls -A"'
  else
    alias "$1"="$2"
  fi
}
#------------------------------------------------------

#(1) Check if $1 is a file or directory.

function file-or-directory {

local f_or_d="$1"

if [[ -f "$f_or_d" ]]; then
  echo "RESULT:"
  echo "$f_or_d is a FILE."
elif [[ -d "$f_or_d" ]]; then
  echo "RESULT:"
  echo "$f_or_d is a DIRECTORY."
else
  echo "RESULT:"
  echo "test FAILED."
fi
}

#(2) Check for number of arguments.

function arg-count {
  if [[ "$#" -lt 1 ]]; then
    echo "RESULT:"
    echo "NO arguments."
  elif [[ "$#" -eq 1 ]]; then
    echo "RESULT:"
    echo "ONE argument."
  elif [[ "$#" -eq 2 ]]; then
    echo "RESULT:"
    echo "TWO arguments."
  elif [[ "$#" -eq 3 ]]; then
    echo "RESULT:"
    echo "THREE arguments."
  fi
}

#(3) Check value of an argument.

function arg-value {
  if [[ "$#" -lt 1 ]]; then
    echo "RESULT:"
    echo "NO arguments."
  if [[ "$1" = "-a" ]]; then
    echo "RESULT:"
    echo "Argument is $1 (-a)"
  if [[ "$1" = "-b" ]]; then
    echo "RESULT:"
    echo "Argument is $1 (-b)"
  fi
  fi
  fi
}
