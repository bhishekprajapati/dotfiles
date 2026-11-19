local group = vim.api.nvim_create_augroup("NativeTreesitter", {
  clear = true,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(e)
    local fileType = e.match
    local lang = vim.treesitter.language.get_lang(fileType)

    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(e.buf, lang)
    end
  end,
})
