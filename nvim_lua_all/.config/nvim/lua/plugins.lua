-- plugins

-- packer {{{
return require("packer").startup(function()
    -- manage the packer instanse as well
    use "wbthomason/packer.nvim"

    -- utils {{{
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    -- }}}

    -- lsp {{{
    use "neovim/nvim-lspconfig"
    -- use "hrsh7th/nvim-compe"
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-buffer",
      }
    }

    -- use "nvim-lua/lsp-status.nvim"

    use "jose-elias-alvarez/null-ls.nvim"

    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    -- }}}

    -- editor functionality {{{
    -- treesitter {{{
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/playground"
    -- }}}

    -- fuzzy finder for lots of things like files, LSP symbols and other stuff

    use {
      "nvim-telescope/telescope.nvim",
      config = function()
        require('telescope').setup {
          defaults = {
            layout_strategy = "flex",
          }
        }

        local opts = {noremap = true}

        vim.api.nvim_set_keymap("n", "<leader>tf",
          "<cmd>Telescope find_files<cr>", opts)

        vim.api.nvim_set_keymap("n", "<leader>tg",
          "<cmd>Telescope live_grep<cr>",  opts)

        vim.api.nvim_set_keymap("n", "<leader>tb",
          "<cmd>Telescope buffers<cr>",    opts)

        vim.api.nvim_set_keymap("n", "<leader>th",
          "<cmd>Telescope help_tags<cr>",  opts)

        vim.api.nvim_set_keymap("n", "<leader>ts",
          "<cmd>Telescope lsp_document_symbols<cr>",  opts)
      end
    }

    -- get suggestions in the wilder menu
    use "gelguy/wilder.nvim"

    -- the tpope collection {{{
    -- a set of good key bindings
    use "tpope/vim-unimpaired"
    -- change surrounding object in a very vim like way (e.g. cs<from><to> cs"")
    use "tpope/vim-surround"
    -- [un]comment stuff with gc as expected
    use "tpope/vim-commentary"
    -- add ending keywords where it can, (e.g. fi and endif)
    use "tpope/vim-endwise"
    -- repeat plugin commands like surround
    use "tpope/vim-repeat"
    -- a git wrapper
    use {
      "tpope/vim-fugitive",
      config = [[
        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
      ]]
      -- after/ftplugin/fugitive.vim
    }
    -- work with variants of words for abbreviations
    use "tpope/vim-abolish"
    -- readline bindings in insert mode
    use "tpope/vim-rsi"
    -- run cmds like make async and attach at anytime
    -- i never use this but i probably should
    -- use "tpope/vim-dispatch"
    -- }}}

    -- align a group of text like, useful every now and then
    use {
      "junegunn/vim-easy-align",
      config = [[
        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})
        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})
      ]]
    }

    use {
      "windwp/nvim-autopairs",
      config = [[
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')

        npairs.setup()

        npairs.add_rule(
          Rule("<", ">", {"rust"})
            :with_pair(cond.before_regex_check("%a"))
        )
      ]]
    }

    -- vim like access to the file system, idk how to explain shortly
    use {
      "justinmk/vim-dirvish",
        config = [[
          -- disable netrw
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
        ]]
    }

    -- show undo's in a tree so you can see the divergent paths
    -- this is really nice when i need it
    use {
      "mbbill/undotree",
      config = [[
        vim.api.nvim_set_keymap("n", "<F5>", ":UndotreeToggle<CR>", {noremap = true})

        -- make undo pop up on the right
        vim.g.undotree_WindowLayout = 3
      ]]
    }

    -- additions that are close enough to plugins to not want in my rc
    use "chrisrhayden/my_vim_utils"
    -- }}}

    -- language addons and settings {{{
    use {
      "rust-lang/rust.vim",
      config = [[
        -- dont overwrite vim settings
        vim.g.rust_recommended_style = 0

        -- use vim's conceal and symbols like ⟶  and ⟹  to style code
        -- the unicode char size depends on the terminal supporting double wide chars
        -- vim.g.rust_conceal = 1
        -- vim.g.rust_conceal_mod_path = 1
      ]]
    }
    use "pest-parser/pest.vim"
    use "ron-rs/ron.vim"

    use "pangloss/vim-javascript"
    use "leafgarland/typescript-vim"
    -- use "peitalin/vim-jsx-typescript"

    use {
      "vim-python/python-syntax",
      config = [[
        vim.g.python_highlight_all = 1
        -- highlighting space errors is annoying
        vim.g.python_highlight_space_errors = 0
      ]]
    }

    use {
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
      ]]
    }

    use "kevinoid/vim-jsonc"

    use "cespare/vim-toml"

    -- use "PotatoesMaster/i3-vim-syntax"
    use "mboughaba/i3config.vim"

    use "tikhomirov/vim-glsl"
    -- }}}

    -- misc {{{
    use {
      "~/proj/sourcery",
      config = [[vim.cmd("colorscheme sourcery")]]
    }

    use "kyazdani42/nvim-web-devicons"

    use {
      "lervag/wiki.vim",
      config = [[
        -- the wiki root
        vim.g.wiki_global_load = 0

        vim.g.wiki_root = "~/notebook"

        vim.g.wiki_filetypes = {"md"}

        vim.g.wiki_link_target_type = "md"
        vim.g.wiki_link_extension = ".md"

        -- ~/.config/nvim/after/ftplugin/markdown.vim
      ]]
    }

    -- render markdown in a browser
    use {"iamcco/markdown-preview.nvim",  run = "cd app && yarn install"}

    -- a very fast, multi-syntax context-sensitive color name highlighter, #5fafaf
    -- use "ap/vim-css-color"
    use {
      "norcalli/nvim-colorizer.lua",
      config = [[
        require('colorizer').setup({"*"}, {names = false})
      ]]
    }
    -- }}}

    vim.api.nvim_exec([[
      augroup RunPackerCompile
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup END
    ]], false)
end)
-- }}}

-- vim: foldmethod=marker
