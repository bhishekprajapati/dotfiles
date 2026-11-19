local M = {}

---@param value unknown
---@return string | nil
function M.is_string(value)
  if type(value) == "string" then
    return value
  end
  return nil
end

---@param value unknown
---@return table | nil
function M.is_table(value)
  if type(value) == "table" then
    return value
  end
  return nil
end

---@param value unknown
---@return function | nil
function M.is_func(value)
  if type(value) == "function" then
    return value
  end
  return nil
end

---@class LoaderOptions
---@field load_only boolean? default false

---@param dir string
---@param require_path fun(filename: string): string
---@param loader_opts LoaderOptions?
function M.loader(dir, require_path, loader_opts)
  local opts = loader_opts or { load_only = false }

  for filepath, filetype in vim.fs.dir(dir) do
    local ext = vim.fs.ext(filepath)

    if filetype == "file" and ext == "lua" then
      local filename = filepath:sub(1, #filepath - 4)
      local mod = M.is_table(require(require_path(filename)))

      if (not opts["load_only"]) and mod then
        local src = M.is_string(mod[1])
        local name = M.is_string(mod["name"])

        if src then
          local spec = { src = src }

          if name then
            spec["name"] = name
          end

          vim.pack.add({ spec })
          local setup = M.is_func(mod["setup"])

          if setup then
            setup()
          end
        end
      end
    end
  end
end

return M
