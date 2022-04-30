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
  LuaSnip = {
    config = { "\27LJ\2\nµ\1\0\0\6\0\n\0\0176\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0!<Plug>luasnip-expand-or-jump\n<C-y>\6i\bset\vkeymap\bvim\14lazy_load luasnip.loaders.from_vscode\fluasnip\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
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
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
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
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
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
  ["nrpattern.nvim"] = {
    config = { "\27LJ\2\nù\1\0\0\5\0\t\0\0166\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\3\4\0009\3\5\3'\4\6\0B\1\3\0016\1\0\0'\3\a\0B\1\2\0029\1\b\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\14nrpattern\trust\14filetypes\20(-?%d[%d_]+%d+)\vinsert\ntable\22nrpattern.default\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nrpattern.nvim",
    url = "https://github.com/zegervdv/nrpattern.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n›\1\0\0\v\0\f\0\0256\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0B\3\1\0019\3\5\0\18\5\1\0'\a\6\0'\b\a\0'\t\b\0B\5\4\2\18\a\5\0009\5\t\0059\b\n\2'\n\v\0B\b\2\0A\5\1\0A\3\0\1K\0\1\0\a%a\17before_regex\14with_pair\trust\6>\6<\radd_rule\nsetup\25nvim-autopairs.conds\24nvim-autopairs.rule\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15cmp_config\frequire\0" },
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
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15lsp_config\frequire\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22treesitter_config\frequire\0" },
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
  ["python-syntax"] = {
    config = { '\27LJ\2\nd\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0"python_highlight_space_errors\25python_highlight_all\6g\bvim\0' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/python-syntax",
    url = "https://github.com/vim-python/python-syntax"
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
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21telescope_config\frequire\0" },
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
    config = { "\27LJ\2\ní\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0)\1\3\0=\1\b\0K\0\1\0\26undotree_WindowLayout\6g\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\t<F5>\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["venn.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16venn_config\frequire\0" },
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
    config = { "\27LJ\2\n≈\2\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0Ü\2          command! -nargs=? -complete=dir Explore Dirvish <args>\n          command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>\n          command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>\n        \bcmd\17loaded_netrw\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/opt/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\n|\0\0\6\0\a\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\6x\22<Plug>(EasyAlign)\aga\6n\20nvim_set_keymap\bapi\bvim\0" },
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
    config = { "\27LJ\2\n˘\1\0\0\2\0\a\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1\0\0=\1\6\0K\0\1\0%vim_markdown_conceal_code_blocks\25vim_markdown_conceal\31vim_markdown_follow_anchor&vim_markdown_new_list_item_indent)vim_markdown_no_default_key_mappings\6g\bvim\0" },
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
  ["wiki.vim"] = {
    config = { "\27LJ\2\nŒ\1\0\0\2\0\v\0\0216\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0K\0\1\0\b.md\24wiki_link_extension\amd\26wiki_link_target_type\1\2\0\0\amd\19wiki_filetypes\15~/notebook\14wiki_root\21wiki_global_load\6g\bvim\0" },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/wiki.vim",
    url = "https://github.com/lervag/wiki.vim"
  },
  ["wilder.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\30runtime wilder_config.vim\bcmd\bvim\0" },
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
-- Config for: nrpattern.nvim
time([[Config for nrpattern.nvim]], true)
try_loadstring("\27LJ\2\nù\1\0\0\5\0\t\0\0166\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\3\4\0009\3\5\3'\4\6\0B\1\3\0016\1\0\0'\3\a\0B\1\2\0029\1\b\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\14nrpattern\trust\14filetypes\20(-?%d[%d_]+%d+)\vinsert\ntable\22nrpattern.default\frequire\0", "config", "nrpattern.nvim")
time([[Config for nrpattern.nvim]], false)
-- Config for: python-syntax
time([[Config for python-syntax]], true)
try_loadstring('\27LJ\2\nd\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0"python_highlight_space_errors\25python_highlight_all\6g\bvim\0', "config", "python-syntax")
time([[Config for python-syntax]], false)
-- Config for: wiki.vim
time([[Config for wiki.vim]], true)
try_loadstring("\27LJ\2\nŒ\1\0\0\2\0\v\0\0216\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0005\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0K\0\1\0\b.md\24wiki_link_extension\amd\26wiki_link_target_type\1\2\0\0\amd\19wiki_filetypes\15~/notebook\14wiki_root\21wiki_global_load\6g\bvim\0", "config", "wiki.vim")
time([[Config for wiki.vim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\n|\0\0\6\0\a\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\4\0'\4\5\0004\5\0\0B\0\5\1K\0\1\0\6x\22<Plug>(EasyAlign)\aga\6n\20nvim_set_keymap\bapi\bvim\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: rust.vim
time([[Config for rust.vim]], true)
try_loadstring("\27LJ\2\n8\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\27rust_recommended_style\6g\bvim\0", "config", "rust.vim")
time([[Config for rust.vim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15cmp_config\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: sourcery
time([[Config for sourcery]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27 colorscheme sourcery \bcmd\bvim\0", "config", "sourcery")
time([[Config for sourcery]], false)
-- Config for: zk-nvim
time([[Config for zk-nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\azk\frequire\0", "config", "zk-nvim")
time([[Config for zk-nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
      
time([[Config for vim-fugitive]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15lsp_config\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22treesitter_config\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
try_loadstring("\27LJ\2\n˘\1\0\0\2\0\a\0\0216\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\5\0006\0\0\0009\0\1\0)\1\0\0=\1\6\0K\0\1\0%vim_markdown_conceal_code_blocks\25vim_markdown_conceal\31vim_markdown_follow_anchor&vim_markdown_new_list_item_indent)vim_markdown_no_default_key_mappings\6g\bvim\0", "config", "vim-markdown")
time([[Config for vim-markdown]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n›\1\0\0\v\0\f\0\0256\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0B\3\1\0019\3\5\0\18\5\1\0'\a\6\0'\b\a\0'\t\b\0B\5\4\2\18\a\5\0009\5\t\0059\b\n\2'\n\v\0B\b\2\0A\5\1\0A\3\0\1K\0\1\0\a%a\17before_regex\14with_pair\trust\6>\6<\radd_rule\nsetup\25nvim-autopairs.conds\24nvim-autopairs.rule\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nµ\1\0\0\6\0\n\0\0176\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0B\0\1\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0'\3\b\0'\4\t\0004\5\0\0B\0\5\1K\0\1\0!<Plug>luasnip-expand-or-jump\n<C-y>\6i\bset\vkeymap\bvim\14lazy_load luasnip.loaders.from_vscode\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: wilder.nvim
time([[Config for wilder.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\30runtime wilder_config.vim\bcmd\bvim\0", "config", "wilder.nvim")
time([[Config for wilder.nvim]], false)
-- Config for: venn.nvim
time([[Config for venn.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16venn_config\frequire\0", "config", "venn.nvim")
time([[Config for venn.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\ní\1\0\0\6\0\t\0\r6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\a\0)\1\3\0=\1\b\0K\0\1\0\26undotree_WindowLayout\6g\1\0\1\fnoremap\2\24:UndotreeToggle<CR>\t<F5>\6n\20nvim_set_keymap\bapi\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
        require("colorizer").setup({ "*", "!packer", }, { names = false })
      
time([[Config for nvim-colorizer.lua]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16mini_config\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21telescope_config\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
