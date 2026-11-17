hl.on("hyprland.start", function()
  local function stagger()
    local at = 150
    return function()
      local value = at
      at = value + 150
      return value
    end
  end

  local time = stagger()

  local exec = function(cmd)
    hl.timer(function()
      hl.exec_cmd(cmd)
    end, {
      timeout = time(),
      type = "oneshot",
    })
  end

  exec("walker --gapplication-service")
  exec(PROGRAMS.VPN)
  exec(PROGRAMS.TERMINAL)
  exec(PROGRAMS.BROWSER)
end)
