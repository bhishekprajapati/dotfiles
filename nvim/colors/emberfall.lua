-- Emberfall — burning temple ukiyo-e palette
-- smoke-black ground, ember orange, vermilion, parchment cream
-- Usage: :colorscheme emberfall

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "emberfall"

local c = {
  -- grounds
  bg        = "#160F0D", -- deepest smoke
  bg_dark   = "#100A09", -- sidebars, tabline
  bg_float  = "#1D1412", -- floats, popups
  bg_alt    = "#221714", -- cursorline, inactive tab
  bg_high   = "#2B1E1A", -- column, folds
  sel       = "#4E2F22", -- visual selection
  sel_dim   = "#3A2822", -- borders, dim selection

  -- inks
  fg        = "#E4D3B8", -- parchment text
  fg_dim    = "#CBB699",
  fg_bright = "#F0E2C9",
  comment   = "#7A6154", -- ash brown
  muted     = "#96806E",
  gutter    = "#584038",

  -- fire
  ember     = "#F0873F", -- primary ember orange
  ember_lo  = "#E0673A", -- deeper flame
  gold      = "#F2B865", -- hot glow
  gold_lo   = "#E09A45",
  vermilion = "#E05A38",
  red       = "#C4432C",

  -- earth / smoke
  moss      = "#A9AC6E", -- smoke pine
  moss_lo   = "#8F9257",
  teal      = "#A9C0B4", -- pale smoke teal
  teal_lo   = "#8FA79C",
  ash       = "#98A8B2", -- ash smoke blue
  ash_lo    = "#7B8A94",
  mauve     = "#CE8895", -- rock mauve
  mauve_lo  = "#B5697A",
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- terminal colors
vim.g.terminal_color_0, vim.g.terminal_color_8 = "#2B1E1A", "#584038"
vim.g.terminal_color_1, vim.g.terminal_color_9 = c.red, c.vermilion
vim.g.terminal_color_2, vim.g.terminal_color_10 = c.moss_lo, c.moss
vim.g.terminal_color_3, vim.g.terminal_color_11 = c.gold_lo, c.gold
vim.g.terminal_color_4, vim.g.terminal_color_12 = c.ash_lo, c.ash
vim.g.terminal_color_5, vim.g.terminal_color_13 = c.mauve_lo, c.mauve
vim.g.terminal_color_6, vim.g.terminal_color_14 = c.teal_lo, c.teal
vim.g.terminal_color_7, vim.g.terminal_color_15 = c.fg_dim, c.fg_bright

local groups = {
  -- editor ------------------------------------------------------------
  Normal       = { fg = c.fg, bg = c.bg },
  NormalNC     = { fg = c.fg, bg = c.bg },
  NormalFloat  = { fg = c.fg, bg = c.bg_float },
  FloatBorder  = { fg = c.sel_dim, bg = c.bg_float },
  FloatTitle   = { fg = c.ember, bg = c.bg_float, bold = true },
  Cursor       = { fg = c.bg, bg = c.ember },
  lCursor      = { fg = c.bg, bg = c.ember },
  CursorLine   = { bg = c.bg_alt },
  CursorColumn = { bg = c.bg_alt },
  ColorColumn  = { bg = c.bg_alt },
  CursorLineNr = { fg = c.ember, bold = true },
  LineNr       = { fg = c.gutter },
  SignColumn   = { bg = c.bg },
  FoldColumn   = { fg = c.gutter, bg = c.bg },
  Folded       = { fg = c.muted, bg = c.bg_high },
  VertSplit    = { fg = c.bg_high },
  WinSeparator = { fg = c.bg_high },
  Visual       = { bg = c.sel },
  VisualNOS    = { bg = c.sel },
  Search       = { fg = c.bg, bg = c.gold_lo },
  IncSearch    = { fg = c.bg, bg = c.ember, bold = true },
  CurSearch    = { fg = c.bg, bg = c.ember, bold = true },
  Substitute   = { fg = c.bg, bg = c.vermilion },
  MatchParen   = { fg = c.gold, bold = true, underline = true },
  NonText      = { fg = c.gutter },
  Whitespace   = { fg = c.bg_high },
  SpecialKey   = { fg = c.gutter },
  Conceal      = { fg = c.muted },
  Directory    = { fg = c.ember },
  Title        = { fg = c.ember, bold = true },
  ErrorMsg     = { fg = c.vermilion, bold = true },
  WarningMsg   = { fg = c.gold_lo },
  MoreMsg      = { fg = c.moss },
  ModeMsg      = { fg = c.fg_dim, bold = true },
  Question     = { fg = c.gold },
  MsgArea      = { fg = c.fg },
  MsgSeparator = { fg = c.sel_dim, bg = c.bg_dark },
  QuickFixLine = { bg = c.sel },
  StatusLine   = { fg = c.fg_dim, bg = c.bg_dark },
  StatusLineNC = { fg = c.comment, bg = c.bg_dark },
  TabLine      = { fg = c.muted, bg = c.bg_dark },
  TabLineFill  = { bg = c.bg_dark },
  TabLineSel   = { fg = c.bg, bg = c.ember_lo, bold = true },
  WinBar       = { fg = c.muted, bg = c.bg },
  WinBarNC     = { fg = c.comment, bg = c.bg },
  Pmenu        = { fg = c.fg, bg = c.bg_float },
  PmenuSel     = { fg = c.bg, bg = c.ember },
  PmenuSbar    = { bg = c.bg_high },
  PmenuThumb   = { bg = c.gutter },
  PmenuMatch   = { fg = c.gold, bold = true },
  PmenuMatchSel= { fg = c.bg, bg = c.ember, bold = true },
  WildMenu     = { fg = c.bg, bg = c.ember },
  SpellBad     = { sp = c.vermilion, undercurl = true },
  SpellCap     = { sp = c.gold_lo, undercurl = true },
  SpellLocal   = { sp = c.teal_lo, undercurl = true },
  SpellRare    = { sp = c.mauve, undercurl = true },
  healthSuccess= { fg = c.moss },

  -- syntax ------------------------------------------------------------
  Comment        = { fg = c.comment, italic = true },
  Constant       = { fg = c.mauve },
  String         = { fg = c.moss },
  Character      = { fg = c.moss },
  Number         = { fg = c.mauve },
  Boolean        = { fg = c.mauve },
  Float          = { fg = c.mauve },
  Identifier     = { fg = c.fg },
  Function       = { fg = c.ember },
  Statement      = { fg = c.vermilion },
  Conditional    = { fg = c.vermilion },
  Repeat         = { fg = c.vermilion },
  Label          = { fg = c.vermilion },
  Operator       = { fg = c.gold_lo },
  Keyword        = { fg = c.vermilion },
  Exception      = { fg = c.red },
  PreProc        = { fg = c.mauve_lo },
  Include        = { fg = c.vermilion },
  Define         = { fg = c.mauve_lo },
  Macro          = { fg = c.mauve_lo },
  PreCondit      = { fg = c.mauve_lo },
  Type           = { fg = c.gold },
  StorageClass   = { fg = c.gold_lo },
  Structure      = { fg = c.gold },
  Typedef        = { fg = c.gold },
  Special        = { fg = c.teal },
  SpecialChar    = { fg = c.teal },
  Tag            = { fg = c.ember },
  Delimiter      = { fg = c.fg_dim },
  SpecialComment = { fg = c.muted, italic = true },
  Debug          = { fg = c.vermilion },
  Underlined     = { underline = true },
  Bold           = { bold = true },
  Italic         = { italic = true },
  Todo           = { fg = c.bg, bg = c.gold, bold = true },
  Error          = { fg = c.vermilion },

  -- treesitter --------------------------------------------------------
  ["@variable"]              = { fg = c.fg },
  ["@variable.builtin"]      = { fg = c.vermilion, italic = true },
  ["@variable.parameter"]    = { fg = c.fg_dim, italic = true },
  ["@variable.member"]       = { fg = c.teal },
  ["@constant"]              = { fg = c.mauve },
  ["@constant.builtin"]      = { fg = c.mauve, italic = true },
  ["@constant.macro"]        = { fg = c.mauve_lo },
  ["@module"]                = { fg = c.gold },
  ["@label"]                 = { fg = c.vermilion },
  ["@string"]                = { fg = c.moss },
  ["@string.escape"]         = { fg = c.teal, bold = true },
  ["@string.special"]        = { fg = c.teal },
  ["@string.regexp"]         = { fg = c.teal_lo },
  ["@string.documentation"]  = { fg = c.moss_lo },
  ["@character"]             = { fg = c.moss },
  ["@number"]                = { fg = c.mauve },
  ["@boolean"]               = { fg = c.mauve },
  ["@function"]              = { fg = c.ember },
  ["@function.builtin"]      = { fg = c.ember, italic = true },
  ["@function.call"]         = { fg = c.ember },
  ["@function.macro"]        = { fg = c.mauve_lo },
  ["@function.method"]       = { fg = c.ember },
  ["@function.method.call"]  = { fg = c.ember },
  ["@constructor"]           = { fg = c.gold },
  ["@operator"]              = { fg = c.gold_lo },
  ["@keyword"]               = { fg = c.vermilion },
  ["@keyword.function"]      = { fg = c.vermilion },
  ["@keyword.operator"]      = { fg = c.vermilion },
  ["@keyword.return"]        = { fg = c.red, bold = true },
  ["@keyword.import"]        = { fg = c.vermilion },
  ["@keyword.conditional"]   = { fg = c.vermilion },
  ["@keyword.repeat"]        = { fg = c.vermilion },
  ["@keyword.exception"]     = { fg = c.red },
  ["@type"]                  = { fg = c.gold },
  ["@type.builtin"]          = { fg = c.gold_lo, italic = true },
  ["@type.definition"]       = { fg = c.gold },
  ["@attribute"]             = { fg = c.mauve_lo },
  ["@property"]              = { fg = c.teal },
  ["@punctuation.delimiter"] = { fg = c.muted },
  ["@punctuation.bracket"]   = { fg = c.fg_dim },
  ["@punctuation.special"]   = { fg = c.ember_lo },
  ["@comment"]               = { fg = c.comment, italic = true },
  ["@comment.todo"]          = { fg = c.bg, bg = c.gold, bold = true },
  ["@comment.note"]          = { fg = c.bg, bg = c.teal, bold = true },
  ["@comment.warning"]       = { fg = c.bg, bg = c.gold_lo, bold = true },
  ["@comment.error"]         = { fg = c.fg_bright, bg = c.red, bold = true },
  ["@tag"]                   = { fg = c.vermilion },
  ["@tag.builtin"]           = { fg = c.vermilion },
  ["@tag.attribute"]         = { fg = c.gold },
  ["@tag.delimiter"]         = { fg = c.muted },
  ["@markup.heading"]        = { fg = c.ember, bold = true },
  ["@markup.heading.1"]      = { fg = c.vermilion, bold = true },
  ["@markup.heading.2"]      = { fg = c.ember, bold = true },
  ["@markup.heading.3"]      = { fg = c.gold, bold = true },
  ["@markup.heading.4"]      = { fg = c.moss, bold = true },
  ["@markup.heading.5"]      = { fg = c.teal, bold = true },
  ["@markup.heading.6"]      = { fg = c.mauve, bold = true },
  ["@markup.strong"]         = { bold = true },
  ["@markup.italic"]         = { italic = true },
  ["@markup.strikethrough"]  = { strikethrough = true },
  ["@markup.underline"]      = { underline = true },
  ["@markup.link"]           = { fg = c.teal, underline = true },
  ["@markup.link.label"]     = { fg = c.ember },
  ["@markup.link.url"]       = { fg = c.teal_lo, underline = true },
  ["@markup.raw"]            = { fg = c.moss },
  ["@markup.list"]           = { fg = c.ember_lo },
  ["@markup.list.checked"]   = { fg = c.moss },
  ["@markup.list.unchecked"] = { fg = c.muted },
  ["@markup.quote"]          = { fg = c.muted, italic = true },
  ["@diff.plus"]             = { fg = c.moss },
  ["@diff.minus"]            = { fg = c.red },
  ["@diff.delta"]            = { fg = c.gold_lo },

  -- lsp ---------------------------------------------------------------
  ["@lsp.type.namespace"]     = { link = "@module" },
  ["@lsp.type.type"]          = { link = "@type" },
  ["@lsp.type.class"]         = { link = "@type" },
  ["@lsp.type.enum"]          = { link = "@type" },
  ["@lsp.type.interface"]     = { link = "@type" },
  ["@lsp.type.struct"]        = { link = "@type" },
  ["@lsp.type.parameter"]     = { link = "@variable.parameter" },
  ["@lsp.type.variable"]      = { link = "@variable" },
  ["@lsp.type.property"]      = { link = "@property" },
  ["@lsp.type.enumMember"]    = { link = "@constant" },
  ["@lsp.type.function"]      = { link = "@function" },
  ["@lsp.type.method"]        = { link = "@function.method" },
  ["@lsp.type.macro"]         = { link = "@function.macro" },
  ["@lsp.type.decorator"]     = { link = "@attribute" },
  ["@lsp.type.comment"]       = { link = "@comment" },
  ["@lsp.mod.deprecated"]     = { strikethrough = true },

  LspReferenceText            = { bg = c.sel_dim },
  LspReferenceRead            = { bg = c.sel_dim },
  LspReferenceWrite           = { bg = c.sel_dim, underline = true },
  LspSignatureActiveParameter = { fg = c.gold, bold = true },
  LspInlayHint                = { fg = c.gutter, bg = c.bg_alt, italic = true },
  LspCodeLens                 = { fg = c.comment, italic = true },
  LspInfoBorder               = { fg = c.sel_dim, bg = c.bg_float },

  -- diagnostics -------------------------------------------------------
  DiagnosticError            = { fg = c.vermilion },
  DiagnosticWarn             = { fg = c.gold_lo },
  DiagnosticInfo             = { fg = c.ash },
  DiagnosticHint             = { fg = c.teal },
  DiagnosticOk               = { fg = c.moss },
  DiagnosticUnderlineError   = { sp = c.vermilion, undercurl = true },
  DiagnosticUnderlineWarn    = { sp = c.gold_lo, undercurl = true },
  DiagnosticUnderlineInfo    = { sp = c.ash, undercurl = true },
  DiagnosticUnderlineHint    = { sp = c.teal, undercurl = true },
  DiagnosticUnderlineOk      = { sp = c.moss, undercurl = true },
  DiagnosticVirtualTextError = { fg = c.vermilion, bg = "#2A1614" },
  DiagnosticVirtualTextWarn  = { fg = c.gold_lo, bg = "#2A2014" },
  DiagnosticVirtualTextInfo  = { fg = c.ash, bg = "#1C2124" },
  DiagnosticVirtualTextHint  = { fg = c.teal, bg = "#1B2320" },

  -- diff / git --------------------------------------------------------
  DiffAdd    = { bg = "#20291C" },
  DiffChange = { bg = "#292314" },
  DiffDelete = { bg = "#2C1714" },
  DiffText   = { bg = "#3E3418" },
  Added      = { fg = c.moss },
  Changed    = { fg = c.gold_lo },
  Removed    = { fg = c.red },

  GitSignsAdd        = { fg = c.moss_lo },
  GitSignsChange     = { fg = c.gold_lo },
  GitSignsDelete     = { fg = c.red },
  GitSignsAddInline  = { bg = "#2D3A26" },
  GitSignsChangeInline = { bg = "#3A3220" },
  GitSignsDeleteInline = { bg = "#3C1F1B" },

  -- telescope ---------------------------------------------------------
  TelescopeNormal       = { fg = c.fg, bg = c.bg_float },
  TelescopeBorder       = { fg = c.sel_dim, bg = c.bg_float },
  TelescopeTitle        = { fg = c.bg, bg = c.ember, bold = true },
  TelescopePromptNormal = { fg = c.fg, bg = c.bg_alt },
  TelescopePromptBorder = { fg = c.bg_alt, bg = c.bg_alt },
  TelescopePromptTitle  = { fg = c.bg, bg = c.vermilion, bold = true },
  TelescopePromptPrefix = { fg = c.ember },
  TelescopeSelection    = { fg = c.fg_bright, bg = c.sel },
  TelescopeSelectionCaret = { fg = c.ember, bg = c.sel },
  TelescopeMatching     = { fg = c.gold, bold = true },
  TelescopeMultiSelection = { fg = c.mauve },

  -- snacks ------------------------------------------------------------
  SnacksNormal          = { fg = c.fg, bg = c.bg_float },
  SnacksWinBar          = { fg = c.ember, bg = c.bg_float, bold = true },
  SnacksBackdrop        = { bg = "#0A0605" },
  SnacksPickerDir       = { fg = c.comment },
  SnacksPickerMatch     = { fg = c.gold, bold = true },
  SnacksPickerPrompt    = { fg = c.ember, bold = true },
  SnacksPickerSelected  = { fg = c.mauve },
  SnacksPickerTitle     = { fg = c.bg, bg = c.ember, bold = true },
  SnacksPickerBorder    = { fg = c.sel_dim, bg = c.bg_float },
  SnacksPickerListCursorLine = { bg = c.sel },
  SnacksIndent          = { fg = c.bg_high },
  SnacksIndentScope     = { fg = c.ember_lo },
  SnacksDashboardHeader = { fg = c.ember },
  SnacksDashboardIcon   = { fg = c.gold },
  SnacksDashboardDesc   = { fg = c.fg_dim },
  SnacksDashboardKey    = { fg = c.vermilion },
  SnacksDashboardFooter = { fg = c.comment, italic = true },
  SnacksNotifierInfo    = { fg = c.ash, bg = c.bg_float },
  SnacksNotifierWarn    = { fg = c.gold_lo, bg = c.bg_float },
  SnacksNotifierError   = { fg = c.vermilion, bg = c.bg_float },

  -- neo-tree / explorer -----------------------------------------------
  NeoTreeNormal        = { fg = c.fg_dim, bg = c.bg_dark },
  NeoTreeNormalNC      = { fg = c.fg_dim, bg = c.bg_dark },
  NeoTreeWinSeparator  = { fg = c.bg_dark, bg = c.bg_dark },
  NeoTreeEndOfBuffer   = { fg = c.bg_dark, bg = c.bg_dark },
  NeoTreeRootName      = { fg = c.ember, bold = true },
  NeoTreeDirectoryName = { fg = c.fg_dim },
  NeoTreeDirectoryIcon = { fg = c.ember_lo },
  NeoTreeFileName      = { fg = c.fg_dim },
  NeoTreeIndentMarker  = { fg = c.bg_high },
  NeoTreeGitModified   = { fg = c.gold_lo },
  NeoTreeGitAdded      = { fg = c.moss_lo },
  NeoTreeGitDeleted    = { fg = c.red },
  NeoTreeGitUntracked  = { fg = c.mauve_lo },
  NeoTreeTitleBar      = { fg = c.bg, bg = c.ember },

  -- bufferline --------------------------------------------------------
  BufferLineFill              = { bg = c.bg_dark },
  BufferLineBackground        = { fg = c.comment, bg = c.bg_dark },
  BufferLineBufferSelected    = { fg = c.fg_bright, bg = c.bg, bold = true, italic = false },
  BufferLineIndicatorSelected = { fg = c.ember, bg = c.bg },
  BufferLineSeparator         = { fg = c.bg_dark, bg = c.bg_dark },

  -- which-key / noice / misc plugins ----------------------------------
  WhichKey          = { fg = c.ember },
  WhichKeyGroup     = { fg = c.gold },
  WhichKeyDesc      = { fg = c.fg_dim },
  WhichKeySeparator = { fg = c.comment },
  WhichKeyFloat     = { bg = c.bg_float },
  WhichKeyBorder    = { fg = c.sel_dim, bg = c.bg_float },

  NoiceCmdlinePopupBorder = { fg = c.ember_lo },
  NoiceCmdlineIcon        = { fg = c.ember },
  NoiceConfirmBorder      = { fg = c.ember_lo },

  NotifyINFOBorder  = { fg = c.ash_lo },
  NotifyWARNBorder  = { fg = c.gold_lo },
  NotifyERRORBorder = { fg = c.vermilion },
  NotifyDEBUGBorder = { fg = c.comment },
  NotifyTRACEBorder = { fg = c.mauve_lo },

  IblIndent      = { fg = c.bg_high },
  IblScope       = { fg = c.ember_lo },
  IndentBlanklineChar = { fg = c.bg_high },

  MiniIndentscopeSymbol = { fg = c.ember_lo },
  MiniStatuslineModeNormal  = { fg = c.bg, bg = c.ember, bold = true },
  MiniStatuslineModeInsert  = { fg = c.bg, bg = c.moss, bold = true },
  MiniStatuslineModeVisual  = { fg = c.bg, bg = c.mauve, bold = true },
  MiniStatuslineModeReplace = { fg = c.bg, bg = c.vermilion, bold = true },
  MiniStatuslineModeCommand = { fg = c.bg, bg = c.gold, bold = true },

  FlashLabel  = { fg = c.bg, bg = c.vermilion, bold = true },
  FlashMatch  = { fg = c.bg, bg = c.gold_lo },
  FlashCurrent= { fg = c.bg, bg = c.ember, bold = true },

  RainbowDelimiterRed    = { fg = c.vermilion },
  RainbowDelimiterYellow = { fg = c.gold },
  RainbowDelimiterBlue   = { fg = c.ash },
  RainbowDelimiterOrange = { fg = c.ember },
  RainbowDelimiterGreen  = { fg = c.moss },
  RainbowDelimiterViolet = { fg = c.mauve },
  RainbowDelimiterCyan   = { fg = c.teal },

  -- cmp / blink -------------------------------------------------------
  CmpItemAbbr           = { fg = c.fg_dim },
  CmpItemAbbrDeprecated = { fg = c.comment, strikethrough = true },
  CmpItemAbbrMatch      = { fg = c.gold, bold = true },
  CmpItemAbbrMatchFuzzy = { fg = c.gold_lo },
  CmpItemKind           = { fg = c.ember },
  CmpItemMenu           = { fg = c.comment },

  BlinkCmpMenuBorder    = { fg = c.sel_dim, bg = c.bg_float },
  BlinkCmpLabelMatch    = { fg = c.gold, bold = true },
  BlinkCmpKind          = { fg = c.ember },
  BlinkCmpDocBorder     = { fg = c.sel_dim, bg = c.bg_float },
}

for group, opts in pairs(groups) do
  hl(group, opts)
end
