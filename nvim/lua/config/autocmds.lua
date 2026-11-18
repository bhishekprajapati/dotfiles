-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.g.autoformat = true

-- Picker (snacks.nvim) border colors. Re-applied on every colorscheme change
-- so the theme doesn't overwrite them.
local function picker_borders()
  -- Blend the theme's foreground into its background so the border is a
  -- subtle tint of whatever colorscheme is active.
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local fg, bg = normal.fg or 0xe6edf3, normal.bg or 0x0d1117
  local amount = 0.1 -- 0 = invisible, 1 = same as text
  local function channel(shift)
    local f, b = bit.band(bit.rshift(fg, shift), 0xff), bit.band(bit.rshift(bg, shift), 0xff)
    return math.floor(b + (f - b) * amount + 0.5)
  end
  local color = string.format("#%02x%02x%02x", channel(16), channel(8), channel(0))

  local groups = {
    "SnacksPickerBorder", "SnacksPickerBoxBorder", "SnacksPickerInputBorder",
    "SnacksPickerListBorder", "SnacksPickerPreviewBorder",
  }
  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { fg = color, bg = "none" })
  end
end
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("picker_borders", { clear = true }),
  callback = picker_borders,
})
picker_borders()

-- Let kitty's background show through: kitty only renders a cell
-- transparent when its bg matches kitty's own default background exactly,
-- so any colorscheme's explicit Normal bg defeats background_opacity.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("transparent_bg", { clear = true }),
  callback = function()
    local groups = {
      "Normal", "NormalNC", "NormalFloat", "FloatBorder",
      "SignColumn", "EndOfBuffer", "MsgArea",
      "TelescopeNormal", "TelescopeBorder",
      "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})
