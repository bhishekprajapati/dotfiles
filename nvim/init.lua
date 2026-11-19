require("globals")
require("options")
require("keybinds")

require("utils").loader(
  vim.fn.stdpath("config") .. "/lua/autocmds",
  function(filename)
    return "autocmds." .. filename
  end,
  {
    load_only = true,
  }
)

require("utils").loader(
  vim.fn.stdpath("config") .. "/lua/colorschemes",
  function(filename)
    return "colorschemes." .. filename
  end
)

require("utils").loader(
  vim.fn.stdpath("config") .. "/lua/plugins",
  function(filename)
    return "plugins." .. filename
  end
)

vim.cmd.colorscheme("catppuccin")
