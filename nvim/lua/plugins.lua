local PLUGINS_DIR = vim.fn.stdpath("config") .. "/lua/plugins"

for filepath, filetype in vim.fs.dir(PLUGINS_DIR) do
  local ext = vim.fs.ext(filepath)

  if filetype == "file" and ext == "lua" then
    local filename = filepath:sub(1, #filepath - 4)
    local mod = require("plugins." .. filename)

    if type(mod) == "table" then
      local src = mod[1]

      if type(src) == "string" then
        vim.pack.add({ src })

        if type(mod.setup) == "function" then
          mod.setup()
        end
      end
    end
  end
end
