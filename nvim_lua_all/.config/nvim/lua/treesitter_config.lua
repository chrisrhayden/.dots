require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<space>gnn",
      node_incremental = "<space>grn",
      scope_incremental = "<space>grc",
      node_decremental = "<space>grm",
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@function.outer",
        -- ["]m"] = "@function.outer",
        -- ["]]"] = "@class.outer",
      },
      goto_next_end = {
        -- ["]M"] = "@function.outer",
        -- ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        -- ["[m"] = "@function.outer",
        -- ["[["] = "@class.outer",
      },
      goto_previous_end = {
        -- ["[M"] = "@function.outer",
        -- ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = false,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    -- Debounced time for highlighting nodes in the playground from source code
    updatetime = 25,
    -- Whether the query persists across vim sessions
    persist_queries = false,
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
