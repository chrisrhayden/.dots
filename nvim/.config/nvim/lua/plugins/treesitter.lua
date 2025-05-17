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
        "vimdoc",
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
      },
      -- incremental_selection = { enable = false, },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
          },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = false,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
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
