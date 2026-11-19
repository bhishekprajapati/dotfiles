return {
  "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  setup = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
    })
  end,
}
