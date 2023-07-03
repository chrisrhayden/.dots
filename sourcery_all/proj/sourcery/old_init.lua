-- info {{{
-- based ~~stolen from~~ on Apprentice and Sorcerer:
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

  local function highlight(group, color_vars)
    if group == nil or type(group) ~= "string" then
      print("bad group")
      return
    end

    if type(color_vars) ~= "table" then
      print("bad color table")
      return
    end

    local background = nil
    if color_vars.bg == nil then
      background = "guibg=NONE "
    else
      background = "guibg=" .. color_vars.bg .. " "
    end

    local forground = nil
    if color_vars.fg == nil then
      forground = "guifg=NONE "
    else
      forground = "guifg=" .. color_vars.fg .. " "
    end

    local style = nil
    if color_vars.sy == nil then
      style = "gui=NONE "
    else
      style = "gui=" .. color_vars.sy .. " "
    end

    local special = nil
    if color_vars.sp == nil then
      special = "guisp=NONE "
    else
      special = "guisp=" .. color_vars.sp .. " "
    end

    vim.cmd("highlight " ..
    group .. " " .. background .. forground .. special .. style)
  end

  local function hi_link(from, to)
    vim.cmd("highlight link " .. from .. " " .. to)
  end

  -- }}}

  -- new highlight functions {{{
  local function hl(object)
    assert(object["1"] and object["bg"] and object["fg"],
        "needs group, background and foreground")
  end
  -- }}}

  -- internal {{{
  -- vim ui {{{
  highlight("Normal", { bg = colors.grey_2, fg = colors.grey_5 })
  highlight("LineNr", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("FoldColumn", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("Folded", { bg = colors.grey_1, fg = colors.grey_4 })
  -- highlight("Folded",       colors.grey_1,   colors.olive,   "NONE", "NONE")
  highlight("StatusLine", { bg = colors.purple_1, fg = colors.teal_2 })
  highlight("StatusLineNC", { bg = colors.grey_3, fg = colors.grey_4 })
  highlight("Cursor",
      { bg = colors.grey_5, fg = colors.grey_2, sy = "nocombine,bold" })
  highlight("CursorLine", { bg = colors.grey_1, })
  highlight("CursorLineNr", { bg = colors.grey_1, fg = colors.teal_2 })
  highlight("ColorColumn", { bg = colors.grey_1, })
  highlight("CursorColumn", { bg = colors.grey_1, })
  highlight("SignColumn", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("Visual", { bg = colors.blue_1, fg = colors.grey_1, sy = "bold" })
  highlight("VisualNOS", { fg = colors.red_1 })
  highlight("VertSplit", { bg = colors.grey_1, fg = colors.grey_1 })
  highlight("WinSeparator", { bg = colors.grey_1, fg = colors.purple_1 })
  highlight("TabLine", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("TabLineFill", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("TabLineSel", { bg = colors.grey_1, fg = colors.teal_1 })
  highlight("Pmenu", { bg = colors.grey_1, fg = colors.purple_2, sy = "italic" })
  highlight("PmenuSel",
      { bg = colors.grey_5, fg = colors.grey_1, sy = "nocombine,bold", })
  highlight("PmenuSbar", { bg = colors.grey_1, })
  highlight("PmenuThumb", { bg = colors.grey_5, sy = "nocombine,NONE" })
  highlight("WildMenu", { bg = colors.grey_1, fg = colors.purple_2 })
  -- highlight("NormalFloat", colors.grey_1, colors.purple_2, "NONE", "NONE")
  highlight("NormalFloat", { bg = colors.grey_1, fg = colors.grey_5 })
  highlight("FloatBorder", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("ErrorMsg", { bg = colors.red_1, fg = colors.grey_2 })
  highlight("ModeMsg", { fg = colors.green_1 })
  highlight("MoreMsg", { fg = colors.green_1 })
  highlight("WarningMsg", { fg = colors.red_1 })
  highlight("Question", { fg = colors.teal_1 })
  highlight("Title", { fg = colors.teal_1 })
  highlight("Bold", { sy = "bold" })
  highlight("Italic", { sy = "italic" })
  highlight("Underlined", { sy = "underline" })
  highlight("Search", { bg = colors.blue_1, fg = colors.grey_1 })
  highlight("Substitute", { bg = colors.blue_1, fg = colors.grey_1, sy = "bold" })
  highlight("IncSearch", { bg = colors.blue_1, fg = colors.grey_1 })
  highlight("Directory", { fg = colors.blue_2 })
  highlight("SpecialKey", { fg = colors.grey_4 })
  highlight("Conceal", { fg = colors.blue_2 })
  highlight("NonText", { fg = colors.grey_4 })
  highlight("QuickFixLine", { bg = colors.grey_1, })
  highlight("MatchParen", { bg = colors.grey_4, fg = colors.grey_1, sy = "bold" })
  -- }}}

  -- syntax highlighting {{{
  -- :help group-name -- for the syntax groups
  highlight("Todo", { fg = colors.yellow })
  highlight("Comment", { fg = colors.olive })
  highlight("Statement", { fg = colors.blue_1 })
  highlight("Conditional", { fg = colors.red_2 })
  hi_link("Repeat", "Conditional")
  hi_link("Label", "Conditional")
  highlight("Operator", { fg = colors.grey_5 })
  -- Keyword
  hi_link("Exception", "Conditional")

  highlight("Constant", { fg = colors.orange })
  highlight("String", { fg = colors.green_2 })
  highlight("Character", { fg = colors.red_1 })
  -- Number
  -- Boolean
  -- Float

  highlight("Identifier", { fg = colors.purple_3 })
  highlight("Function", { fg = colors.teal_1 })

  highlight("Type", { fg = colors.purple_2 })
  -- StorageClass
  -- Structure
  -- Typedef

  highlight("PreProc", { fg = colors.grey_4 })
  -- highlight("Include",      "NONE", colors.teal_1, "NONE", "NONE")
  -- PreCondit
  -- hi_link("Define",         "Include")
  -- highlight("Include",      "NONE", colors.teal_1, "NONE", "NONE")
  highlight("Macro", { fg = colors.teal_1 })
  -- hi_link("Macro",          "Include")

  highlight("Special", { fg = colors.blue_2 })

  highlight("SpecialChar", { fg = colors.grey_4 })
  -- Tag
  -- Delimiter
  hi_link("SpecialComment", "SpecialChar")
  -- Debug

  highlight("Error", { fg = colors.red_1 })
  -- }}}

  -- diff {{{
  -- this is better for sure
  highlight("DiffAdd", { fg = colors.green_1 })
  highlight("DiffChange", { fg = colors.grey_4 })
  highlight("DiffDelete", { fg = colors.red_1 })
  highlight("DiffText", { fg = colors.teal_1 })
  highlight("DiffAdded", { fg = colors.green_1 })
  highlight("DiffFile", { fg = colors.red_1 })
  highlight("DiffNewFile", { fg = colors.green_1 })
  highlight("DiffLine", { fg = colors.teal_1 })
  highlight("DiffRemoved", { fg = colors.red_1 })
  -- }}}

  -- debug {{{
  highlight("debugBreakpoint", { bg = colors.teal_1, fg = colors.grey_1 })
  highlight("debugPC", { bg = colors.teal_1, fg = colors.grey_1 })
  -- }}}

  -- spelling {{{
  highlight("SpellBad", { sy = "undercurl", sp = colors.red_1 })
  -- highlight("SpellLocal", {})
  -- highlight("SpellCap", { bg = colors.blue_1 })
  -- vim.cmd("highlight clear SpellCap")
  -- vim.cmd("highlight SpellCap NONE")
  -- highlight("SpellRare", {})
  -- }}}

  -- neovim {{{
  vim.cmd([[
  augroup HighlightYanked
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
  augroup END
  ]])

  highlight("NvimInternalError", { fg = colors.red_1 })

  highlight("DiagnosticError", { fg = colors.red_1 })

  highlight("DiagnosticDefaultHint", { fg = colors.grey_4 })
  highlight("DiagnosticDefaultInfo", { fg = colors.teal_2 })
  highlight("DiagnosticDefaultWarn", { fg = colors.orange })
  -- highlight("DiagnosticSignHint", { bg = colors.grey_1, fg = colors.grey_4 })
  highlight("DiagnosticSignError", { bg = colors.grey_1, fg = colors.red_1 })
  -- highlight("DiagnosticSignInfo", { bg = colors.grey_1, fg = colors.teal_2 })
  -- highlight("DiagnosticSignWarn", { bg = colors.grey_1, fg = colors.orange })
  -- }}}

  -- treesitter {{{
  -- highlight("TSConstBuiltin", { fg = colors.orange })
  -- highlight("@constant.builtin", { fg = colors.blue_2 })
  -- highlight("@constant", { fg = colors.blue_2 })
  -- highlight("TSVariable", { fg = colors.grey_5 })
  -- highlight("TSField", "NONE", colors.purple_3, "NONE", "NONE")
  -- hi_link("TSField", "TSVariable")
  -- highlight("TSPunctBracket", "NONE", colors.grey_5, "NONE", "NONE")
  -- hi_link("TSPunctDelimiter", "TSPunctBracket")
  -- highlight("TSNamespace", "NONE", colors.blue_2, "NONE", "NONE")
  -- }}}
  -- }}}

  -- LspSaga {{{
  highlight("LspFloatWinNormal", { bg = colors.grey_1, fg = colors.grey_5 })

  highlight("LspSagaCodeActionContent", { fg = colors.grey_5 })
  highlight("LspSagaCodeActionTitle", { fg = colors.blue_1 })

  hi_link("LspFloatWinBorder", "FloatBorder")
  hi_link("LspSagaCodeActionBorder", "LspFloatWinBorder")
  hi_link("LspSagaRenameBorder", "LspFloatWinBorder")
  highlight("LspSagaRenamePromptPrefix",
      { bg = colors.grey_1, fg = colors.purple_3 })
  -- }}}

  -- rust {{{
  -- this is weird, i guess it kinda makes sense, or at least it stands out
  hi_link("rustQuestionMark", "Constant")
  hi_link("rustAssert", "Macro")
  hi_link("rustPanic", "Macro")
  -- hi_link("rustEnumVariant", "Type")

  -- rust.vim is right but this way it stays consistent with the while derive lien
  hi_link("rustDeriveTrait", "PreProc")
  -- }}}

  -- vim {{{
  -- idk why this isn't the fucking default
  hi_link("vimFunction", "Function")
  hi_link("vimUserFunc", "Function")
  -- }}}

  -- telescope {{{
  highlight("TelescopeSelection", { fg = colors.orange, sy = "bold" })
  -- highlight("TelescopeSelectionCaret", "NONE", colors.purple_3, "bold", "NONE")
  hi_link("TelescopeSelectionCaret", "TelescopeSelection")
  highlight("TelescopeMultiSelection", { fg = colors.grey_5 })
  -- highlight("TelescopeNormal", colors.grey_2, "NONE", "NONE", "NONE")
  hi_link("TelescopeNormal", "Normal")

  -- Border highlight groups
  highlight("TelescopeBorder", { bg = colors.grey_2, fg = colors.grey_5 })
  -- highlight("TelescopePromptBorder", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopeResultsBorder", "NONE", colors.grey_5, "NONE", "NONE")
  -- highlight("TelescopePreviewBorder", "NONE", colors.grey_5, "NONE", "NONE")

  -- Highlight characters your input matches
  highlight("TelescopeMatching", { fg = colors.teal_2, sy = "bold" })

  -- Color the prompt prefix
  -- highlight ("TelescopePromptPrefix", colors.grey_2, colors.purple_3, "bold", "NONE")
  hi_link("TelescopePromptPrefix", "Normal")
  -- }}}

  -- orgmode {{{
  highlight("org_hyperlink", { fg = colors.blue_2 })
  highlight("org_hyperlinkURL", { fg = colors.blue_2 })
  highlight("org_hyperlinkBracketsLeft ", { fg = colors.blue_2 })
  highlight("org_hyperlinkBracketsRight ", { fg = colors.blue_2 })

  highlight("OrgTSCheckbox", { fg = colors.purple_3 })

  highlight("OrgHeadlineLevel1", { fg = colors.teal_1 })
  highlight("OrgHeadlineLevel2", { fg = colors.purple_2 })
  highlight("OrgHeadlineLevel3", { fg = colors.blue_2 })
  highlight("OrgHeadlineLevel4", { fg = colors.purple_3 })
  highlight("OrgHeadlineLevel5", { fg = colors.red_2 })
  highlight("OrgHeadlineLevel6", { fg = colors.teal_1 })
  highlight("OrgHeadlineLevel7", { fg = colors.purple_2 })
  highlight("OrgHeadlineLevel8", { fg = colors.blue_2 })
  -- }}}

  -- wilder {{{
  highlight("FloatBorder",
      { bg = colors.grey_1, fg = colors.grey_4, sy = "nocombine,NONE" })
  -- }}}

  -- mini {{{
  highlight("MiniCursorword", { bg = colors.grey_3, })
  -- highlight("MiniCursorword", colors.grey_3, "nocombine,NONE", "nocombine,NONE", "nocombine,NONE")

  -- trailing white space {{{
  highlight("MiniTrailspace", { fg = "nocombine,NONE" })
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
  highlight("gitcommitOverflow", { fg = colors.red_1 })
  highlight("gitcommitSummary", { fg = colors.green_1 })
  highlight("gitcommitComment", { fg = colors.grey_4 })
  highlight("gitcommitUntracked", { fg = colors.grey_4 })
  highlight("gitcommitDiscarded", { fg = colors.grey_4 })
  highlight("gitcommitSelected", { fg = colors.grey_4 })
  highlight("gitcommitHeader", { fg = colors.red_2 })
  highlight("gitcommitSelectedType", { fg = colors.teal_1 })
  highlight("gitcommitUnmergedType", { fg = colors.teal_1 })
  highlight("gitcommitDiscardedType", { fg = colors.teal_1 })
  highlight("gitcommitBranch", { fg = colors.orange, sy = "bold" })
  highlight("gitcommitUntrackedFile", { fg = colors.yellow })
  highlight("gitcommitUnmergedFile", { fg = colors.red_1, sy = "bold" })
  highlight("gitcommitDiscardedFile", { fg = colors.red_1, sy = "bold" })
  highlight("gitcommitSelectedFile", { fg = colors.green_1, sy = "bold" })
  highlight("GitGutterAdd", { bg = colors.grey_1, fg = colors.green_1 })
  highlight("GitGutterChange", { bg = colors.grey_1, fg = colors.teal_1 })
  highlight("GitGutterDelete", { bg = colors.grey_1, fg = colors.red_1 })
  highlight("GitGutterChangeDelete", { bg = colors.grey_1, fg = colors.red_2 })
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
