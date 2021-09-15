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
local package_path_str = "/home/chris/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/chris/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/chris/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/chris/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/chris/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
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
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["i3config.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/i3config.vim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  my_vim_utils = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/my_vim_utils"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "        local npairs = require('nvim-autopairs')\n        local Rule = require('nvim-autopairs.rule')\n        local cond = require('nvim-autopairs.conds')\n\n        npairs.setup()\n\n        npairs.add_rule(\n          Rule(\"<\", \">\", {\"rust\"})\n            :with_pair(cond.before_regex_check(\"%a\"))\n        )\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "        require('colorizer').setup({\"*\"}, {names = false})\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["pest.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/pest.vim"
  },
  playground = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["python-syntax"] = {
    config = { "        vim.g.python_highlight_all = 1\n        -- highlighting space errors is annoying\n        vim.g.python_highlight_space_errors = 0\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/python-syntax"
  },
  ["ron.vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/ron.vim"
  },
  ["rust.vim"] = {
    config = { "        -- dont overwrite vim settings\n        vim.g.rust_recommended_style = 0\n\n        -- use vim's conceal and symbols like ⟶  and ⟹  to style code\n        -- the unicode char size depends on the terminal supporting double wide chars\n        -- vim.g.rust_conceal = 1\n        -- vim.g.rust_conceal_mod_path = 1\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  sourcery = {
    config = { 'vim.cmd("colorscheme sourcery")' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/sourcery"
  },
  ["telescope.nvim"] = {
    config = { '\27LJ\1\2�\4\0\0\6\0\21\00024\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\0013\0\6\0004\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\15\0%\4\16\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\17\0%\4\18\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\19\0%\4\20\0\16\5\0\0>\1\5\1G\0\1\0,<cmd>Telescope lsp_document_symbols<cr>\15<leader>ts!<cmd>Telescope help_tags<cr>\15<leader>th\31<cmd>Telescope buffers<cr>\15<leader>tb!<cmd>Telescope live_grep<cr>\15<leader>tg"<cmd>Telescope find_files<cr>\15<leader>tf\6n\20nvim_set_keymap\bapi\bvim\1\0\1\fnoremap\2\rdefaults\1\0\0\1\0\1\20layout_strategy\tflex\nsetup\14telescope\frequire\0' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  undotree = {
    config = { '        vim.api.nvim_set_keymap("n", "<F5>", ":UndotreeToggle<CR>", {noremap = true})\n\n        -- make undo pop up on the right\n        vim.g.undotree_WindowLayout = 3\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dirvish"] = {
    config = { "          -- disable netrw\n          vim.g.loaded_netrw = 1\n          vim.g.loaded_netrwPlugin = 1\n        " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-easy-align"] = {
    config = { '        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})\n        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-endwise"
  },
  ["vim-fugitive"] = {
    config = { '        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-glsl"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-javascript"
  },
  ["vim-jsonc"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-jsonc"
  },
  ["vim-markdown"] = {
    config = { "        -- after/ftplugin/markdown.vim\n        -- after/syntax/markdown.vim\n        vim.g.vim_markdown_no_default_key_mappings = 1\n\n        -- indent by the given amount of spaces when hitting `o` and `O`, its annoying\n        vim.g.vim_markdown_new_list_item_indent = 0\n\n        -- so you can follow internal anchors\n        vim.g.vim_markdown_follow_anchor = 1\n\n        -- vim.g.vim_markdown_conceal = 1\n        -- dont conceal the backticks in code blocks\n        vim.g.vim_markdown_conceal_code_blocks = 0\n      " },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-rsi"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-toml"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/vim-vsnip"
  },
  ["wiki.vim"] = {
    config = { '        -- the wiki root\n        vim.g.wiki_global_load = 0\n\n        vim.g.wiki_root = "~/notebook"\n\n        vim.g.wiki_filetypes = {"md"}\n\n        vim.g.wiki_link_target_type = "md"\n        vim.g.wiki_link_extension = ".md"\n\n        -- ~/.config/nvim/after/ftplugin/markdown.vim\n      ' },
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/wiki.vim"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/home/chris/.local/share/nvim/site/pack/packer/start/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: python-syntax
time([[Config for python-syntax]], true)
        vim.g.python_highlight_all = 1
        -- highlighting space errors is annoying
        vim.g.python_highlight_space_errors = 0
      
time([[Config for python-syntax]], false)
-- Config for: rust.vim
time([[Config for rust.vim]], true)
        -- dont overwrite vim settings
        vim.g.rust_recommended_style = 0

        -- use vim's conceal and symbols like ⟶  and ⟹  to style code
        -- the unicode char size depends on the terminal supporting double wide chars
        -- vim.g.rust_conceal = 1
        -- vim.g.rust_conceal_mod_path = 1
      
time([[Config for rust.vim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
        require('colorizer').setup({"*"}, {names = false})
      
time([[Config for nvim-colorizer.lua]], false)
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
-- Config for: vim-dirvish
time([[Config for vim-dirvish]], true)
          -- disable netrw
          vim.g.loaded_netrw = 1
          vim.g.loaded_netrwPlugin = 1
        
time([[Config for vim-dirvish]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
        vim.api.nvim_set_keymap("n", "<leader>a", "<Plug>(EasyAlign)", {})
        vim.api.nvim_set_keymap("x", "<leader>a", "<Plug>(EasyAlign)", {})
      
time([[Config for vim-easy-align]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
        vim.api.nvim_set_keymap("n", "<leader>gs", ":Git<cr>", {noremap = true})
      
time([[Config for vim-fugitive]], false)
-- Config for: undotree
time([[Config for undotree]], true)
        vim.api.nvim_set_keymap("n", "<F5>", ":UndotreeToggle<CR>", {noremap = true})

        -- make undo pop up on the right
        vim.g.undotree_WindowLayout = 3
      
time([[Config for undotree]], false)
-- Config for: sourcery
time([[Config for sourcery]], true)
vim.cmd("colorscheme sourcery")
time([[Config for sourcery]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring('\27LJ\1\2�\4\0\0\6\0\21\00024\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\0013\0\6\0004\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\15\0%\4\16\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\17\0%\4\18\0\16\5\0\0>\1\5\0014\1\a\0007\1\b\0017\1\t\1%\2\n\0%\3\19\0%\4\20\0\16\5\0\0>\1\5\1G\0\1\0,<cmd>Telescope lsp_document_symbols<cr>\15<leader>ts!<cmd>Telescope help_tags<cr>\15<leader>th\31<cmd>Telescope buffers<cr>\15<leader>tb!<cmd>Telescope live_grep<cr>\15<leader>tg"<cmd>Telescope find_files<cr>\15<leader>tf\6n\20nvim_set_keymap\bapi\bvim\1\0\1\fnoremap\2\rdefaults\1\0\0\1\0\1\20layout_strategy\tflex\nsetup\14telescope\frequire\0', "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')

        npairs.setup()

        npairs.add_rule(
          Rule("<", ">", {"rust"})
            :with_pair(cond.before_regex_check("%a"))
        )
      
time([[Config for nvim-autopairs]], false)
-- Config for: vim-markdown
time([[Config for vim-markdown]], true)
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
      
time([[Config for vim-markdown]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
