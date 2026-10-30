local function check()
  local palette = vim.fn.json_decode(table.concat(vim.fn.readfile(vim.env.PENAMILLER_PALETTE), "\n"))
  local function rgb(hex)
    return tonumber(hex:sub(2), 16)
  end
  local function hl(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
  end
  local function verify()
    assert(vim.g.colors_name == "penamiller", "wrong colorscheme name")
    assert(vim.o.background == "dark", "wrong background")
    assert(vim.o.termguicolors, "true color not enabled")
    assert(hl("Normal").fg == rgb(palette.foreground), "foreground differs from palette")
    assert(hl("Normal").bg == rgb(palette.background), "background differs from palette")
    assert(hl("Cursor").bg == rgb(palette.extras.orange), "cursor differs from palette")
    assert(hl("Function").fg == rgb(palette.ansi[5]), "function color differs from palette")
    assert(hl("String").fg == rgb(palette.ansi[3]), "string color differs from palette")
    assert(hl("Comment").fg ~= hl("Normal").bg, "invisible comments")
    assert(hl("DiagnosticUnderlineError").undercurl, "missing diagnostic underline")
    assert(hl("DiagnosticUnderlineError").sp == rgb(palette.ansi[2]), "wrong underline color")
    assert(hl("DiffAdd").bg ~= hl("Normal").bg, "missing diff background")
    assert(hl("@markup.strong").bold, "missing bold markup")
    for i, color in ipairs(palette.ansi) do
      assert(vim.g["terminal_color_" .. (i - 1)] == color, "ANSI mismatch at " .. (i - 1))
    end
    for _, name in ipairs({
      "NormalFloat", "FloatBorder", "StatusLine", "Visual", "Search", "PmenuSel",
      "@variable", "@function", "@keyword", "@type", "@string", "@comment",
      "@lsp.type.class", "@lsp.type.function", "@lsp.type.parameter",
      "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint",
      "DiagnosticVirtualTextError", "SpellBad", "GitSignsAdd", "GitSignsChange",
      "GitSignsDelete", "BlinkCmpMenu", "BlinkCmpLabelMatch", "WhichKey",
      "NoiceCmdlinePopup", "SnacksPickerMatch", "SnacksDashboardHeader",
      "NotifyERRORBorder", "NotifyINFOBody", "FzfLuaNormal", "MasonNormal", "TelescopeSelection",
    }) do
      assert(next(hl(name)), "empty or unresolved highlight: " .. name)
    end
    for name in pairs(package.loaded) do
      assert(not name:match("^catppuccin"), "Catppuccin was loaded")
    end
    assert(#vim.api.nvim_get_runtime_file("colors/catppuccin-mocha.*", true) == 0,
      "test runtime must not contain Catppuccin")
  end

  vim.opt.runtimepath:prepend(vim.env.PENAMILLER_RUNTIME)
  -- Fail immediately if any plugin/module is required by the colorscheme.
  local original_require = require
  _G.require = function(name)
    error("unexpected module dependency: " .. name)
  end
  vim.cmd("colorscheme penamiller")
  _G.require = original_require
  verify()

  -- Reload after mutation, including the syntax-reset branch.
  vim.cmd("syntax on")
  vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#ffffff" })
  vim.cmd("colorscheme penamiller")
  verify()

  -- Switching from another colorscheme and light background must work too.
  vim.cmd("colorscheme default")
  vim.opt.background = "light"
  vim.cmd("colorscheme penamiller")
  verify()
  print("Penamiller native colorscheme: all checks passed")
end

local ok, err = pcall(check)
if not ok then
  vim.api.nvim_err_writeln(tostring(err))
  vim.cmd("cquit 1")
else
  vim.cmd("qa!")
end
