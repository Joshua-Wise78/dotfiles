-- Reset any existing highlights and name the colorscheme
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "retro_apple"

-- Map Helix attributes to Neovim Highlight Groups
local highlights = {
  -- UI Background & Text
  Normal = { fg = "#FFFFFF", bg = "#232530" },
  NormalFloat = { fg = "#FFFFFF", bg = "#444444" }, -- Used for ui.popup/help

  -- Selection & Cursor
  Visual = { bg = "#444444" },
  Cursor = { fg = "#232530", bg = "#FFFFFF" },
  MatchParen = { fg = "#FDB827", bold = true },

  -- Borders, Line Numbers & UI Elements
  LineNr = { fg = "#666666" },
  CursorLineNr = { fg = "#FFFFFF", bold = true },
  WinSeparator = { fg = "#FFFFFF" }, -- Mapped to ui.window
  FloatBorder = { fg = "#FFFFFF", bg = "#444444" },
  ColorColumn = { bg = "#009DDC" }, -- Mapped to ui.virtual.ruler

  -- Statusline
  StatusLine = { fg = "#FFFFFF", bg = "#009DDC" },
  StatusLineNC = { fg = "#DDDDDD", bg = "#444444" },

  -- Menus
  Pmenu = { fg = "#FFFFFF", bg = "#444444" },
  PmenuSel = { fg = "#232530", bg = "#FDB827" },

  -- Code Syntax (Retro Stripes)
  Keyword = { fg = "#963D97" },      -- Purple
  Statement = { fg = "#963D97" },
  Conditional = { fg = "#963D97" },
  Function = { fg = "#009DDC" },     -- Blue
  Type = { fg = "#FDB827" },         -- Yellow
  String = { fg = "#61BB46" },       -- Green
  Identifier = { fg = "#FFFFFF" },   -- White (Base Variable)
  Constant = { fg = "#F5821F" },     -- Orange
  Comment = { fg = "#666666", italic = true },
  Special = { fg = "#E03A3E" },      -- Red
  Operator = { fg = "#E03A3E" },     -- Changed to Red for =, +, | 

  -- Diagnostics (Errors/Warnings)
  DiagnosticError = { fg = "#E03A3E" },
  DiagnosticWarn = { fg = "#FDB827" },
  DiagnosticInfo = { fg = "#009DDC" },

  -- =========================================================
  -- Advanced Treesitter Highlights (The specific rich colors)
  -- =========================================================
  
  -- Object properties (like the 'next' and 'prev' in self.next)
  ["@variable.member"] = { fg = "#F5821F" }, -- Orange
  
  -- Function parameters (like the 'value' inside def __init__(self, value))
  ["@variable.parameter"] = { fg = "#FFFFFF", italic = true },
  
  -- Types and Generics (like the 'T' or 'Node')
  ["@type"] = { fg = "#FDB827" }, -- Yellow
  ["@type.builtin"] = { fg = "#FDB827", italic = true },
  
  -- Modules and Imports
  ["@module"] = { fg = "#009DDC" }, -- Blue
  
  -- Built-in variables (like 'self' or 'cls')
  ["@variable.builtin"] = { fg = "#963D97", italic = true }, -- Purple italic
  
  -- Punctuation (Dimming brackets, colons, and commas makes the code pop more)
  ["@punctuation.delimiter"] = { fg = "#666666" },
  ["@punctuation.bracket"] = { fg = "#666666" },
}

-- Loop through the table and apply the highlight groups securely
for group, colors in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, colors)
end
