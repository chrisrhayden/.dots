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
  "tpope/vim-rsi",
  -- a git wrapper
  { "tpope/vim-fugitive", keys = { { "<leader>gs", ":Git<cr>" } } },
  -- }}}

  { "elihunter173/dirbuf.nvim", config = true, },

  {
    dir = "~/proj/sourcery",
    config = function()
      vim.cmd.colorscheme "sourcery"
    end
  },

  "rust-lang/rust.vim",

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "scss",
        "css",
        "html",
      }
    },
  },

  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release"
  },

  "rafcamlet/nvim-luapad",

  "rust-lang/rust.vim",

  "elkowar/yuck.vim",
  "NoahTheDuke/vim-just",
}
