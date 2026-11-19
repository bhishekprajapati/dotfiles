local schemes = {
  {
    repo = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    setup = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
    end,
  },
}

for _, scheme in ipairs(schemes) do
  vim.pack.add({ scheme.repo })
  local setup = scheme.setup

  if setup then
    setup()
  end

  vim.cmd.colorscheme("catppuccin")
end
