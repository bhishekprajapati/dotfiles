---@class KeyBind
---@field modes string|string[] Mode "short-name" (see |nvim_set_keymap()|), or a list thereof.
---@field lhs string           Left-hand side |{lhs}| of the mapping.
---@field rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---@field opts? vim.keymap.set.Opts

---@type KeyBind[]
local map = {
  {
    modes = "n",
    lhs = "<leader>e",
    rhs = vim.cmd.Ex,
    opts = { desc = "Open File Explorer" },
  },
}

for _, bind in ipairs(map) do
  vim.keymap.set(bind.modes, bind.lhs, bind.rhs, bind.opts)
end
