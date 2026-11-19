local home = os.getenv("HOME")

hl.env("XDG_CONFIG_HOME", home .. "/.config")
hl.env("XDG_DATA_HOME", home .. "/.local/share")
hl.env("XDG_STATE_HOME", home .. "/.local/state")
hl.env("XDG_CACHE_HOME", home .. "/.cache")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
