--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------

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
        "vim",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
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
        swap = {
          enable = true,
          swap_next = {
            ["<leader>s"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>S"] = "@parameter.inner",
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
