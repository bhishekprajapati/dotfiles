---@param keys string[] ordered: modifiers first, final key last
---@param dispatcher function | HL.Dispatcher
---@param opts HL.BindOptions?
---@param to string? string leader prefix to use instead of LEADER_KEY
local function bind(keys, dispatcher, opts, to)
  local sep = " + "
  local leader = to or LEADER_KEY
  local rest = table.concat(keys, sep)
  local isRestEmpty = rest == ""

  if isRestEmpty then
    sep = ""
  end

  hl.bind(table.concat({ leader, rest }, sep), dispatcher, opts)
end

do -- CMD Key Binds
  bind({ KEYS.T }, hl.dsp.exec_cmd(PROGRAMS.TERMINAL))
  bind({ KEYS.E }, hl.dsp.exec_cmd(PROGRAMS.FILE_MANAGER))
  bind({ KEYS.SPACE }, hl.dsp.exec_cmd(PROGRAMS.MENU))
  bind({ KEYS.M }, hl.dsp.exec_cmd(CMD.HYPRLAND.SHUTDOWN))

  bind({}, hl.dsp.exec_cmd("playerctl next"), {
    locked = true,
  }, KEYS.XF86_AUDIO_NEXT)

  bind({}, hl.dsp.exec_cmd("playerctl play-pause"), {
    locked = true,
  }, KEYS.XF86_AUDIO_PAUSE)

  bind({}, hl.dsp.exec_cmd("playerctl play-pause"), {
    locked = true,
  }, KEYS.XF86_AUDIO_PLAY)

  bind({}, hl.dsp.exec_cmd("playerctl previous"), {
    locked = true,
  }, KEYS.XF86_AUDIO_PREV)

  bind({}, hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_AUDIO_RAISE_VOLUME)

  bind({}, hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_AUDIO_LOWER_VOLUME)

  bind({}, hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_AUDIO_MUTE)

  bind({}, hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_AUDIO_MIC_MUTE)

  bind({}, hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_MON_BRIGHTNESS_UP)

  bind({}, hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), {
    locked = true,
    repeating = true,
  }, KEYS.XF86_MON_BRIGHTNESS_DOWN)
end

do -- Window Key Binds
  bind({ KEYS.P }, hl.dsp.window.pseudo())
  bind({ KEYS.Q }, hl.dsp.window.close())
  bind({ KEYS.MOUSE_LEFT }, hl.dsp.window.drag(), { mouse = true })
  bind({ KEYS.MOUSE_RIGHT }, hl.dsp.window.resize(), { mouse = true })
end

do -- Layout Key Binds
  bind({ KEYS.J }, hl.dsp.layout("togglesplit"))
  bind({ KEYS.V }, hl.dsp.window.float({ action = "toggle" }))
end

do -- Focus Key Binds
  bind({ KEYS.H }, hl.dsp.focus({ direction = DIRECTION.LEFT }))
  bind({ KEYS.J }, hl.dsp.focus({ direction = DIRECTION.DOWN }))
  bind({ KEYS.K }, hl.dsp.focus({ direction = DIRECTION.UP }))
  bind({ KEYS.L }, hl.dsp.focus({ direction = DIRECTION.RIGHT }))

  -- Switch workspaces with mainMod + [0-9]
  -- Move active window to a workspace with mainMod + SHIFT + [0-9]
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0

    hl.bind(
      LEADER_KEY .. " + " .. key,
      hl.dsp.focus({
        workspace = i,
      })
    )

    hl.bind(
      LEADER_KEY .. " + SHIFT + " .. key,
      hl.dsp.window.move({
        workspace = i,
      })
    )
  end
end

do -- Scratchpad Key Binds
  bind({ KEYS.S }, hl.dsp.workspace.toggle_special("magic"))
  bind(
    { KEYS.SHIFT, KEYS.S },
    hl.dsp.window.move({ workspace = "special:magic" })
  )
end
