local skip = { lua_ls = true }

local preferred = { "oxfmt" }

local function can_format(client)
  return not skip[client.name]
    and client:supports_method("textDocument/formatting")
end

local cli = {
  nu = { "nufmt", "--stdin" },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("CliFormatOnSave", { clear = true }),
  callback = function(args)
    local cmd = cli[vim.bo[args.buf].filetype]

    if not cmd or vim.fn.executable(cmd[1]) ~= 1 then
      return
    end

    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local res = vim
      .system(cmd, {
        cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
        stdin = table.concat(lines, "\n") .. "\n",
        text = true,
      })
      :wait(3000)

    if res.code ~= 0 then
      vim.notify(
        cmd[1] .. ": " .. vim.trim(res.stderr or ""),
        vim.log.levels.WARN
      )
      return
    end

    local formatted = vim.split(res.stdout, "\n", { trimempty = false })
    if formatted[#formatted] == "" then
      table.remove(formatted)
    end

    if not vim.deep_equal(lines, formatted) then
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, formatted)
      vim.fn.winrestview(view)
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),

  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if not client or not can_format(client) then
      return
    end

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup(
        "LspFormatOnSave_" .. args.buf,
        { clear = true }
      ),
      buffer = args.buf,
      callback = function()
        local only
        for _, name in ipairs(preferred) do
          only = vim.lsp.get_clients({ bufnr = args.buf, name = name })[1]
          if only then
            break
          end
        end

        vim.lsp.buf.format({
          bufnr = args.buf,
          async = false,
          timeout_ms = 3000,
          filter = function(c)
            if only then
              return c.id == only.id
            end
            return can_format(c)
          end,
        })
      end,
    })
  end,
})
