# neovim
alias nv = /opt/nvim-linux-x86_64/bin/nvim

# alias = sudo docker compose
alias compose = sudo docker compose

# clear
alias clc = clear

# git aliases
alias gta = git add
alias gtc = git commit
alias gtac = git add . and git commit -m
alias gts = git status
alias gtss = git status -s

# system aliases
alias clc = clear

# applications
# alias air = ~/.air
alias cursor = ~/.local/cursor.app/Cursor-0.49.6-x86_64.AppImage

# utilities
alias bat = batcat
alias z = zoxide

# some more ls aliases
alias ll = lsd -l
alias la = lsd -A
alias l = lsd


def cmdsearch [
  --no-copy (-n) #if set, pipe to clipboard
] {
  let result = history | get command | to text | fzf 
  if ($no_copy) {
      $result
  } else {
      $result | xclip -selection clipboard
    }
}

alias ctc = xclip -selection clipboard

# tmux aliases

# generate tmux session name based on absolute path
def txsn [dir: string] {
  let dir = $dir | path expand
  let name = $dir | path basename
  let path_hash = ($dir | hash sha256 | str substring 0..7)
  let name = $"($name)_($path_hash)"
  $name 
}

# delete tmux session
def txk [name: string] {
  tmux kill-session -t $name
}

# get tmux sessions list
def txsl [] {
  tmux ls  | lines | parse '{name}:{rest}' | get name
}

# kill all tmux sessions
def txka [] {
  txsl | each { |name| tmux kill-session -t $name }
}

# check is tmux session exists
def txcs [name: string] {
  not (txsl | where { |s| $s == $name } | is-empty)
}

# list tmux session
alias txls = tmux ls

# tmux reload config
alias txr = tmux source-file ~/.tmux.conf

# project aliases
# open project
alias project = nu ~/.config/nushell/scripts/create_project.nu


# git add
alias ga = git add

# git status
alias gs = git status

# git status short
alias gss = git status -s

# git commit -m
alias gcm = git commit -m

# git push
alias gp = git push

# git commit and push
def gcap [
  message: string # commit message
] {
   git commit -m $message; git push
}

# git diff
def gfdiff [] {
  let path = gss | lines | split column -c " " | get column2 | to text | fzf
  git diff $path
}

# leetcode alias
alias lc = leetcode

# sea orm
alias soc = sea-orm-cli
