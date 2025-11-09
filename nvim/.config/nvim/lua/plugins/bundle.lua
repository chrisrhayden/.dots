return {
  -- self manage lazy.nvim
  { "folke/lazy.nvim", version = "*" },

  -- the tpope collection {{{
  -- a set of good key bindings
  -- "tpope/vim-unimpaired",
  -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"')
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
    config = true,
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
        "html",
      },
      user_default_options = {
        names = false
      },
    },
  },

  "NoahTheDuke/vim-just",

  {
    "fladson/vim-kitty",
    ft = "kitty",
  },

  {
    "saxon1964/neovim-tips",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL: Choose your preferred markdown renderer (or omit for raw markdown)
      "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
      -- OR: "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
    },
    opts = {
      -- OPTIONAL: Location of user defined tips (default value shown below)
      user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
      -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
      user_tip_prefix = "[User] ",
      -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
      warn_on_conflicts = true,
      -- OPTIONAL: Daily tip mode (default: 1)
      -- 0 = off, 1 = once per day, 2 = every startup
      daily_tip = 0,
      -- OPTIONAL: Bookmark symbol (default: "🌟 ")
      -- bookmark_symbol = "🌟 ",
    },
  },

  {
    dir = "~/proj/sourcery",
    config = function()
      vim.cmd.colorscheme "sourcery"
    end
  },
}
