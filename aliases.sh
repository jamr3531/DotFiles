alias tc='termux-clipboard-set'
alias tp='termux-clipboard-get'
alias to='t-open'
function t-open {
  if [[ "$#" -lt 1 ]]; then
  # no arguments, use view as default.
  termux-share -a view "$@"
  if [[ "$1" = "-e" ]]; then
  # first arg is "-e" so edit.
  termux-share -a edit "$@"
  if [[ "$1" = "-s" ]]; then
  # first arg is "-s" so send.
  termux-share -a send "$@"
  fi
  fi
  fi
}
