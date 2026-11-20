return DefineLoaderSpec({
  "https://github.com/nvim-mini/mini.icons",
  name = "mini-icons",
  setup = function()
    require("mini.icons").setup()
  end,
})
