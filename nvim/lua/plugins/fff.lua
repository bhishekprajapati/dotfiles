return {
  "https://github.com/dmtrKovalenko/fff",
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
    end, { desc = "Find files" })
  end,
}
