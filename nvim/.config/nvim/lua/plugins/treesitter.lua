--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "RRethy/nvim-treesitter-endwise",
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "fish",
        "html",
        "json",
        "lua",
        "make",
        "markdown",
        "org",
        "python",
        "regex",
        "rust",
        "toml",
        "typescript",
        "javascript",
        "vim",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
      },
      incremental_selection = {
        enable = false,
        -- keymaps = {
        --   init_selection = "gnn",
        --   node_incremental = "grn",
        --   scope_incremental = "grc",
        --   node_decremental = "grm",
        -- },
      },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]]"] = "@function.outer",
            -- ["]]"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            -- ["[["] = "@class.outer",
          },
          -- goto_next_end = { },
          -- goto_previous_end = { },
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
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
      },
      playground = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
}
