local PLUGINS_DIR = vim.fn.stdpath("config") .. "/lua/plugins"

for filepath, type in vim.fs.dir(PLUGINS_DIR) do
  local ext = vim.fs.ext(filepath)

  if type == "file" and ext == "lua" then
    local filename = filepath:sub(1, #filepath - 4)
    local plugin = require("plugins." .. filename)
    local src = plugin[1]

    vim.pack.add({ src })

    if plugin.setup then
      plugin.setup()
    end
  end
end
