-- Editor-style makeover (VS Code / Zed feel) on top of LazyVim.
-- Only looks & layout live here: no keymaps are added or changed.
-- Original config backup: ~/.config/nvim.backup-2026-11-10

-- ── White accent: replaces LazyVim's blue UI accents (syntax colors untouched)
-- (variable is still called `violet` internally; values are off-white/neutral)
local violet = {
  main = "#e6e6e6", -- primary accent (off-white, not pure white)
  soft = "#c9c9c9", -- softer white
  dim = "#6e6e6e", -- borders / scope lines
  sel = "#2f2f2f", -- selection / menu highlight bg (neutral gray)
  ink = "#0d1117", -- text on white blocks
}
_G.EditorViolet = violet

local function apply_violet()
  local set = function(group, val) vim.api.nvim_set_hl(0, group, val) end
  local fg = { fg = violet.main }
  for _, g in ipairs({
    "Directory", "Title", "FloatTitle", "CursorLineNr",
    "SnacksDashboardIcon", "SnacksDashboardKey", "SnacksDashboardTitle", "SnacksDashboardSpecial",
    "SnacksPickerTitle", "SnacksPickerPrompt", "SnacksPickerMatch", "SnacksPickerDirectory",
    "SnacksPickerTree", "SnacksPickerSpecial", "SnacksInputTitle", "SnacksInputIcon",
    "NoiceCmdlineIcon", "NoiceCmdlineIconSearch", "NoiceCmdlinePopupTitle", "NoiceCmdlinePopupTitleCmdline",
    "WhichKey", "WhichKeyGroup", "WhichKeyTitle",
    "BlinkCmpLabelMatch", "LazyH1Fg", "MiniIconsBlue",
  }) do
    set(g, fg)
  end
  set("SnacksDashboardHeader", { fg = violet.soft, bold = true })
  set("SnacksDashboardDesc", { fg = violet.soft })
  set("NoiceCmdlinePopupBorder", { fg = violet.dim })
  set("NoiceCmdlinePopupBorderCmdline", { fg = violet.dim })
  set("NoiceCmdlinePopupBorderSearch", { fg = violet.dim })
  set("SnacksIndentScope", { fg = violet.dim })
  set("TreesitterContextBottom", { underline = true, sp = violet.dim })
  set("Visual", { bg = violet.sel })
  set("PmenuSel", { bg = violet.sel, bold = true })
  set("BlinkCmpMenuSelection", { bg = violet.sel, bold = true })
  set("SnacksPickerListCursorLine", { bg = violet.sel })
  set("LazyH1", { fg = violet.ink, bg = violet.main, bold = true })
  set("LazyButtonActive", { fg = violet.ink, bg = violet.main, bold = true })
  set("SatelliteBar", { bg = violet.sel })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("editor_violet", { clear = true }),
  callback = apply_violet,
})

return {
  -- ── Tabs: always-visible editor tabs with an "EXPLORER" header over the sidebar
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.highlights = function(defaults)
        local hl = {}
        for name, _ in pairs(defaults.highlights) do
          if name:match("_selected$") then hl[name] = { bg = violet.sel } end
        end
        hl.buffer_selected = { fg = violet.main, bg = violet.sel, bold = true, italic = false }
        hl.indicator_selected = { fg = violet.sel, bg = violet.sel }
        hl.offset_separator = { fg = violet.sel }
        return hl
      end
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        always_show_bufferline = true,
        separator_style = "thin",
        indicator = { style = "none" },
        show_buffer_close_icons = true,
        show_close_icon = false,
        modified_icon = "●",
        tab_size = 20,
        max_name_length = 24,
        hover = { enabled = true, delay = 150, reveal = { "close" } },
      })
      opts.options.offsets = {
        { filetype = "snacks_layout_box", text = "  EXPLORER", text_align = "left", highlight = "Directory", separator = true },
        { filetype = "neo-tree", text = "  EXPLORER", text_align = "left", highlight = "Directory", separator = true },
      }
    end,
  },

  -- ── Statusline: flat, clean editor status bar + active LSP names
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- violet normal-mode block instead of blue
      local ok, theme = pcall(require, "lualine.themes." .. (vim.g.colors_name or "auto"))
      if not ok then theme = require("lualine.themes.auto") end
      theme = vim.deepcopy(theme)
      theme.normal = theme.normal or {}
      theme.normal.a = { fg = violet.ink, bg = violet.main, gui = "bold" }
      theme.normal.b = vim.tbl_extend("force", theme.normal.b or {}, { fg = violet.soft })
      opts.options.theme = theme

      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
      opts.options.disabled_filetypes = opts.options.disabled_filetypes or {}
      opts.options.disabled_filetypes.winbar = { "dashboard", "snacks_dashboard", "snacks_picker_list" }

      opts.sections.lualine_a = {
        { "mode", icon = "", fmt = function(s) return s:sub(1, 1) .. s:sub(2):lower() end },
      }
      opts.sections.lualine_b = { { "branch", icon = "" } }

      table.insert(opts.sections.lualine_x, 1, {
        function()
          local names = {}
          for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if c.name ~= "copilot" then table.insert(names, c.name) end
          end
          return #names > 0 and (" " .. table.concat(names, ", ")) or ""
        end,
        color = function() return { fg = Snacks.util.color("Comment") } end,
      })

      -- swap the clock for something an editor shows: indent + encoding
      opts.sections.lualine_z = {
        {
          function()
            local kind = vim.bo.expandtab and "Spaces" or "Tab"
            return kind .. ": " .. vim.bo.shiftwidth .. "  " .. (vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding):upper()
          end,
        },
      }
    end,
  },

  -- ── Breadcrumbs in the winbar (file › class › function), clickable
  {
    "Bekaboo/dropbar.nvim",
    event = "LazyFile",
    opts = {
      bar = {
        enable = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
            and vim.bo[buf].buftype == ""
            and vim.api.nvim_buf_get_name(buf) ~= ""
            and not vim.wo[win].diff
        end,
      },
    },
  },

  -- ── Sticky scroll (keeps current function/class header pinned on top)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = { max_lines = 3, multiline_threshold = 1, mode = "cursor", separator = nil },
  },

  -- ── Scrollbar with git / diagnostics / search marks
  {
    "lewis6991/satellite.nvim",
    event = "LazyFile",
    opts = {
      current_only = false,
      winblend = 0,
      excluded_filetypes = { "snacks_picker_list", "snacks_dashboard", "lazy", "mason", "noice" },
      handlers = { marks = { enable = false } },
    },
  },

  -- ── Completion menu: bordered popups, VS Code-like columns
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
          scrollbar = false,
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
        documentation = { window = { border = "rounded" } },
      },
      signature = { window = { border = "rounded" } },
    },
  },

  -- ── Diagnostics: rounded floats, softer inline hints
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = { border = "rounded", source = "if_many" },
        virtual_text = { spacing = 2, prefix = "●" },
      },
    },
  },

  -- ── Snacks: sidebar explorer, editor-style dashboard
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            auto_close = false,
            layout = { preset = "sidebar", preview = false, layout = { width = 32, position = "left" } },
          },
        },
      },
      indent = {
        indent = { char = "▏" },
        scope = { char = "▏" },
      },
      dashboard = {
        preset = {
          header = table.concat({
            "███╗   ██╗██╗   ██╗██╗███╗   ███╗",
            "████╗  ██║██║   ██║██║████╗ ████║",
            "██╔██╗ ██║██║   ██║██║██╔████╔██║",
            "██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          }, "\n"),
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Start", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, limit = 6, indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", limit = 5, indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
