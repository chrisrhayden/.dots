-- info {{{
-- based ~~stolen from~~ on Apprentice and Sorcerer:
-- https://github.com/romainl/Apprentice
-- https://www.vim.org/scripts/script.php?script_id=3299
-- }}}

-- TODO: do something with term colors
function SourceryColor()
  -- colors {{{
  local colors = {
    grey_1   = "#0f0f0f", -- darker grey, line number background
    grey_2   = "#191919", -- dark grey, normal background
    grey_3   = "#232323", -- less dark grey, for statuslinenc
    grey_4   = "#6c6c6c", -- normal grey, linenum etc
    grey_5   = "#bcbcbc", -- light grey, normal text
    olive    = "#686858", -- olive greenish / greyish, comments
    blue_1   = "#819cbe", -- light blue
    blue_2   = "#50789f", -- blue
    green_1  = "#5f875f", -- dark green
    green_2  = "#7aa37a", -- light green
    teal_1   = "#6a9696", -- dark teal
    teal_2   = "#5fafaf", -- light teal
    purple_1 = "#2b242e", -- very dark purple
    purple_2 = "#785d92", -- dark purple
    purple_3 = "#896680", -- light purple
    red_1    = "#af5f5f", -- red
    red_2    = "#af5f87", -- pink red
    orange   = "#d88527", -- orange
    yellow   = "#ffffaf", -- yellow
  }
  -- }}}

  -- reset highlighting {{{
  -- despite these settings vim can mess up colors when switching color schemes
  vim.o.background = "dark"
  -- reset all highlighting to the defaults
  vim.cmd("highlight clear")

  -- if syntax has been enabled reset to defaults
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  -- }}}

  -- highlight functions {{{

  ---call `highlight` for a given group
  ---
  ---@param object table
  local function hl(object)
    local group = object[1] .. " "
    local background = "guibg=NONE "
    local forground = "guifg=NONE "
    local style = "gui=NONE "
    local special = "guisp=NONE "

    if object.bg then
      background = "guibg=" .. object.bg .. " "
    end

    if object.fg then
      forground = "guifg=" .. object.fg .. " "
    end

    if object.sy then
      style = "gui=" .. object.sy .. " "
    end

    if object.sp then
      special = "guisp=" .. object.sp .. " "
    end

    vim.cmd("highlight " .. group .. background .. forground .. special .. style)
  end

  local function hl_link(from, to)
    vim.cmd("highlight link " .. from .. " " .. to)
  end

  local function hl_clear(group)
    vim.cmd("highlight clear " .. group)
  end
  -- }}}

  -- internal {{{
  -- nvim ui {{{
  hl { "Normal", bg = colors.grey_2, fg = colors.grey_5 }
  hl { "LineNr", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "Folded", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "FoldColumn", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "StatusLine", bg = colors.purple_1, fg = colors.teal_2 }
  hl { "StatusLineNC", bg = colors.grey_3, fg = colors.grey_4 }
  hl { "Cursor", bg = colors.grey_5, fg = colors.grey_2, sy = "nocombine,bold" }
  hl { "CursorLine", bg = colors.grey_1, }
  hl { "CursorLineNr", bg = colors.grey_1, fg = colors.teal_2 }
  hl { "ColorColumn", bg = colors.grey_1, }
  hl { "CursorColumn", bg = colors.grey_1, }
  hl { "SignColumn", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "Visual", bg = colors.blue_1, fg = colors.grey_1, sy = "bold" }
  hl { "VisualNOS", fg = colors.red_1 }
  hl { "VertSplit", bg = colors.grey_1, fg = colors.grey_1 }
  hl { "WinSeparator", bg = colors.grey_1, fg = colors.purple_1 }
  hl { "TabLine", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "TabLineFill", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "TabLineSel", bg = colors.grey_1, fg = colors.teal_1 }
  hl { "Pmenu", bg = colors.grey_1, fg = colors.purple_2, sy = "italic" }
  hl { "PmenuSel", bg = colors.grey_5, fg = colors.grey_1, sy = "nocombine,bold", }
  hl { "PmenuSbar", bg = colors.grey_1, }
  hl { "PmenuThumb", bg = colors.grey_5, sy = "nocombine,NONE" }
  hl { "WildMenu", bg = colors.grey_1, fg = colors.purple_2 }
  hl { "NormalFloat", bg = colors.grey_1, fg = colors.grey_5 }
  hl { "FloatBorder", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "ErrorMsg", bg = colors.red_1, fg = colors.grey_2 }
  hl { "ModeMsg", fg = colors.green_1 }
  hl { "MoreMsg", fg = colors.green_1 }
  hl { "WarningMsg", fg = colors.red_1 }
  hl { "Question", fg = colors.teal_1 }
  hl { "Title", fg = colors.teal_1 }
  hl { "Bold", sy = "bold" }
  hl { "Italic", sy = "italic" }
  hl { "Underlined", sy = "underline" }
  hl { "Search", bg = colors.blue_1, fg = colors.grey_1 }
  hl { "Substitute", bg = colors.blue_1, fg = colors.grey_1, sy = "bold" }
  hl { "IncSearch", bg = colors.blue_1, fg = colors.grey_1 }
  hl { "Directory", fg = colors.blue_2 }
  hl { "SpecialKey", fg = colors.grey_4 }
  hl { "Conceal", fg = colors.blue_2 }
  hl { "NonText", fg = colors.grey_4 }
  hl { "QuickFixLine", bg = colors.grey_1, }
  hl { "MatchParen", bg = colors.grey_4, fg = colors.grey_1, sy = "bold" }
  -- }}}

  -- syntax highlighting {{{
  -- :help group-name -- for the syntax groups
  hl { "Comment", fg = colors.olive }

  -- Constant group
  hl { "Constant", fg = colors.orange }
  hl { "String", fg = colors.green_2 }
  hl { "Character", fg = colors.red_1 }

  -- Statement group
  hl { "Statement", fg = colors.red_2 }
  hl { "Operator", fg = colors.grey_5 }
  hl { "Keyword", fg = colors.blue_1 }

  -- Identifier group
  hl { "Identifier", fg = colors.purple_3 }
  hl { "Function", fg = colors.teal_1 }

  -- PreProc group
  hl { "PreProc", fg = colors.grey_4 }
  hl { "Macro", fg = colors.teal_1 }

  -- Type group
  hl { "Type", fg = colors.purple_2 }

  -- Special group
  hl { "Special", fg = colors.blue_2 }
  hl { "SpecialChar", fg = colors.grey_4 }
  hl_link("SpecialComment", "SpecialChar")

  hl { "Error", fg = colors.red_1 }

  hl { "Todo", fg = colors.yellow }
  -- }}}

  -- diagnostics {{{
  hl { "DiagnosticError", fg = colors.red_1 }
  hl { "DiagnosticHint", fg = colors.grey_4 }
  hl { "DiagnosticInfo", fg = colors.teal_2 }
  hl { "DiagnosticWarn", fg = colors.orange }

  hl { "DiagnosticSignHint", bg = colors.grey_1, fg = colors.grey_4 }
  hl { "DiagnosticSignError", bg = colors.grey_1, fg = colors.red_1 }
  hl { "DiagnosticSignInfo", bg = colors.grey_1, fg = colors.teal_2 }
  hl { "DiagnosticSignWarn", bg = colors.grey_1, fg = colors.orange }
  -- }}}

  -- treesitter {{{
  -- treesitter links to appropriate groups
  -- hl { "@comment", fg = colors.grey_1 }
  -- }}}

  -- lsp {{{
  hl { "@documentation", fg = colors.grey_4 }
  -- hl { "@documentation", fg = colors.purple_1 }
  -- }}}

  -- diff {{{
  -- this is better for sure
  hl { "DiffAdd", fg = colors.green_1 }
  hl { "DiffChange", fg = colors.grey_4 }
  hl { "DiffDelete", fg = colors.red_1 }
  hl { "DiffText", fg = colors.teal_1 }
  hl { "DiffAdded", fg = colors.green_1 }
  hl { "DiffFile", fg = colors.red_1 }
  hl { "DiffNewFile", fg = colors.green_1 }
  hl { "DiffLine", fg = colors.teal_1 }
  hl { "DiffRemoved", fg = colors.red_1 }
  -- }}}

  -- debug {{{
  hl { "debugBreakpoint", bg = colors.teal_1, fg = colors.grey_1 }
  hl { "debugPC", bg = colors.teal_1, fg = colors.grey_1 }
  -- }}}

  -- spelling {{{
  hl { "SpellBad", sy = "undercurl", sp = colors.red_1 }
  hl_clear("SpellLocal")
  hl_clear("SpellCap")
  hl_clear("SpellRare")
  -- }}}

  -- misc {{{
  -- most hl-Nvim* highlights are linked to something
  hl { "NvimInternalError", fg = colors.red_1 }

  vim.cmd([[
    augroup HighlightYanked
      autocmd!
      autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()
    augroup END
  ]])
  -- }}}

  -- terminal colors {{{
  -- see terminal-configuration
  vim.g.terminal_color_0 = colors.grey_1
  vim.g.terminal_color_1 = colors.red_1
  vim.g.terminal_color_2 = colors.green_2
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue_2
  vim.g.terminal_color_5 = colors.purple_3
  vim.g.terminal_color_6 = colors.teal_2
  vim.g.terminal_color_7 = colors.grey_5
  -- }}}
  -- }}}

  -- plugins {{{
  -- telescope {{{
  hl { "TelescopeSelection", fg = colors.orange, sy = "bold" }
  hl { "TelescopeNormal", bg = colors.grey_1 }
  hl { "TelescopeBorder", bg = colors.grey_1, fg = colors.grey_5 }
  -- }}}

  -- mini {{{
  hl { "MiniCursorword", bg = colors.grey_3, }
  hl { "MiniTrailspace", fg = "nocombine,NONE" }
  -- }}}

  -- orgmode {{{
  -- }}}
  -- }}}
end

-- vim: foldmethod=marker nospell:
