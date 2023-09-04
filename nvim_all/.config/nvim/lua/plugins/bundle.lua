return {
  -- self manage lazy.nvim
  { "folke/lazy.nvim", version = "*" },

  {
    -- auto pair plugin
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup()

      npairs.add_rule(
        Rule("<", ">", "rust"):with_pair(cond.before_regex("%a"))
      )
    end,
  },

  -- the tpope collection {{{
  -- a set of good key bindings
  -- "tpope/vim-unimpaired",
  -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"')
  "tpope/vim-surround",
  -- add ending keywords where it can, (e.g. fi and endif)
  -- "tpope/vim-endwise",
  -- repeat plugin commands like surround
  "tpope/vim-repeat",
  -- work with variants of words for abbreviations
  -- "tpope/vim-abolish",
  -- readline bindings in insert mode
  -- "tpope/vim-rsi",
  { -- a git wrapper
    "tpope/vim-fugitive",
    keys = { { "<leader>gs", ":Git<cr>", desc = "open fugitive" } }
  },
  -- }}}

  -- hasn't been getting updates
  { "elihunter173/dirbuf.nvim", config = true, },

  {
    "mbbill/undotree",
    keys = {
      { "<F5>", vim.cmd.UndotreeToggle, desc = "toggle undo tree" }
    }
  },

  {
    "folke/which-key.nvim",
    opts = {
      window = {
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
      }
    },
  },

  "rust-lang/rust.vim",
  "NoahTheDuke/vim-just",

  {
    dir = "~/proj/sourcery",
    config = function()
      vim.cmd.colorscheme "sourcery"
    end
  },
}
