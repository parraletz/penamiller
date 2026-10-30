-- Penamiller by parraletz. Standalone dark colorscheme for Neovim 0.10+.
-- Palette values mirror palette.json; no plugin dependencies or setup required.
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "penamiller"

local c = {
  bg = "#141413", fg = "#FAF9F5", surface = "#262624", selection = "#353532",
  muted = "#C9C6BB", subtle = "#5E5D59",
  red = "#D9483E", green = "#6AA84F", yellow = "#E0A82E", blue = "#4A86D6",
  purple = "#C05BC4", cyan = "#3EA6B8", orange = "#D97757",
  orange_bright = "#F0956F", pink = "#E86F9A", teal = "#3FB8A4",
  lavender = "#9D8CF0", lime = "#B6D94C", sky = "#6A9BCC", sand = "#E8E6DC",
}
local ansi = {
  "#262624", "#D9483E", "#6AA84F", "#E0A82E", "#4A86D6", "#C05BC4", "#3EA6B8", "#C9C6BB",
  "#5E5D59", "#FF7A6B", "#9BD35F", "#FFD36B", "#7FB0F0", "#E48AE9", "#72CDDD", "#FAF9F5",
}
for i, color in ipairs(ansi) do
  vim.g["terminal_color_" .. (i - 1)] = color
end

-- All derived surfaces are computed from the palette, not another theme.
local function blend(fg, bg, alpha)
  local channels = {}
  for i = 2, 6, 2 do
    local f, b = tonumber(fg:sub(i, i + 1), 16), tonumber(bg:sub(i, i + 1), 16)
    channels[#channels + 1] = math.floor(f * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", unpack(channels))
end

local groups = {
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.surface },
  FloatBorder = { fg = c.subtle, bg = c.surface },
  FloatTitle = { fg = c.orange, bg = c.surface, bold = true },
  FloatFooter = { fg = c.muted, bg = c.surface },
  ColorColumn = { bg = c.surface },
  Cursor = { fg = c.bg, bg = c.orange },
  CursorLine = { bg = c.surface },
  CursorColumn = { bg = c.surface },
  CursorLineNr = { fg = c.orange, bold = true },
  LineNr = { fg = c.subtle },
  SignColumn = { fg = c.muted, bg = c.bg },
  FoldColumn = { fg = c.subtle, bg = c.bg },
  Folded = { fg = c.muted, bg = c.surface },
  WinSeparator = { fg = c.selection },
  EndOfBuffer = { fg = c.bg },
  NonText = { fg = c.subtle },
  Whitespace = { fg = c.selection },
  SpecialKey = { fg = c.subtle },
  Conceal = { fg = c.muted },
  Visual = { bg = c.selection },
  Search = { fg = c.bg, bg = c.yellow },
  IncSearch = { fg = c.bg, bg = c.orange, bold = true },
  CurSearch = { fg = c.bg, bg = c.orange, bold = true },
  Substitute = { fg = c.bg, bg = c.red },
  MatchParen = { fg = c.orange_bright, bg = c.selection, bold = true },
  Pmenu = { fg = c.fg, bg = c.surface },
  PmenuSel = { fg = c.fg, bg = c.selection, bold = true },
  PmenuSbar = { bg = c.selection },
  PmenuThumb = { bg = c.subtle },
  PmenuMatch = { fg = c.orange, bold = true },
  PmenuMatchSel = { fg = c.orange_bright, bg = c.selection, bold = true },
  StatusLine = { fg = c.fg, bg = c.selection },
  StatusLineNC = { fg = c.muted, bg = c.surface },
  TabLine = { fg = c.muted, bg = c.surface },
  TabLineFill = { bg = c.bg },
  TabLineSel = { fg = c.orange, bg = c.selection, bold = true },
  WinBar = { fg = c.fg, bg = c.bg, bold = true },
  WinBarNC = { fg = c.muted, bg = c.bg },
  Title = { fg = c.orange, bold = true },
  Directory = { fg = c.blue },
  ErrorMsg = { fg = c.red, bold = true },
  WarningMsg = { fg = c.yellow },
  MoreMsg = { fg = c.teal },
  Question = { fg = c.green },
  ModeMsg = { fg = c.orange, bold = true },
  MsgArea = { fg = c.fg, bg = c.bg },
  QuickFixLine = { bg = c.selection, bold = true },
  WildMenu = { fg = c.bg, bg = c.orange },

  Comment = { fg = blend(c.muted, c.bg, 0.6), italic = true },
  Constant = { fg = c.orange_bright },
  String = { fg = c.green },
  Character = { fg = c.teal },
  Number = { fg = c.orange_bright },
  Boolean = { fg = c.orange_bright },
  Float = { fg = c.orange_bright },
  Identifier = { fg = c.fg },
  Function = { fg = c.blue },
  Statement = { fg = c.purple },
  Operator = { fg = c.cyan },
  Keyword = { fg = c.purple },
  PreProc = { fg = c.pink },
  Type = { fg = c.yellow },
  Special = { fg = c.orange },
  Delimiter = { fg = c.muted },
  Underlined = { fg = c.blue, underline = true },
  Ignore = { fg = c.subtle },
  Error = { fg = c.red },
  Todo = { fg = c.bg, bg = c.yellow, bold = true },
  Added = { fg = c.green },
  Changed = { fg = c.blue },
  Removed = { fg = c.red },
  DiffAdd = { bg = blend(c.green, c.bg, 0.18) },
  DiffChange = { bg = blend(c.blue, c.bg, 0.14) },
  DiffDelete = { fg = c.red, bg = blend(c.red, c.bg, 0.18) },
  DiffText = { bg = blend(c.blue, c.bg, 0.32), bold = true },

  ["@variable.builtin"] = { fg = c.red },
  ["@variable.parameter"] = { fg = c.sand },
  ["@variable.member"] = { fg = c.teal },
  ["@function.builtin"] = { fg = c.orange },
  ["@module"] = { fg = c.lavender },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.link.label"] = { fg = c.sky },
  ["@markup.link.url"] = { fg = c.teal, underline = true },
  ["@markup.raw"] = { fg = c.green },
  ["@tag.attribute"] = { fg = c.teal },
  ["@lsp.mod.deprecated"] = { strikethrough = true },
  LspReferenceText = { bg = c.selection },
  LspReferenceRead = { bg = c.selection },
  LspReferenceWrite = { bg = c.selection, underline = true },
  LspInlayHint = { fg = c.subtle, bg = c.surface },
  LspCodeLens = { fg = c.subtle, italic = true },
  LspSignatureActiveParameter = { fg = c.orange, bold = true },
}

