$env.EDITOR = "nvim"
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.history.path = $env.XDG_STATE_HOME | path join "nushell/history.txt"
$env.path = $env.PATH | append ($env.HOME |  path join ".local/bin")
