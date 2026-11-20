return DefineLoaderSpec({
  "https://github.com/stevearc/oil.nvim",
  name = "oil",
  setup = function()
    require("oil").setup({
      columns = {
        "icon",
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil" })
  end,
})
