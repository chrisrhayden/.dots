--------------------------------------------------------------------------------
-- plugins
--------------------------------------------------------------------------------

-- packer {{{
-- mange and configure plugins with packer
-- some more involved plugins are configured separately
require("packer").startup(function()
  -- manage the packer instance as well
  use("wbthomason/packer.nvim")

  -- lsp {{{
  -- default configs for neovim lsp
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/lsp-status.nvim",
    },
  })

  -- allow none lsp tools hook in to neovim lsp
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
  -- }}}

  -- completion {{{
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
  })
  -- }}}

  -- editor functionality {{{
  -- treesitter {{{
  -- like nvim-lspconfig but for nvim-lspconfig
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
  })
  -- }}}

  -- mini plugins {{{
  -- a bunch of small plugins in one repo
  use({
    "echasnovski/mini.nvim",
    config = function()
      -- lua/mini_config.lua
      require("mini_config")
    end,
  })
  -- }}}

  -- snippets {{{
  use({
    "hrsh7th/vim-vsnip",
    config = function()
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("data")
        .. "/site/pack/packer/start/friendly-snippets/"

      vim.api.nvim_set_keymap(
        "i",
        "<C-y>",
        "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'",
        { expr = true }
      )

      vim.api.nvim_set_keymap(
        "s",
        "<C-y>",
        "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'",
        { expr = true }
      )
    end,
    requires = {
      "hrsh7th/vim-vsnip-integ",
      "rafamadriz/friendly-snippets",
    },
  })
  -- }}}

  -- telescope {{{
  -- fuzzy finder for lots of things like files, LSP symbols and other stuff
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "flex",
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<leader>ff",
        "<cmd>Telescope find_files<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>fg",
        "<cmd>Telescope live_grep<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        "<cmd>Telescope buffers<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>fh",
        "<cmd>Telescope help_tags<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>fs",
        "<cmd>Telescope lsp_document_symbols<cr>",
        { noremap = true }
      )
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  })
  -- }}}

  -- the tpope collection {{{
  -- a set of good key bindings
  use("tpope/vim-unimpaired")
  -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"")
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

  -- harpoon {{{
  -- switch to files with a few keybindings
  use({
    "ThePrimeagen/harpoon",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>pa",
        "<cmd>lua require('harpoon.mark').add_file()<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>pp",
        "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        { noremap = true }
      )

      for i = 1, 4 do
        vim.api.nvim_set_keymap(
          "n",
          "<leader>" .. tostring(i),
          "<cmd>lua require('harpoon.ui').nav_file(" .. tostring(i) .. ")<cr>",
          { noremap = true }
        )
      end
    end,
  })
  -- }}}

  -- get suggestions in the wild menu
  use({ "gelguy/wilder.nvim", run = ":UpdateRemotePlugins" })

  -- align a group of text like, useful every now and then
  use({
    "junegunn/vim-easy-align",
    config = [[
        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})
        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})
      ]],
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
        Rule("<", ">", { "rust" }):with_pair(cond.before_regex_check("%a"))
      )
    end,
  })
  -- }}}

  -- dirvish {{{
  -- vim like access to the file system, idk how to explain shortly
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

      -- use vim's conceal and symbols like ⟶  and ⟹  to style code
      -- the unicode char size depends on the terminal supporting double wide chars
      -- vim.g.rust_conceal = 1
      -- vim.g.rust_conceal_mod_path = 1
    end,
  })
  use("pest-parser/pest.vim")
  use("ron-rs/ron.vim")

  use({
    "tjdevries/nlua.nvim",
    requires = {
      "euclidianAce/BetterLua.vim",
      -- "tjdevries/manillua.nvim",
    },
  })

  use("pangloss/vim-javascript")
  use("leafgarland/typescript-vim")
  -- use "peitalin/vim-jsx-typescript"

  use({
    "vim-python/python-syntax",
    config = [[
        vim.g.python_highlight_all = 1
        -- highlighting space errors is annoying
        vim.g.python_highlight_space_errors = 0
      ]],
  })

  use({
    "plasticboy/vim-markdown",
    config = [[
        -- after/ftplugin/markdown.vim
        -- after/syntax/markdown.vim
        vim.g.vim_markdown_no_default_key_mappings = 1

        -- indent by the given amount of spaces when hitting `o` and `O`, its annoying
        vim.g.vim_markdown_new_list_item_indent = 0

        -- so you can follow internal anchors
        vim.g.vim_markdown_follow_anchor = 1

        -- vim.g.vim_markdown_conceal = 1
        -- dont conceal the backticks in code blocks
        vim.g.vim_markdown_conceal_code_blocks = 0
      ]],
  })

  use("kevinoid/vim-jsonc")

  use("cespare/vim-toml")

  -- use "PotatoesMaster/i3-vim-syntax"
  use("mboughaba/i3config.vim")

  use("tikhomirov/vim-glsl")
  -- }}}

  -- misc {{{
  use({
    "~/proj/sourcery",
    config = function()
      vim.cmd([[ colorscheme sourcery ]])
    end,
  })

  use({
    "rafcamlet/nvim-luapad",
    -- config = function() end,
  })

  use({
    "jbyuki/venn.nvim",
    config = function()
      -- venn.nvim: enable or disable keymappings
      function ToggleVenn()
        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.o.virtualedit = "all"
          vim.cmd([[setlocal ve=all]])
          -- draw a line on HJKL keystokes
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "J",
            "<C-v>j:VBox<CR>",
            { noremap = true }
          )
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "K",
            "<C-v>k:VBox<CR>",
            { noremap = true }
          )
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "L",
            "<C-v>l:VBox<CR>",
            { noremap = true }
          )
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "H",
            "<C-v>h:VBox<CR>",
            { noremap = true }
          )
          -- draw a box by pressing "f" with visual selection
          vim.api.nvim_buf_set_keymap(
            0,
            "v",
            "f",
            ":VBox<CR>",
            { noremap = true }
          )
        else
          vim.o.virtualedit = ""
          vim.cmd([[setlocal ve=]])
          vim.cmd([[mapclear <buffer>]])
          vim.b.venn_enabled = nil
        end
      end

      -- toggle keymappings for venn using <leader>v
      vim.api.nvim_set_keymap(
        "n",
        "<leader>v",
        ":lua ToggleVenn()<CR>",
        { noremap = true }
      )
    end,
  })

  use({
    "lervag/wiki.vim",
    config = [[
        -- the wiki root
        vim.g.wiki_global_load = 0

        vim.g.wiki_root = "~/notebook"

        vim.g.wiki_filetypes = {"md"}

        vim.g.wiki_link_target_type = "md"
        vim.g.wiki_link_extension = ".md"

        -- ~/.config/nvim/after/ftplugin/markdown.vim
      ]],
  })

  -- render markdown in a browser
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
  })

  -- a very fast, multi-syntax context-sensitive color name highlighter, #5fafaf
  -- use "ap/vim-css-color"
  use({
    "norcalli/nvim-colorizer.lua",
    config = [[
        require("colorizer").setup({ "*", "!packer", }, { names = false })
      ]],
  })

  use({
    "kristijanhusak/orgmode.nvim",
    config = function()
      require("orgmode").setup({
        org_agenda_files = { "~/notebook/*" },
        org_default_notes_file = "~/notebook/index.org",
        -- org_hide_emphasis_markers = true,
        org_indent_mode = "noindent",
        org_blank_before_new_entry = {
          heading = true,
          plain_list_item = false,
        },
      })

      vim.api.nvim_set_keymap(
        "n",
        "<space>oW",
        "<cmd>tabnew ~/notebook/index.org<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<space>ow",
        "<cmd>split ~/notebook/index.org<cr>",
        { noremap = true }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<space>ow",
        "<cmd>split ~/notebook/index.org<cr>",
        { noremap = true }
      )

      -- after/ftplugin/org.vim
    end,
  })
  -- }}}

  vim.cmd([[
      augroup RunPackerCompile
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup END
    ]])
end)
-- }}}

-- this is necessary as [neo]vim loads built in packages before plugins,
-- see https://github.com/justinmk/vim-dirvish/issues/137
vim.cmd("packadd vim-dirvish")

-- vim: foldmethod=marker