local links = {
  lCursor = "Cursor", CursorIM = "Cursor", TermCursor = "Cursor",
  CursorLineSign = "SignColumn", CursorLineFold = "FoldColumn",
  LineNrAbove = "LineNr", LineNrBelow = "LineNr", VisualNOS = "Visual",
  VertSplit = "WinSeparator", MsgSeparator = "WinSeparator",
  Conditional = "Statement", Repeat = "Statement", Label = "Statement",
  Exception = "Statement", Include = "PreProc", Define = "PreProc",
  Macro = "PreProc", PreCondit = "PreProc", StorageClass = "Type",
  Structure = "Type", Typedef = "Type", Tag = "Special",
  SpecialChar = "Special", SpecialComment = "Comment", Debug = "Special",
  ["@variable"] = "Identifier", ["@constant"] = "Constant",
  ["@constant.builtin"] = "Constant", ["@constant.macro"] = "Macro",
  ["@string"] = "String", ["@string.escape"] = "SpecialChar",
  ["@string.regexp"] = "Special", ["@character"] = "Character",
  ["@number"] = "Number", ["@number.float"] = "Float", ["@boolean"] = "Boolean",
  ["@type"] = "Type", ["@type.builtin"] = "Type", ["@attribute"] = "PreProc",
  ["@property"] = "@variable.member", ["@function"] = "Function",
  ["@function.call"] = "Function", ["@function.method"] = "Function",
  ["@function.method.call"] = "Function", ["@function.macro"] = "Macro",
  ["@constructor"] = "Type", ["@operator"] = "Operator", ["@keyword"] = "Keyword",
  ["@punctuation.delimiter"] = "Delimiter", ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.special"] = "Special", ["@comment"] = "Comment",
  ["@comment.error"] = "DiagnosticError", ["@comment.warning"] = "DiagnosticWarn",
  ["@comment.todo"] = "Todo", ["@comment.note"] = "DiagnosticInfo",
  ["@markup.heading"] = "Title", ["@markup.quote"] = "Comment",
  ["@markup.list"] = "Special", ["@tag"] = "Tag", ["@tag.delimiter"] = "Delimiter",
  ["@diff.plus"] = "Added", ["@diff.minus"] = "Removed", ["@diff.delta"] = "Changed",
  ["@label"] = "Label",
  ["@lsp.type.class"] = "Type", ["@lsp.type.struct"] = "Type",
  ["@lsp.type.interface"] = "Type", ["@lsp.type.enum"] = "Type",
  ["@lsp.type.type"] = "Type", ["@lsp.type.typeParameter"] = "Type",
  ["@lsp.type.function"] = "Function", ["@lsp.type.method"] = "Function",
  ["@lsp.type.parameter"] = "@variable.parameter", ["@lsp.type.variable"] = "@variable",
  ["@lsp.type.property"] = "@variable.member", ["@lsp.type.enumMember"] = "Constant",
  ["@lsp.type.namespace"] = "@module", ["@lsp.type.macro"] = "Macro",
  ["@lsp.type.decorator"] = "PreProc", ["@lsp.type.comment"] = "Comment",
  ["@lsp.type.string"] = "String", ["@lsp.type.number"] = "Number",
  ["@lsp.type.keyword"] = "Keyword", ["@lsp.type.operator"] = "Operator",
  GitSignsAdd = "Added", GitSignsChange = "Changed", GitSignsDelete = "Removed",
  GitSignsAddNr = "Added", GitSignsChangeNr = "Changed", GitSignsDeleteNr = "Removed",
  GitSignsAddLn = "DiffAdd", GitSignsChangeLn = "DiffChange", GitSignsDeleteLn = "DiffDelete",
  BlinkCmpMenu = "Pmenu", BlinkCmpMenuBorder = "FloatBorder",
  BlinkCmpMenuSelection = "PmenuSel", BlinkCmpLabel = "NormalFloat",
  BlinkCmpLabelMatch = "PmenuMatch", BlinkCmpLabelDeprecated = "@lsp.mod.deprecated",
  BlinkCmpLabelDescription = "Comment", BlinkCmpKind = "Type",
  BlinkCmpDoc = "NormalFloat", BlinkCmpDocBorder = "FloatBorder",
  BlinkCmpSignatureHelp = "NormalFloat", BlinkCmpSignatureHelpBorder = "FloatBorder",
  BlinkCmpSignatureHelpActiveParameter = "LspSignatureActiveParameter",
  BlinkCmpGhostText = "Comment",
  CmpItemAbbr = "NormalFloat", CmpItemAbbrMatch = "PmenuMatch", CmpItemKind = "Type",
  WhichKey = "Function", WhichKeyGroup = "Keyword", WhichKeyDesc = "Identifier",
  WhichKeySeparator = "Comment", WhichKeyFloat = "NormalFloat", WhichKeyBorder = "FloatBorder",
  WhichKeyNormal = "NormalFloat", WhichKeyValue = "String",
  NoiceCmdlinePopup = "NormalFloat", NoiceCmdlinePopupBorder = "FloatBorder",
  NoiceCmdlineIcon = "Special", NoiceConfirm = "NormalFloat", NoiceConfirmBorder = "FloatBorder",
  SnacksNormal = "NormalFloat", SnacksNormalNC = "NormalFloat", SnacksWinBar = "WinBar",
  SnacksPickerNormal = "NormalFloat", SnacksPickerBorder = "FloatBorder",
  SnacksPickerTitle = "FloatTitle", SnacksPickerMatch = "PmenuMatch",
  SnacksPickerSelected = "Special", SnacksPickerDir = "Comment",
  SnacksDashboardHeader = "Title", SnacksDashboardIcon = "Special",
  SnacksDashboardKey = "Function", SnacksDashboardDesc = "Identifier",
  SnacksDashboardFooter = "Comment", SnacksNotifierInfo = "DiagnosticInfo",
  SnacksNotifierWarn = "DiagnosticWarn", SnacksNotifierError = "DiagnosticError",
  FzfLuaNormal = "NormalFloat", FzfLuaBorder = "FloatBorder", FzfLuaTitle = "FloatTitle",
  FzfLuaHeaderBind = "Special", FzfLuaHeaderText = "Comment",
  MasonNormal = "NormalFloat", MasonHeader = "Title", MasonHighlight = "Function",
  MasonHighlightBlock = "Search", MasonMuted = "Comment", MasonError = "DiagnosticError",
  TelescopeNormal = "NormalFloat", TelescopeBorder = "FloatBorder",
  TelescopeTitle = "FloatTitle", TelescopeSelection = "PmenuSel", TelescopeMatching = "PmenuMatch",
}

