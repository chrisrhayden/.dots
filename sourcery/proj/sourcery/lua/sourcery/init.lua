-- info {{{
-- ~~stolen from~~ based on Apprentice and Sorcerer:
-- https://github.com/romainl/Apprentice
-- https://www.vim.org/scripts/script.php?script_id           = 3299
-- }}}

-- TODO: do something with term colors
function SourceryColor()
    -- colors {{{
    local colors        = {
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

    vim.o.background    = "dark"
    vim.o.termguicolors = true

    -- highlight function {{{
    ---call `highlight` for a given group
    ---
    ---@param objects table a table of highlights
    local function hl_all(objects)
        for group, hl in pairs(objects) do
            vim.api.nvim_set_hl(0, group, hl)
        end
    end
    -- }}}

    -- highlights {{{
    hl_all {
        -- nvim ui {{{
        Normal                                     = { bg = colors.grey_2, fg = colors.grey_5 },
        NormalFloat                                = { bg = colors.grey_1, fg = colors.grey_5 },
        FloatBorder                                = { bg = colors.grey_1, fg = colors.teal_2 },
        FloatTitle                                 = { link = "FloatBorder" },
        FloatFooter                                = { link = "FloatBorder" },
        Whitespace                                 = { fg = colors.grey_4 },
        SpecialKey                                 = { fg = colors.grey_4 },
        NonText                                    = { fg = colors.grey_4 },
        EndOfBuffer                                = { link = "NonText" },

        Visual                                     = { bg = colors.blue_1, fg = colors.grey_1, bold = true },

        Search                                     = { bg = colors.blue_1, fg = colors.grey_1, bold = true },
        CurSearch                                  = { bg = colors.yellow, fg = colors.grey_1, bold = true },
        Substitute                                 = { link = "Search" },
        IncSearch                                  = { link = "Search" },

        LineNr                                     = { bg = colors.grey_1, fg = colors.grey_4 },
        SignColumn                                 = { bg = colors.grey_1, fg = colors.grey_4 },

        StatusLine                                 = { bg = colors.purple_1, fg = colors.teal_2 },
        StatusLineNC                               = { bg = colors.grey_3, fg = colors.grey_4 },

        Cursor                                     = { bg = colors.grey_5, fg = colors.grey_2, bold = true },
        CursorLine                                 = { bg = colors.grey_1 },
        CursorLineNr                               = { bg = colors.grey_1, fg = colors.teal_2 },
        ColorColumn                                = { bg = colors.grey_1 },
        CursorColumn                               = { bg = colors.grey_1 },

        Folded                                     = { bg = colors.grey_1, fg = colors.grey_4 },
        FoldColumn                                 = { bg = colors.grey_1, fg = colors.grey_4 },

        WinSeparator                               = { bg = colors.grey_1, fg = colors.purple_1 },

        TabLine                                    = { bg = colors.grey_1, fg = colors.grey_4 },
        TabLineFill                                = { bg = colors.grey_1, fg = colors.grey_4 },
        TabLineSel                                 = { bg = colors.grey_1, fg = colors.teal_1 },

        WildMenu                                   = { bg = colors.grey_1, fg = colors.purple_2 },

        Pmenu                                      = { bg = colors.grey_1, fg = colors.purple_2, italic = true },
        PmenuSel                                   = { bg = colors.grey_5, fg = colors.grey_1, bold = true },
        PmenuSbar                                  = { bg = colors.grey_1 },
        PmenuThumb                                 = { bg = colors.grey_5, },

        QuickFixLine                               = { bg = colors.grey_1 },

        WarningMsg                                 = { fg = colors.orange },
        ErrorMsg                                   = { fg = colors.red_1 },
        ModeMsg                                    = { fg = colors.green_1 },
        MoreMsg                                    = { fg = colors.green_1 },
        Question                                   = { fg = colors.teal_1 },

        Title                                      = { fg = colors.teal_1 },
        Conceal                                    = { fg = colors.blue_2 },
        MatchParen                                 = { bg = colors.grey_4, fg = colors.grey_1, bold = true },
        Directory                                  = { fg = colors.blue_2 },

        SpellBad                                   = { undercurl = true, sp = colors.red_1 },
        SpellLocal                                 = {},
        SpellCap                                   = {},
        SpellRare                                  = {},

        DiffAdd                                    = { fg = colors.green_1 },
        DiffChange                                 = { fg = colors.grey_4 },
        DiffDelete                                 = { fg = colors.red_1 },
        DiffText                                   = { fg = colors.teal_1 },
        DiffAdded                                  = { fg = colors.green_1 },
        DiffFile                                   = { fg = colors.red_1 },
        DiffNewFile                                = { fg = colors.green_1 },
        DiffLine                                   = { fg = colors.teal_1 },
        DiffRemoved                                = { fg = colors.red_1 },

        -- Bold
        -- Italic
        -- Underlined
        -- }}}

        -- syntax highlighting {{{
        -- `:help group-name` -- for the syntax groups
        -- Comment group
        Comment                                    = { fg = colors.olive },

        -- Constant group {{{
        Constant                                   = { fg = colors.orange },
        String                                     = { fg = colors.green_2 },
        Character                                  = { fg = colors.red_1 },
        -- Number
        -- Boolean
        -- Float
        -- }}}

        -- Identifier group {{{
        Identifier                                 = { fg = colors.purple_3 },
        Function                                   = { fg = colors.teal_1 },
        -- }}}

        -- Statement group {{{
        Statement                                  = { fg = colors.red_2 },
        -- Conditional
        -- Repeat
        -- Label
        Operator                                   = { fg = colors.grey_5 },
        Keyword                                    = { fg = colors.blue_1 },
        -- Exception
        -- }}}

        -- PreProc group {{{
        PreProc                                    = { fg = colors.grey_4 },
        -- Include
        -- Define
        -- Macro                                      = { link = "Function" },
        -- PreCondit
        -- }}}

        -- Type group {{{
        Type                                       = { fg = colors.purple_2 },
        -- StorageClass
        -- Structure
        -- Typedef
        -- }}}

        -- Special group {{{
        Special                                    = { fg = colors.blue_2 },
        -- SpecialChar
        -- Tag
        -- Delimiter
        SpecialComment                             = { fg = colors.grey_4 },
        -- Debug
        -- }}}

        -- Underlined
        -- Ignore
        -- Error
        -- Todo
        -- Added
        -- Changed
        -- Removed
        -- }}}

        -- diagnostics {{{
        DiagnosticError                            = { fg = colors.red_1 },
        DiagnosticHint                             = { fg = colors.grey_4 },
        DiagnosticInfo                             = { fg = colors.teal_2 },
        DiagnosticWarn                             = { fg = colors.orange },
        DiagnosticOk                               = { fg = colors.green_1 },

        DiagnosticSignHint                         = { bg = colors.grey_1, fg = colors.grey_4 },
        DiagnosticSignError                        = { bg = colors.grey_1, fg = colors.red_1 },
        DiagnosticSignInfo                         = { bg = colors.grey_1, fg = colors.teal_2 },
        DiagnosticSignWarn                         = { bg = colors.grey_1, fg = colors.orange },
        DiagnosticSignOk                           = { fg = colors.green_1 },

        DiagnosticFloatingError                    = { fg = colors.red_1 },
        DiagnosticFloatingWarn                     = { fg = colors.orange },
        DiagnosticFloatingInfo                     = { fg = colors.blue_2 },
        DiagnosticFloatingHint                     = { fg = colors.yellow },
        DiagnosticFloatingOk                       = { fg = colors.green_1 },
        -- }}}

        -- lsp {{
        -- most of these are linked well
        -- "@lsp.type.class"
        -- "@lsp.type.comment"
        -- "@lsp.type.decorator"
        -- ["@lsp.mod.declaration.cpp"]               = { link = "Function" },
        -- "@lsp.type.enum"
        -- "@lsp.type.enumMember"
        -- "@lsp.type.event"
        -- "@lsp.type.function"
        -- "@lsp.type.interface"
        -- "@lsp.type.keyword"
        -- ["@lsp.type.macro"]                        = { link = "Function" },
        -- "@lsp.type.method"
        -- "@lsp.type.modifier"
        -- "@lsp.type.namespace"
        -- "@lsp.type.number"
        -- "@lsp.type.operator"
        -- "@lsp.type.parameter"
        -- "@lsp.type.property"
        ["@lsp.type.punctuation"]                  = { fg = colors.blue_2 },
        -- "@lsp.type.regexp"
        -- "@lsp.type.string"
        -- "@lsp.type.struct"
        -- "@lsp.type.type"
        -- "@lsp.type.typeParameter"
        -- "@lsp.type.variable"
        ["@lsp.mod.documentation"]                 = { link = "SpecialComment" },

        -- rust {{{
        -- for the `?` operator
        ["@lsp.type.macro.rust"]                   = { link = "Function" },
        ["@lsp.typemod.operator.controlFlow.rust"] = { fg = colors.orange },
        -- }}}

        -- lua {{{
        ["@lsp.typemod.keyword.documentation.lua"] = { fg = colors.grey_4 },
        -- }}}

        ["@lsp.typemod.macro.declaration.cpp"]     = { link = "Function" },
        -- }}}

        -- treesitter {{{
        -- treesitter links to appropriate groups
        ["@punctuation"]                           = { fg = colors.blue_2 },
        ["@variable"]                              = { link = "Identifier" },
        ["@function.macro.cpp"]                    = { link = "Function" },
        -- }}}

        -- debug {{{
        debugBreakpoint                            = { bg = colors.teal_1, fg = colors.grey_1 },
        debugPC                                    = { bg = colors.teal_1, fg = colors.grey_1 },
        -- }}}


        -- plugins {{{
        -- telescope {{{
        TelescopeSelection = { fg = colors.orange, bold = true },
        TelescopeNormal    = { bg = colors.grey_1 },
        TelescopeBorder    = { bg = colors.grey_1, fg = colors.grey_5 },
        -- }}}

        -- mini {{{
        MiniCursorword     = { bg = colors.grey_3 },
        MiniTrailspace     = { nocombine = true },
        -- }}}
        -- }}}
    }

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
