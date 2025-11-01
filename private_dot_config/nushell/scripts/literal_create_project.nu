#!/usr/bin/env nu

source ~/.config/nushell/aliases.nu

def main [--dir (-d): string] {
  let dir = if $dir == () { '.' } else { $dir }
  let name = txsn $dir 
  
  let has_session: bool = (txcs $name)

   if (not $has_session) {
     tmux new-session  -d -As $name -c $dir
     tmux new-window -t $name -c $dir;
     tmux new-window -t $name -c $dir;
   }

   tmux attach-session -t $name
}