for severity, color in pairs({ Error = c.red, Warn = c.yellow, Info = c.blue, Hint = c.teal, Ok = c.green }) do
  groups["Diagnostic" .. severity] = { fg = color }
  groups["DiagnosticVirtualText" .. severity] = { fg = color, bg = blend(color, c.bg, 0.10) }
  groups["DiagnosticUnderline" .. severity] = { sp = color, undercurl = true }
  links["DiagnosticSign" .. severity] = "Diagnostic" .. severity
  links["DiagnosticFloating" .. severity] = "Diagnostic" .. severity
end
groups.DiagnosticDeprecated = { strikethrough = true }
links.DiagnosticUnnecessary = "Comment"
for group, severity in pairs({ SpellBad = "Error", SpellCap = "Warn", SpellLocal = "Hint", SpellRare = "Info" }) do
  links[group] = "DiagnosticUnderline" .. severity
end
for level, severity in pairs({ ERROR = "Error", WARN = "Warn", INFO = "Info", DEBUG = "Hint", TRACE = "Hint" }) do
  links["Notify" .. level .. "Border"] = "Diagnostic" .. severity
  links["Notify" .. level .. "Icon"] = "Diagnostic" .. severity
  links["Notify" .. level .. "Title"] = "Diagnostic" .. severity
  links["Notify" .. level .. "Body"] = "NormalFloat"
end

for name, attributes in pairs(groups) do
  vim.api.nvim_set_hl(0, name, attributes)
end
for name, target in pairs(links) do
  vim.api.nvim_set_hl(0, name, { link = target })
end
