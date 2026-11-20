---@alias KeyBind [string, string, string|function, vim.keymap.set.Opts?]

---@type KeyBind[]
local map = {
  { "n", "<leader>e", vim.cmd.Ex, { desc = "Open File Explorer" } },
  { "n", "<C-s>", "<cmd>write<cr>", { desc = "Save Buffer" } },
  { "i", "<C-s>", "<Esc><cmd>write<cr>", { desc = "Save Buffer" } },
  { "i", "jj", "<Esc>", { desc = "Switch to Normal Mode" } },
}

for _, bind in ipairs(map) do
  local modes = bind[1]
  local lhs = bind[2]
  local rhs = bind[3]
  local opts = bind[4]
  vim.keymap.set(modes, lhs, rhs, opts)
end
