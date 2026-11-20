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

for _, dir in ipairs({ "plugins", "colorschemes" }) do
  require("utils").loader(
    vim.fn.stdpath("config") .. "/lua/" .. dir,
    function(filename)
      return dir .. "." .. filename
    end
  )
end

vim.cmd.colorscheme("catppuccin")
