--------------------------------------------------------------------------------
-- plugins
--------------------------------------------------------------------------------
-- bootstrap packer {{{
local function bootstrap_packer()
  local install_path = vim.fn.stdpath('data')
      .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    if vim.fn.executable('git') == 0 then
      print('git does not exists in PATH, cant downland packer')

      return nil
    end

    print('cloning packer')

    return vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
  end
end

local packer_bootstrap = bootstrap_packer()
-- }}}

-- packer {{{
-- manage and configure plugins with packer
-- some more involved plugins are configured separately
require("packer").startup(function()
  -- manage the packer instance as well
  use("wbthomason/packer.nvim")

  -- lsp {{{
  -- default configs for neovim lsp
  use({
    "neovim/nvim-lspconfig",
    config = function()
      -- lua/lsp_config.lua
      require("lsp_config")
    end,
    requires = {
      "nvim-lua/lsp-status.nvim",
    },
  })
  -- }}}

  -- completion {{{
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      -- lua/cmp_config.lua
      require("cmp_config")
    end,
    requires = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "f3fora/cmp-spell",
      -- "uga-rosa/cmp-dictionary",
      "onsails/lspkind.nvim",
    },
  })

  use({
    "L3MON4D3/LuaSnip",
    requires = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      vim.keymap.set("i", "<C-y>", "<Plug>luasnip-expand-or-jump", {})
    end,
  })
  -- }}}

  -- editor functionality {{{
  -- default config for treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- lua/treesitter_config.lua
      require("treesitter_config")
    end,
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
  })

  use({
    "gbprod/substitute.nvim",
    config = function()
      require("substitute").setup()

      -- vim.keymap.set("n", "ss",
      --   "<cmd>lua require('substitute').line()<cr>", { noremap = true })
    end
  })

  -- a bunch of small plugins in one repo
  use({
    "echasnovski/mini.nvim",
    config = function()
      -- lua/mini_config.lua
      require("mini_config")
    end,
  })

  -- fuzzy finder for lots of things like files, LSP symbols and other stuff
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      -- lua/telescope_config.lua
      require("telescope_config")
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  })

  -- the tpope collection {{{
  -- a set of good key bindings
  use("tpope/vim-unimpaired")
  -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"')
  use("tpope/vim-surround")
  -- [un]comment stuff with gc as expected
  -- use("tpope/vim-commentary")
  -- add ending keywords where it can, (e.g. fi and endif)
  use("tpope/vim-endwise")
  -- repeat plugin commands like surround
  use("tpope/vim-repeat")
  -- work with variants of words for abbreviations
  use("tpope/vim-abolish")
  -- readline bindings in insert mode
  use("tpope/vim-rsi")
  -- run cmds like make async and attach at anytime
  -- i never use this but i probably should
  -- use "tpope/vim-dispatch"
  -- a git wrapper
  use({
    "tpope/vim-fugitive",
    config = [[
        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
      ]],
    -- after/ftplugin/fugitive.vim
  })
  -- }}}

  -- get suggestions in the wild menu
  use({
    "gelguy/wilder.nvim",
    run = ":UpdateRemotePlugins",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      vim.cmd("runtime wilder_config.vim")
    end,
  })

  -- align a group of text like, useful every now and then
  use({
    "junegunn/vim-easy-align",
    config = function()
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
      vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
    end,
  })

  -- also maybe monaqa/dial.nvim
  use({
    "zegervdv/nrpattern.nvim",
    config = function()
      local patterns = require("nrpattern.default")

      -- increment numbers with delimiters like 1_999 to 2_000
      -- NOTE: could probably do this for all files
      table.insert(patterns["(-?%d[%d_]+%d+)"].filetypes, "rust")
      -- Basic setup
      -- See below for more options
      require("nrpattern").setup(patterns)
    end,
  })

  -- auto pairs {{{
  use({
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
  })
  -- }}}

  -- dirvish {{{
  -- vim like access to the file system, idk how to explain shortly
  -- this plugin needs to be add with packadd see issue below
  -- see https://github.com/justinmk/vim-dirvish/issues/137
  use({
    "justinmk/vim-dirvish",
    opt = true,
    config = function()
      -- disable netrw
      vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1
      vim.cmd([[
          command! -nargs=? -complete=dir Explore Dirvish <args>
          command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
          command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
        ]])
    end,
  })
  -- }}}

  -- show undo's in a tree so you can see the divergent paths
  -- this is really nice when i need it
  use({
    "mbbill/undotree",
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<F5>",
        ":UndotreeToggle<CR>",
        { noremap = true }
      )

      -- make undo pop up on the right
      vim.g.undotree_WindowLayout = 3
    end,
  })
  -- }}}

  -- language addons and settings {{{
  use({
    "rust-lang/rust.vim",
    config = function()
      -- dont overwrite vim settings
      vim.g.rust_recommended_style = 0
    end,
  })

  -- not really used
  -- use("pest-parser/pest.vim")
  -- use("ron-rs/ron.vim")

  use("pangloss/vim-javascript")
  use("leafgarland/typescript-vim")

  use({
    "vim-python/python-syntax",
    config = function()
      vim.g.python_highlight_all = 1
      -- highlighting space errors is annoying
      vim.g.python_highlight_space_errors = 0
    end,
  })

  use({
    "plasticboy/vim-markdown",
    config = function()
      -- after/ftplugin/markdown.vim
      -- after/syntax/markdown.vim
      vim.g.vim_markdown_no_default_key_mappings = 1

      -- indent by the given amount of spaces when hitting `o` and `O`, its annoying
      vim.g.vim_markdown_new_list_item_indent = 0

      -- so you can follow internal anchors
      vim.g.vim_markdown_follow_anchor = 1

      vim.g.vim_markdown_conceal = 1
      -- dont conceal the backticks in code blocks
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  })

  use("kevinoid/vim-jsonc")

  use("cespare/vim-toml")

  use("mboughaba/i3config.vim")

  -- use("tikhomirov/vim-glsl")
  -- }}}

  -- misc {{{
  -- my color scheme
  use({
    "~/proj/sourcery",
    config = function()
      vim.cmd([[ colorscheme sourcery ]])
    end,
  })

  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker")
    end,
    requires = {
      {
        "stevearc/dressing.nvim",
        config = function()
          require('dressing').setup()
        end
      }
    }
  })

  -- draw diagrams with ascii
  use({
    "jbyuki/venn.nvim",
    config = function()
      -- lua/venn_config.lua
      require("venn_config")
    end,
  })

  -- see https://github.com/mickael-menu/zk for more
  -- use({
  --   "mickael-menu/zk-nvim",
  --   config = function()
  --     require("zk").setup()
  --   end,
  -- })

  use({
    "lervag/wiki.vim",
    config = function()
      -- the wiki root
      vim.g.wiki_global_load = 0

      vim.g.wiki_root = "~/notebook"

      vim.g.wiki_filetypes = { "md" }

      vim.g.wiki_link_target_type = "md"
      vim.g.wiki_link_extension = ".md"

      -- ~/.config/nvim/after/ftplugin/markdown.vim
    end,
  })

  -- render markdown in a browser
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
  })

  -- a very fast, multi-syntax context-sensitive color name highlighter, #5fafaf
  use({
    "norcalli/nvim-colorizer.lua",
    config = [[
        require("colorizer").setup({ "*", "!packer", }, { names = false })
      ]],
  })
  -- }}}

  local group = vim.api.nvim_create_augroup("RunPackerCompile", {})

  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerCompile",
    pattern = "plugins.lua",
    group = group,
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
-- }}}

-- this is necessary as [neo]vim loads built in packages before plugins,
vim.cmd("packadd vim-dirvish")

-- vim: foldmethod=marker
