return {
  -- self manage lazy.nvim
  { "folke/lazy.nvim", version = "*" },

  -- the tpope collection {{{
  -- a set of good key bindings
  -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"')
  -- "tpope/vim-unimpaired",
  -- "tpope/vim-surround",
  -- add ending keywords where it can, (e.g. fi and endif)
  -- "tpope/vim-endwise",
  -- repeat plugin commands like surround
  -- "tpope/vim-repeat",
  -- work with variants of words for abbreviations
  -- "tpope/vim-abolish",
  -- readline bindings in insert mode
  -- "tpope/vim-rsi",
  { -- a git wrapper
    "tpope/vim-fugitive",
    keys = { { "<leader>gs", ":Git<cr>", desc = "open fugitive" } }
  },
  -- }}}

  {
    "mbbill/undotree",
    keys = {
      { "<F5>", vim.cmd.UndotreeToggle, desc = "toggle undo tree" }
    }
  },

  {
    "folke/which-key.nvim",
    preset = "modern",
    opts = {
      icons = {
        mappings = false
      },
      win = {
        title = false,
        border = "rounded",
      }
    },
  },

  { -- kinda nice sometimes
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "scss",
        "css",
      },
      "html",
      user_default_options = {
        names = false
      },
    },
  },

  "NoahTheDuke/vim-just",

  {
    dir = "~/proj/sourcery",
    config = function()
      vim.cmd.colorscheme "sourcery"
    end
  },

  {
    "folke/tokyonight.nvim",
    -- config = function()
    --   vim.cmd.colorscheme = "tokyonight"
    -- end
  },
}
