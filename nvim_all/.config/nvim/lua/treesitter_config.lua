require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
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
      lookahead = true,
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
}
