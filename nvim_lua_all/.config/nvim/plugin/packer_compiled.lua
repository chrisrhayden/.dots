-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/chris/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/chris/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/chris/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/chris/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/chris/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["BetterLua.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/BetterLua.vim",
    url = "https://github.com/euclidianAce/BetterLua.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  harpoon = {
    config = { "\27LJ\2\nŸ\3\0\0\f\0\15\0'6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1)\0\1\0)\1\4\0)\2\1\0M\0\18€6\4\0\0009\4\1\0049\4\2\4'\6\3\0'\a\n\0006\b\v\0\18\n\3\0B\b\2\2&\a\b\a'\b\f\0006\t\v\0\18\v\3\0B\t\2\2'\n\r\0&\b\n\b5\t\14\0B\4\5\1O\0îK\0\1\0\1\0\1\fnoremap\2\n)<cr>-<cmd>lua require('harpoon.ui').nav_file(\rtostring\r<leader>\1\0\1\fnoremap\2;<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>\15<leader>pp\1\0\1\fnoremap\0024<cmd>lua require('harpoon.mark').add_file()<cr>\15<leader>pa\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["i3config.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/i3config.vim",
    url = "https://github.com/mboughaba/i3config.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16mini_config\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  ["nlua.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nç\1\0\0\v\0\f\0\0256\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0B\3\1\0019\3\5\0\18\5\1\0'\a\6\0'\b\a\0005\t\b\0B\5\4\2\18\a\5\0009\5\t\0059\b\n\2'\n\v\0B\b\2\0A\5\1\0A\3\0\1K\0\1\0\a%a\23before_regex_check\14with_pair\1\2\0\0\trust\6>\6<\radd_rule\nsetup\25nvim-autopairs.conds\24nvim-autopairs.rule\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { '        require("colorizer").setup({ "*", "!packer", }, { names = false })\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["pest.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/pest.vim",
    url = "https://github.com/pest-parser/pest.vim"
  },
  playground = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["python-syntax"] = {
    config = { "        vim.g.python_highlight_all = 1\n        -- highlighting space errors is annoying\n        vim.g.python_highlight_space_errors = 0\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/python-syntax",
    url = "https://github.com/vim-python/python-syntax"
  },
  ["ron.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/ron.vim",
    url = "https://github.com/ron-rs/ron.vim"
  },
  ["rust.vim"] = {
    config = { "\27LJ\2\n8\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\27rust_recommended_style\6g\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  sourcery = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27 colorscheme sourcery \bcmd\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/sourcery",
    url = "/home/chris/proj/sourcery"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n¯\4\0\0\6\0\25\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2,<cmd>Telescope lsp_document_symbols<cr>\15<leader>fs\1\0\1\fnoremap\2!<cmd>Telescope help_tags<cr>\15<leader>fh\1\0\1\fnoremap\2\31<cmd>Telescope buffers<cr>\15<leader>fb\1\0\1\fnoremap\2!<cmd>Telescope live_grep<cr>\15<leader>fg\1\0\1\fnoremap\2\"<cmd>Telescope find_files<cr>\15<leader>ff\6n\20nvim_set_keymap\bapi\bvim\rdefaults\1\0\0\1\0\1\20layout_strategy\tflex\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/typescript-vim",
    url = "https://github.com/leafgarland/typescript-vim"
  },
  undotree = {
    config = { "\27LJ\2\n’\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0)\1\3\0=\1\b\0K\0\1\0\26undotree_WindowLayout\6g\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\t<F5>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["venn.nvim"] = {
    config = { "\27LJ\2\nä\4\0\0\b\0 \0S6\0\0\0009\0\1\0006\2\0\0009\2\2\0029\2\3\2B\0\2\2\a\0\4\0X\1:€6\1\0\0009\1\2\1+\2\2\0=\2\3\0016\1\0\0009\1\5\1'\2\a\0=\2\6\0016\1\0\0009\1\b\1'\3\t\0B\1\2\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\r\0'\6\14\0005\a\15\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\16\0'\6\17\0005\a\18\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\19\0'\6\20\0005\a\21\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\22\0'\6\23\0005\a\24\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\25\0'\5\26\0'\6\27\0005\a\28\0B\1\6\1X\1\16€6\1\0\0009\1\5\1'\2\29\0=\2\6\0016\1\0\0009\1\b\1'\3\30\0B\1\2\0016\1\0\0009\1\b\1'\3\31\0B\1\2\0016\1\0\0009\1\2\1+\2\0\0=\2\3\1K\0\1\0\22mapclear <buffer>\17setlocal ve=\5\1\0\1\fnoremap\2\14:VBox<CR>\6f\6v\1\0\1\fnoremap\2\20<C-v>h:VBox<CR>\6H\1\0\1\fnoremap\2\20<C-v>l:VBox<CR>\6L\1\0\1\fnoremap\2\20<C-v>k:VBox<CR>\6K\1\0\1\fnoremap\2\20<C-v>j:VBox<CR>\6J\6n\24nvim_buf_set_keymap\bapi\20setlocal ve=all\bcmd\ball\16virtualedit\6o\bnil\17venn_enabled\6b\finspect\bvim…\1\1\0\6\0\t\0\v3\0\0\0007\0\1\0006\0\2\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\26:lua ToggleVenn()<CR>\14<leader>v\6n\20nvim_set_keymap\bapi\bvim\15ToggleVenn\0\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-dirvish"] = {
    config = { "\27LJ\2\nÅ\2\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0†\2          command! -nargs=? -complete=dir Explore Dirvish <args>\n          command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>\n          command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>\n        \bcmd\17loaded_netrw\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/opt/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-easy-align"] = {
    config = { '        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})\n        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-endwise",
    url = "https://github.com/tpope/vim-endwise"
  },
  ["vim-fugitive"] = {
    config = { '        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-glsl",
    url = "https://github.com/tikhomirov/vim-glsl"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-javascript",
    url = "https://github.com/pangloss/vim-javascript"
  },
  ["vim-jsonc"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-jsonc",
    url = "https://github.com/kevinoid/vim-jsonc"
  },
  ["vim-markdown"] = {
    config = { "        -- after/ftplugin/markdown.vim\n        -- after/syntax/markdown.vim\n        vim.g.vim_markdown_no_default_key_mappings = 1\n\n        -- indent by the given amount of spaces when hitting `o` and `O`, its annoying\n        vim.g.vim_markdown_new_list_item_indent = 0\n\n        -- so you can follow internal anchors\n        vim.g.vim_markdown_follow_anchor = 1\n\n        vim.g.vim_markdown_conceal = 1\n        -- dont conceal the backticks in code blocks\n        vim.g.vim_markdown_conceal_code_blocks = 0\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    config = { "\27LJ\2\n´\2\0\0\6\0\15\0\0276\0\0\0009\0\1\0006\1\0\0009\1\3\0019\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0006\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\v\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\texpr\2\6s\1\0\1\texpr\2Bvsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'\n<C-y>\6i\20nvim_set_keymap\bapi//site/pack/packer/start/friendly-snippets/\tdata\fstdpath\afn\22vsnip_snippet_dir\6g\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  },
  ["wiki.vim"] = {
    config = { '        -- the wiki root\n        vim.g.wiki_global_load = 0\n\n        vim.g.wiki_root = "~/notebook"\n\n        vim.g.wiki_filetypes = {"md"}\n\n        vim.g.wiki_link_target_type = "md"\n        vim.g.wiki_link_extension = ".md"\n\n        -- ~/.config/nvim/after/ftplugin/markdown.vim\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/wiki.vim",
    url = "https://github.com/lervag/wiki.vim"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/wilder.nvim",
    url = "https://github.com/gelguy/wilder.nvim"
  },
  ["zk-nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\azk\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/zk-nvim",
    url = "https://github.com/mickael-menu/zk-nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: wiki.vim
time([[Config for wiki.vim]], true)
        -- the wiki root
        vim.g.wiki_global_load = 0

        vim.g.wiki_root = "~/notebook"

        vim.g.wiki_filetypes = {"md"}

        vim.g.wiki_link_target_type = "md"
        vim.g.wiki_link_extension = ".md"

        -- ~/.config/nvim/after/ftplugin/markdown.vim
      
time([[Config for wiki.vim]], false)
-- Config for: sourcery
time([[Config for sourcery]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27 colorscheme sourcery \bcmd\bvim\0", "config", "sourcery")
time([[Config for sourcery]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n¯\4\0\0\6\0\25\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\6\0009\0\a\0009\0\b\0'\2\t\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2,<cmd>Telescope lsp_document_symbols<cr>\15<leader>fs\1\0\1\fnoremap\2!<cmd>Telescope help_tags<cr>\15<leader>fh\1\0\1\fnoremap\2\31<cmd>Telescope buffers<cr>\15<leader>fb\1\0\1\fnoremap\2!<cmd>Telescope live_grep<cr>\15<leader>fg\1\0\1\fnoremap\2\"<cmd>Telescope find_files<cr>\15<leader>ff\6n\20nvim_set_keymap\bapi\bvim\rdefaults\1\0\0\1\0\1\20layout_strategy\tflex\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})
        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})
      
time([[Config for vim-easy-align]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\nç\1\0\0\v\0\f\0\0256\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0B\3\1\0019\3\5\0\18\5\1\0'\a\6\0'\b\a\0005\t\b\0B\5\4\2\18\a\5\0009\5\t\0059\b\n\2'\n\v\0B\b\2\0A\5\1\0A\3\0\1K\0\1\0\a%a\23before_regex_check\14with_pair\1\2\0\0\trust\6>\6<\radd_rule\nsetup\25nvim-autopairs.conds\24nvim-autopairs.rule\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
        require("colorizer").setup({ "*", "!packer", }, { names = false })
      
time([[Config for nvim-colorizer.lua]], false)
-- Config for: rust.vim
time([[Config for rust.vim]], true)
try_loadstring("\27LJ\2\n8\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\27rust_recommended_style\6g\bvim\0", "config", "rust.vim")
time([[Config for rust.vim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
      
time([[Config for vim-fugitive]], false)
-- Config for: python-syntax
time([[Config for python-syntax]], true)
        vim.g.python_highlight_all = 1
        -- highlighting space errors is annoying
        vim.g.python_highlight_space_errors = 0
      
time([[Config for python-syntax]], false)
-- Config for: zk-nvim
time([[Config for zk-nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\azk\frequire\0", "config", "zk-nvim")
time([[Config for zk-nvim]], false)
-- Config for: venn.nvim
time([[Config for venn.nvim]], true)
try_loadstring("\27LJ\2\nä\4\0\0\b\0 \0S6\0\0\0009\0\1\0006\2\0\0009\2\2\0029\2\3\2B\0\2\2\a\0\4\0X\1:€6\1\0\0009\1\2\1+\2\2\0=\2\3\0016\1\0\0009\1\5\1'\2\a\0=\2\6\0016\1\0\0009\1\b\1'\3\t\0B\1\2\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\r\0'\6\14\0005\a\15\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\16\0'\6\17\0005\a\18\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\19\0'\6\20\0005\a\21\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\f\0'\5\22\0'\6\23\0005\a\24\0B\1\6\0016\1\0\0009\1\n\0019\1\v\1)\3\0\0'\4\25\0'\5\26\0'\6\27\0005\a\28\0B\1\6\1X\1\16€6\1\0\0009\1\5\1'\2\29\0=\2\6\0016\1\0\0009\1\b\1'\3\30\0B\1\2\0016\1\0\0009\1\b\1'\3\31\0B\1\2\0016\1\0\0009\1\2\1+\2\0\0=\2\3\1K\0\1\0\22mapclear <buffer>\17setlocal ve=\5\1\0\1\fnoremap\2\14:VBox<CR>\6f\6v\1\0\1\fnoremap\2\20<C-v>h:VBox<CR>\6H\1\0\1\fnoremap\2\20<C-v>l:VBox<CR>\6L\1\0\1\fnoremap\2\20<C-v>k:VBox<CR>\6K\1\0\1\fnoremap\2\20<C-v>j:VBox<CR>\6J\6n\24nvim_buf_set_keymap\bapi\20setlocal ve=all\bcmd\ball\16virtualedit\6o\bnil\17venn_enabled\6b\finspect\bvim…\1\1\0\6\0\t\0\v3\0\0\0007\0\1\0006\0\2\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0'\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\26:lua ToggleVenn()<CR>\14<leader>v\6n\20nvim_set_keymap\bapi\bvim\15ToggleVenn\0\0", "config", "venn.nvim")
time([[Config for venn.nvim]], false)
-- Config for: vim-vsnip
time([[Config for vim-vsnip]], true)
try_loadstring("\27LJ\2\n´\2\0\0\6\0\15\0\0276\0\0\0009\0\1\0006\1\0\0009\1\3\0019\1\4\1'\3\5\0B\1\2\2'\2\6\0&\1\2\1=\1\2\0006\0\0\0009\0\a\0009\0\b\0'\2\t\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\a\0009\0\b\0'\2\r\0'\3\n\0'\4\v\0005\5\14\0B\0\5\1K\0\1\0\1\0\1\texpr\2\6s\1\0\1\texpr\2Bvsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'\n<C-y>\6i\20nvim_set_keymap\bapi//site/pack/packer/start/friendly-snippets/\tdata\fstdpath\afn\22vsnip_snippet_dir\6g\bvim\0", "config", "vim-vsnip")
time([[Config for vim-vsnip]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16mini_config\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: harpoon
time([[Config for harpoon]], true)
try_loadstring("\27LJ\2\nŸ\3\0\0\f\0\15\0'6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1)\0\1\0)\1\4\0)\2\1\0M\0\18€6\4\0\0009\4\1\0049\4\2\4'\6\3\0'\a\n\0006\b\v\0\18\n\3\0B\b\2\2&\a\b\a'\b\f\0006\t\v\0\18\v\3\0B\t\2\2'\n\r\0&\b\n\b5\t\14\0B\4\5\1O\0îK\0\1\0\1\0\1\fnoremap\2\n)<cr>-<cmd>lua require('harpoon.ui').nav_file(\rtostring\r<leader>\1\0\1\fnoremap\2;<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>\15<leader>pp\1\0\1\fnoremap\0024<cmd>lua require('harpoon.mark').add_file()<cr>\15<leader>pa\6n\20nvim_set_keymap\bapi\bvim\0", "config", "harpoon")
time([[Config for harpoon]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\n’\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0)\1\3\0=\1\b\0K\0\1\0\26undotree_WindowLayout\6g\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\t<F5>\6n\20nvim_set_keymap\bapi\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
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
      
time([[Config for vim-markdown]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
