local plugins = {
  {
    repo = "https://github.com/dmtrKovalenko/fff",
    setup = function()
      vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(ev)
          local name, kind = ev.data.spec.name, ev.data.kind
          if name == "fff" and (kind == "install" or kind == "update") then
            if not ev.data.active then
              vim.cmd.packadd("fff")
            end
            require("fff.download").download_or_build_binary()
          end
        end,
      })

      vim.g.fff = {
        lazy_sync = true,
        debug = { enabled = true, show_scores = true },
      }

      vim.keymap.set("n", "  ", function()
        require("fff").find_files()
      end, { desc = "FFFind files" })
    end,
  },

  {
    repo = "https://github.com/nvim-mini/mini.icons",
    setup = function()
      require("mini.icons").setup()
    end,
  },

  {
    repo = "https://github.com/stevearc/oil.nvim",
    setup = function()
      require("oil").setup({
        columns = {
          "icon",
        },
      })
      vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", {
        desc = "Open Oil",
      })

      vim.keymap.set("n", "-", "<cmd>Oil<cr>", {
        desc = "Open parent directory",
      })
    end,
  },
}

for _, plugin in ipairs(plugins) do
  vim.pack.add({ plugin.repo })
  plugin.setup()
end
