-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

vim.g.lazyvim_prettier_needs_config = true
vim.g.snacks_animate = false

vim.lsp.config("rust-analyzer", {
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true,
        ignored = {
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
})

-- vim.o.winborder = "rounded"

-- ── Editor-style look (makeover) ───────────────────────────────────────
vim.opt.showtabline = 2 -- tabs always visible
vim.opt.laststatus = 3 -- one global statusline
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"
vim.opt.mousemoveevent = true -- hover effects on tabs
vim.opt.pumheight = 12
vim.opt.scrolloff = 6
vim.opt.title = true
vim.opt.titlestring = "%t — nvim"
vim.opt.fillchars:append({ eob = " ", vert = "│", horiz = "─", diff = "╱" })
