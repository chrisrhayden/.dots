-- info {{{
-- based (stolen from) on Apprentice and Sorcerer:
-- https://github.com/romainl/Apprentice
-- https://www.vim.org/scripts/script.php?script_id=3299
-- }}}

-- TODO: do something with term colors

function SourceryColor()
  -- colors {{{
  local colors = {
    grey_1 = "#0f0f0f", -- darker grey, line number background
    grey_2 = "#191919", -- dark grey, normal background
    grey_3 = "#232323", -- less dark grey, for statuslinenc
    grey_4 = "#6c6c6c", -- normal grey, linenum etc
    grey_5 = "#bcbcbc", -- light grey, normal text
    olive = "#686858", -- olive greenish / greyish, comments
    blue_1 = "#819cbe", -- light blue
    blue_2 = "#50789f", -- blue
    green_1 = "#5f875f", -- dark green
    green_2 = "#7aa37a", -- light green
    teal_1 = "#6a9696", -- dark teal
    teal_2 = "#5fafaf", -- light teal
    purple_1 = "#2b242e", -- very dark purple
    purple_2 = "#785d92", -- dark purple
    purple_3 = "#896680", -- light purple
    red_1 = "#af5f5f", -- red
    red_2 = "#af5f87", -- pink red
    orange = "#d88527", -- orange
    yellow = "#ffffaf", -- yellow
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
  local function highlight(group, bg, fg, sy, sp)
    bg = "guibg=" .. bg
    fg = "guifg=" .. fg
    sy = "gui=" .. sy
    sp = "guisp=" .. sp

    vim.cmd(
      "highlight " .. group .. " " .. bg .. " " .. fg .. " " .. sy .. " " .. sp
    )
  end

  local function hi_link(from, to)
    vim.cmd("highlight link " .. from .. " " .. to)
  end

  -- }}}

  -- internal {{{
  -- vim ui {{{
  highlight("Normal", colors.grey_2, colors.grey_5, "NONE", "NONE")
  highlight("LineNr", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("FoldColumn", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("Folded", colors.grey_1, colors.grey_4, "NONE", "NONE")
  -- highlight("Folded",       colors.grey_1,   colors.olive,   "NONE", "NONE")
  highlight("StatusLine", colors.purple_1, colors.teal_2, "NONE", "NONE")
  highlight("StatusLineNC", colors.grey_3, colors.grey_4, "NONE", "NONE")
  highlight("Cursor", colors.grey_5, colors.grey_2, "nocombine,bold", "NONE")
  highlight("CursorLine", colors.grey_1, "NONE", "NONE", "NONE")
  highlight("CursorLineNr", colors.grey_1, colors.teal_2, "NONE", "NONE")
  highlight("ColorColumn", colors.grey_1, "NONE", "NONE", "NONE")
  highlight("CursorColumn", colors.grey_1, "NONE", "NONE", "NONE")
  highlight("SignColumn", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("Visual", colors.blue_1, colors.grey_1, "bold", "NONE")
  highlight("VisualNOS", "NONE", colors.red_1, "NONE", "NONE")
  highlight("VertSplit", colors.grey_1, colors.grey_1, "NONE", "NONE")
  highlight("TabLine", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("TabLineFill", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("TabLineSel", colors.grey_1, colors.teal_1, "NONE", "NONE")
  highlight("Pmenu", colors.grey_1, colors.purple_2, "italic", "NONE")
  highlight("PmenuSel", colors.grey_5, colors.grey_1, "nocombine,bold", "NONE")
  highlight("PmenuSbar", colors.grey_1, "NONE", "NONE", "NONE")
  highlight("PmenuThumb", colors.grey_5, "NONE", "nocombine,NONE", "NONE")
  highlight("WildMenu", colors.grey_1, colors.purple_2, "NONE", "NONE")
  -- highlight("NormalFloat", colors.grey_1, colors.purple_2, "NONE", "NONE")
  highlight("NormalFloat", colors.grey_1, colors.grey_5, "NONE", "NONE")
  highlight("FloatBorder", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("ErrorMsg", colors.red_1, colors.grey_2, "NONE", "NONE")
  highlight("ModeMsg", "NONE", colors.green_1, "NONE", "NONE")
  highlight("MoreMsg", "NONE", colors.green_1, "NONE", "NONE")
  highlight("WarningMsg", "NONE", colors.red_1, "NONE", "NONE")
  highlight("Question", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("Title", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("Bold", "NONE", "NONE", "bold", "NONE")
  highlight("Italic", "NONE", "NONE", "italic", "NONE")
  highlight("Underlined", "NONE", "NONE", "underline", "NONE")
  highlight("Search", colors.blue_1, colors.grey_1, "NONE", "NONE")
  highlight("Substitute", colors.blue_1, colors.grey_1, "bold", "NONE")
  highlight("IncSearch", colors.blue_1, colors.grey_1, "NONE", "NONE")
  highlight("Directory", "NONE", colors.blue_2, "NONE", "NONE")
  highlight("SpecialKey", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("Conceal", "NONE", colors.blue_2, "NONE", "NONE")
  highlight("NonText", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("QuickFixLine", colors.grey_1, "NONE", "NONE", "NONE")
  highlight("MatchParen", colors.grey_4, colors.grey_1, "bold", "NONE")
  -- }}}

  -- syntax highlighting {{{
  -- :help group-name -- for the syntax groups
  highlight("Todo", "NONE", colors.yellow, "NONE", "NONE")
  highlight("Comment", "NONE", colors.olive, "NONE", "NONE")
  highlight("Statement", "NONE", colors.blue_1, "NONE", "NONE")
  highlight("Conditional", "NONE", colors.red_2, "NONE", "NONE")
  hi_link("Repeat", "Conditional")
  hi_link("Label", "Conditional")
  highlight("Operator", "NONE", colors.grey_5, "NONE", "NONE")
  -- Keyword
  hi_link("Exception", "Conditional")

  highlight("Constant", "NONE", colors.orange, "NONE", "NONE")
  highlight("String", "NONE", colors.green_2, "NONE", "NONE")
  highlight("Character", "NONE", colors.red_1, "NONE", "NONE")
  -- Number
  -- Boolean
  -- Float

  highlight("Identifier", "NONE", colors.purple_3, "NONE", "NONE")
  highlight("Function", "NONE", colors.teal_1, "NONE", "NONE")

  highlight("Type", "NONE", colors.purple_2, "NONE", "NONE")
  -- StorageClass
  -- Structure
  -- Typedef

  highlight("PreProc", "NONE", colors.grey_4, "NONE", "NONE")
  -- highlight("Include",      "NONE", colors.teal_1, "NONE", "NONE")
  -- PreCondit
  -- hi_link("Define",         "Include")
  -- highlight("Include",      "NONE", colors.teal_1, "NONE", "NONE")
  highlight("Macro", "NONE", colors.teal_1, "NONE", "NONE")
  -- hi_link("Macro",          "Include")

  highlight("Special", "NONE", colors.blue_2, "NONE", "NONE")

  highlight("SpecialChar", "NONE", colors.grey_4, "NONE", "NONE")
  -- Tag
  -- Delimiter
  hi_link("SpecialComment", "SpecialChar")
  -- Debug

  highlight("Error", "NONE", colors.red_1, "NONE", "NONE")
  -- }}}

  -- diff {{{
  -- this is better for sure
  highlight("DiffAdd", "NONE", colors.green_1, "NONE", "NONE")
  highlight("DiffChange", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("DiffDelete", "NONE", colors.red_1, "NONE", "NONE")
  highlight("DiffText", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("DiffAdded", "NONE", colors.green_1, "NONE", "NONE")
  highlight("DiffFile", "NONE", colors.red_1, "NONE", "NONE")
  highlight("DiffNewFile", "NONE", colors.green_1, "NONE", "NONE")
  highlight("DiffLine", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("DiffRemoved", "NONE", colors.red_1, "NONE", "NONE")
  -- }}}

  -- debug {{{
  highlight("debugBreakpoint", colors.teal_1, colors.grey_1, "NONE", "NONE")
  highlight("debugPC", colors.teal_1, colors.grey_1, "NONE", "NONE")
  -- }}}

  -- spelling {{{
  highlight("SpellBad", "NONE", "NONE", "undercurl", colors.red_1)
  highlight("SpellLocal", "NONE", "NONE", "NONE", "NONE")
  highlight("SpellCap", "NONE", "NONE", "NONE", "NONE")
  highlight("SpellRare", "NONE", "NONE", "NONE", "NONE")
  -- }}}

  -- neovim {{{
  vim.cmd([[
  augroup HighlightYanked
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
  augroup END
  ]])

  highlight("NvimInternalError", "NONE", colors.red_1, "NONE", "NONE")

  highlight("DiagnosticDefaultHint", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("DiagnosticDefaultError", "NONE", colors.red_1, "NONE", "NONE")
  highlight("DiagnosticDefaultInfo", "NONE", colors.teal_2, "NONE", "NONE")
  highlight("DiagnosticDefaultWarn", "NONE", colors.orange, "NONE", "NONE")

  highlight("DiagnosticSignHint", colors.grey_1, colors.grey_4, "NONE", "NONE")
  highlight("DiagnosticSignError", colors.grey_1, colors.red_1, "NONE", "NONE")
  highlight("DiagnosticSignInfo", colors.grey_1, colors.teal_2, "NONE", "NONE")
  highlight("DiagnosticSignWarn", colors.grey_1, colors.orange, "NONE", "NONE")
  -- }}}

  -- treesitter {{{
  highlight("TSConstBuiltin", "NONE", colors.orange, "NONE", "NONE")
  highlight("TSVariable", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TSField", "NONE", colors.purple_3, "NONE", "NONE")
  hi_link("TSField", "TSVariable")
  -- highlight("TSPunctBracket", "NONE", colors.grey_5, "NONE", "NONE")
  -- hi_link("TSPunctDelimiter", "TSPunctBracket")
  -- highlight("TSNamespace", "NONE", colors.blue_2, "NONE", "NONE")
  -- }}}
  -- }}}

  -- LspSaga {{{
  highlight("LspFloatWinNormal", colors.grey_1, colors.grey_5, "NONE", "NONE")

  highlight("LspSagaCodeActionContent", "NONE", colors.grey_5, "NONE", "NONE")
  highlight("LspSagaCodeActionTitle", "NONE", colors.blue_1, "NONE", "NONE")

  hi_link("LspFloatWinBorder", "FloatBorder")
  hi_link("LspSagaCodeActionBorder", "LspFloatWinBorder")
  hi_link("LspSagaRenameBorder", "LspFloatWinBorder")
  highlight("LspSagaRenamePromptPrefix", colors.grey_1, colors.purple_3, "NONE", "NONE")
  -- }}}

  -- rust {{{
  -- this is weird, i guess it kinda makes sense, or at least it stands out
  hi_link("rustQuestionMark", "Constant")
  hi_link("rustAssert", "Macro")
  hi_link("rustPanic", "Macro")
  hi_link("rustEnumVariant", "Type")

  -- rust.vim is right but this way it stays consistent with the while derive lien
  hi_link("rustDeriveTrait", "PreProc")
  -- }}}

  -- vim {{{
  -- idk why this isn't the fucking default
  hi_link("vimFunction", "Function")
  hi_link("vimUserFunc", "Function")
  -- }}}

  -- telescope {{{
  highlight("TelescopeSelection", "NONE", colors.orange, "bold", "NONE")
  -- highlight("TelescopeSelectionCaret", "NONE", colors.purple_3, "bold", "NONE")
  hi_link("TelescopeSelectionCaret", "TelescopeSelection")
  highlight("TelescopeMultiSelection", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopeNormal", colors.grey_2, "NONE", "NONE", "NONE")
  hi_link("TelescopeNormal", "Normal")

  -- Border highlight groups
  highlight("TelescopeBorder", colors.grey_2, colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopePromptBorder", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopeResultsBorder", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopePreviewBorder", "NONE", colors.grey_5, "NONE", "NONE")

  -- Highlight characters your input matches
  highlight("TelescopeMatching", "NONE", colors.teal_2, "bold", "NONE")

  -- Color the prompt prefix
  -- highlight ("TelescopePromptPrefix", colors.grey_2, colors.purple_3, "bold", "NONE")
  hi_link("TelescopePromptPrefix", "Normal")
  -- }}}

  -- orgmode {{{
  highlight("org_hyperlink", "NONE", colors.blue_2, "NONE", "NONE")
  highlight("org_hyperlinkURL", "NONE", colors.blue_2, "NONE", "NONE")
  highlight("org_hyperlinkBracketsLeft ", "NONE", colors.blue_2, "NONE", "NONE")
  highlight(
    "org_hyperlinkBracketsRight ",
    "NONE",
    colors.blue_2,
    "NONE",
    "NONE"
  )

  highlight("OrgTSCheckbox", "NONE", colors.purple_3, "NONE", "NONE")

  highlight("OrgHeadlineLevel1", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("OrgHeadlineLevel2", "NONE", colors.purple_2, "NONE", "NONE")
  highlight("OrgHeadlineLevel3", "NONE", colors.blue_2, "NONE", "NONE")
  highlight("OrgHeadlineLevel4", "NONE", colors.purple_3, "NONE", "NONE")
  highlight("OrgHeadlineLevel5", "NONE", colors.red_2, "NONE", "NONE")
  highlight("OrgHeadlineLevel6", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("OrgHeadlineLevel7", "NONE", colors.purple_2, "NONE", "NONE")
  highlight("OrgHeadlineLevel8", "NONE", colors.blue_2, "NONE", "NONE")
  -- }}}

  -- wilder {{{
  highlight(
    "FloatBorder",
    colors.grey_1,
    colors.grey_4,
    "nocombine,NONE",
    "NONE"
  )
  -- }}}

  -- mini {{{
  highlight("MiniCursorword", colors.grey_3, "NONE", "NONE", "NONE")
  -- highlight("MiniCursorword", colors.grey_3, "nocombine,NONE", "nocombine,NONE", "nocombine,NONE")

  -- trailing white space {{{
  highlight("MiniTrailspace", "NONE", "nocombine,NONE", "NONE", "NONE")
  -- }}}
  -- }}}

  -- sh / shell {{{
  -- why does this link to preproc
  hi_link("shShellVariables", "Identifier")
  -- }}}

  -- python {{{
  hi_link("pythonOperator", "Special")
  -- }}}

  -- git {{{
  highlight("gitcommitOverflow", "NONE", colors.red_1, "NONE", "NONE")
  highlight("gitcommitSummary", "NONE", colors.green_1, "NONE", "NONE")
  highlight("gitcommitComment", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("gitcommitUntracked", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("gitcommitDiscarded", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("gitcommitSelected", "NONE", colors.grey_4, "NONE", "NONE")
  highlight("gitcommitHeader", "NONE", colors.red_2, "NONE", "NONE")
  highlight("gitcommitSelectedType", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("gitcommitUnmergedType", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("gitcommitDiscardedType", "NONE", colors.teal_1, "NONE", "NONE")
  highlight("gitcommitBranch", "NONE", colors.orange, "bold", "NONE")
  highlight("gitcommitUntrackedFile", "NONE", colors.yellow, "NONE", "NONE")
  highlight("gitcommitUnmergedFile", "NONE", colors.red_1, "bold", "NONE")
  highlight("gitcommitDiscardedFile", "NONE", colors.red_1, "bold", "NONE")
  highlight("gitcommitSelectedFile", "NONE", colors.green_1, "bold", "NONE")
  highlight("GitGutterAdd", colors.grey_1, colors.green_1, "NONE", "NONE")
  highlight("GitGutterChange", colors.grey_1, colors.teal_1, "NONE", "NONE")
  highlight("GitGutterDelete", colors.grey_1, colors.red_1, "NONE", "NONE")
  highlight(
    "GitGutterChangeDelete",
    colors.grey_1,
    colors.red_2,
    "NONE",
    "NONE"
  )
  -- }}}

  -- html {{{
  hi_link("htmlLink", "Special")
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
end

-- vim: foldmethod=marker
