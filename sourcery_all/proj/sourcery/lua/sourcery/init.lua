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

  -- highlight function {{{

  ---call `highlight` for a given group
  ---
  ---@param objects table a table of highlights
  local function hl_all(objects)
    assert(type(objects) == "table", "did not get a table to hi_all")

    for _, object in ipairs(objects) do
      assert(type(object) == "table", "did not get a table in hl objects")

      if object[1] == "link" then
        vim.cmd("highlight link " .. object[2] .. " " .. object[3])
        goto continue
      elseif object[1] == "clear" then
        vim.cmd("highlight clear " .. object[2])
        goto continue
      end

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

      vim.cmd("highlight " ..
        group .. background .. forground .. special .. style)

      ::continue::
    end
  end


  -- }}}

  -- internal {{{
  -- nvim ui {{{
  hl_all {
    { "Normal",       bg = colors.grey_2,   fg = colors.grey_5 },
    { "LineNr",       bg = colors.grey_1,   fg = colors.grey_4 },
    { "Folded",       bg = colors.grey_1,   fg = colors.grey_4 },
    { "FoldColumn",   bg = colors.grey_1,   fg = colors.grey_4 },
    { "StatusLine",   bg = colors.purple_1, fg = colors.teal_2 },
    { "StatusLineNC", bg = colors.grey_3,   fg = colors.grey_4 },
    {
      "Cursor",
      bg = colors.grey_5,
      fg = colors.grey_2,
      sy =
      "nocombine,bold"
    },
    { "CursorLine",   bg = colors.grey_1, },
    { "CursorLineNr", bg = colors.grey_1, fg = colors.teal_2 },
    { "ColorColumn",  bg = colors.grey_1, },
    { "CursorColumn", bg = colors.grey_1, },
    { "SignColumn",   bg = colors.grey_1, fg = colors.grey_4 },
    { "Visual",       bg = colors.blue_1, fg = colors.grey_1,   sy = "bold" },
    { "VisualNOS",    fg = colors.red_1 },
    { "VertSplit",    bg = colors.grey_1, fg = colors.grey_1 },
    { "WinSeparator", bg = colors.grey_1, fg = colors.purple_1 },
    { "TabLine",      bg = colors.grey_1, fg = colors.grey_4 },
    { "TabLineFill",  bg = colors.grey_1, fg = colors.grey_4 },
    { "TabLineSel",   bg = colors.grey_1, fg = colors.teal_1 },
    { "Pmenu",        bg = colors.grey_1, fg = colors.purple_2, sy = "italic" },
    {
      "PmenuSel",
      bg = colors.grey_5,
      fg = colors.grey_1,
      sy =
      "nocombine,bold",
    },
    { "PmenuSbar",   bg = colors.grey_1, },
    { "PmenuThumb",  bg = colors.grey_5, sy = "nocombine,NONE" },
    { "WildMenu",    bg = colors.grey_1, fg = colors.purple_2 },
    { "NormalFloat", bg = colors.grey_1, fg = colors.grey_5 },
    { "FloatBorder", bg = colors.grey_1, fg = colors.grey_4 },
    { "ErrorMsg",    bg = colors.red_1,  fg = colors.grey_2 },
    { "ModeMsg",     fg = colors.green_1 },
    { "MoreMsg",     fg = colors.green_1 },
    { "WarningMsg",  fg = colors.red_1 },
    { "Question",    fg = colors.teal_1 },
    { "Title",       fg = colors.teal_1 },
    { "Bold",        sy = "bold" },
    { "Italic",      sy = "italic" },
    { "Underlined",  sy = "underline" },
    { "Search",      bg = colors.blue_1, fg = colors.grey_1 },
    {
      "Substitute",
      bg = colors.blue_1,
      fg = colors.grey_1,
      sy =
      "bold"
    },
    { "IncSearch",    bg = colors.blue_1, fg = colors.grey_1 },
    { "Directory",    fg = colors.blue_2 },
    { "SpecialKey",   fg = colors.grey_4 },
    { "Conceal",      fg = colors.blue_2 },
    { "NonText",      fg = colors.grey_4 },
    { "QuickFixLine", bg = colors.grey_1, },
    {
      "MatchParen",
      bg = colors.grey_4,
      fg = colors.grey_1,
      sy =
      "bold"
    },
    -- }}}

    -- syntax highlighting {{{
    -- :help group-name -- for the syntax groups
    { "Comment",             fg = colors.olive },

    -- Constant group
    { "Constant",            fg = colors.orange },
    { "String",              fg = colors.green_2 },
    { "Character",           fg = colors.red_1 },

    -- Statement group
    { "Statement",           fg = colors.red_2 },
    { "Operator",            fg = colors.grey_5 },
    { "Keyword",             fg = colors.blue_1 },

    -- Identifier group
    { "Identifier",          fg = colors.purple_3 },
    { "Function",            fg = colors.teal_1 },

    -- PreProc group
    { "PreProc",             fg = colors.grey_4 },
    { "Macro",               fg = colors.teal_1 },

    -- Type group
    { "Type",                fg = colors.purple_2 },

    -- Special group
    { "Special",             fg = colors.blue_2 },
    { "SpecialChar",         fg = colors.grey_4 },
    { "link",                "SpecialComment",     "SpecialChar" },

    { "Error",               fg = colors.red_1 },

    { "Todo",                fg = colors.yellow },
    -- }}}

    -- diagnostics {{{
    { "DiagnosticError",     fg = colors.red_1 },
    { "DiagnosticHint",      fg = colors.grey_4 },
    { "DiagnosticInfo",      fg = colors.teal_2 },
    { "DiagnosticWarn",      fg = colors.orange },

    { "DiagnosticSignHint",  bg = colors.grey_1,   fg = colors.grey_4 },
    { "DiagnosticSignError", bg = colors.grey_1,   fg = colors.red_1 },
    { "DiagnosticSignInfo",  bg = colors.grey_1,   fg = colors.teal_2 },
    { "DiagnosticSignWarn",  bg = colors.grey_1,   fg = colors.orange },
    -- }}}

    -- treesitter {{{
    -- treesitter links to appropriate groups
    -- hl { "@comment", fg = colors.grey_1 }
    -- }}}

    -- lsp {{{
    { "@documentation",      fg = colors.grey_4 },
    -- { "@documentation", fg = colors.purple_1 },
    -- }}}

    -- diff {{{
    -- this is better for sure
    { "DiffAdd",             fg = colors.green_1 },
    { "DiffChange",          fg = colors.grey_4 },
    { "DiffDelete",          fg = colors.red_1 },
    { "DiffText",            fg = colors.teal_1 },
    { "DiffAdded",           fg = colors.green_1 },
    { "DiffFile",            fg = colors.red_1 },
    { "DiffNewFile",         fg = colors.green_1 },
    { "DiffLine",            fg = colors.teal_1 },
    { "DiffRemoved",         fg = colors.red_1 },
    -- }}}
    -- debug {{{
    { "debugBreakpoint",     bg = colors.teal_1,   fg = colors.grey_1 },
    { "debugPC",             bg = colors.teal_1,   fg = colors.grey_1 },
    -- }}}
    -- spelling {{{
    { "SpellBad",            sy = "undercurl",     sp = colors.red_1 },
    { "clear",               "SpellLocal" },
    { "clear",               "SpellCap" },
    { "clear",               "SpellRare" },
    -- }}}
    -- misc {{{
    -- most hl-Nvim* highlights are linked to something
    { "NvimInternalError",   fg = colors.red_1 },
    -- }}}


    -- plugins {{{
    -- telescope {{{
    { "TelescopeSelection",  fg = colors.orange,   sy = "bold" },
    { "TelescopeNormal",     bg = colors.grey_1 },
    { "TelescopeBorder",     bg = colors.grey_1,   fg = colors.grey_5 },
    -- }}}

    -- mini {{{
    { "MiniCursorword",      bg = colors.grey_3, },
    { "MiniTrailspace",      fg = "nocombine,NONE" },
    -- }}}
    -- }}}
  }

  vim.cmd([[
    augroup HighlightYanked
      autocmd!
      autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()
    augroup END
  ]])

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
end

-- vim: foldmethod=marker nospell:
