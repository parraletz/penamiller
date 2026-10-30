# Source this file to append the Penamiller colors without discarding other fzf options.
export FZF_PENAMILLER_OPTS='
  --color=fg:#FAF9F5,bg:#141413,hl:#C05BC4
  --color=fg+:#FAF9F5,bg+:#262624,hl+:#C05BC4
  --color=info:#4A86D6,pointer:#E0A82E,marker:#6AA84F,spinner:#3EA6B8,header:#E0A82E,border:#353532'
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} $FZF_PENAMILLER_OPTS"
