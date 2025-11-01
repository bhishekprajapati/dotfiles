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
