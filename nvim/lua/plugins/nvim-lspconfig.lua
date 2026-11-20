return DefineLoaderSpec({
  "https://github.com/neovim/nvim-lspconfig",
  name = "nvim-lspconfig",
  setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, args.buf, {
            autotrigger = true,
          })
        end
      end,
    })

    vim.opt.completeopt = { "menu", "menuone", "noinsert" }

    vim.lsp.enable({
      "jsonls",
      "tsc",
      "lua_ls",
      "stylua",
      "oxfmt",
      "bashls",
      "nushell",
      "rumdl",
      "taplo",
      "yamlls",
      "cssls",
      "html",
      "hyprls",
    })

    vim.keymap.set("i", "<C-Space>", function()
      vim.lsp.completion.get()
    end)
  end,
})
