--------------------------------------------------------------------------------
-- vim init
--------------------------------------------------------------------------------

-- default settings {{{
--------------------------------------------------------------------------------
-- set early so all leader mappings defined use this key
vim.g.mapleader = " "

-- lua/plugins.lua
require("plugins")

vim.opt.conceallevel = 1

-- lua/settings.lua
require("settings")

-- lua/mappings.lua
require("mappings")

-- lua/lsp_config.lua
require("lsp_config")

-- this does not update the tree if highlighting is not enabled, and
-- highlighting does not work well with spellchecking
-- lua/treesitter_config.lua
-- require("treesitter_config")

vim.cmd("runtime wilder_config.vim")

-- abbreviations
-- after/plugin/abolish.vim

-- after/ftplugin

-- c_settings.vim

-- web.vim
-- }}}

-- notes {{{
--------------------------------------------------------------------------------
-- security:
--   `nomodeline` should be set but there really isn't a good replacement for
--   this functionality without crazy setup and config since `noexrc` is on by
--   default so `secure` should not be necessary but i set both to on anyway

-- neovim:
--   neovim has much better defaults, too many settings are changed or have
--   defaults to mention or keep commented out but will need to be set if i ever
--   use this rc with vanilla vim neovim's default directory's are pretty good,
--   putting most things in to $XDG_DATA_HOME/nvim/{thing} but `backupdir` still
--   try's for PWD see `:help vim-differences` in neovim for the differences

-- cache:
--   vim can make a lot of files (e.g. swap, undo, backup, etc,) so there is
--   potential that it will fill up disk space, especially undo's i think.
--   maybe a cron/systemd job to clean up every now and then or if a directory
--   gets to big

-- tabstop:
--   it sounds like you should be able to leave `tabstop` alone but there are so
--   many edge cases that it doesn't really work well, along with this i want
--   real tabs to be the equivalent amount of spaces visually so code and other
--   text lines up well, so it becomes much easier to set `tabstop` and have the
--   other tab settings like `expandtab` and `shiftwidth` use `tabstop`

-- spell & thesaurus:
--   spelling/thesaurus files can be found here if vim does not download them
--   https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en

-- alternative settings:
--   its very cumbersome to have alternative settings spread out, having
--   settings in a central file like `web.vim` can help but still sucks

-- sources:
--   a lot of things in my rc come from stackoverflow but i didnt credit people
--   at first, but i have started to when it seems appropriate sigh, i cant find
--   where i got a lot of my mappings, I've also changed them a lot by now, i
--   think an issues is the projects i think i got them from have changed,
--   anyway i think its mostly these projects in no order
--   https://github.com/liuchengxu/vim-better-default/
--   https://github.com/SpaceVim/SpaceVim

-- misc:
--   netrw is needed for web access like opening or downloading links

-- cool but unused:
--   insert unicode text instead of regular ascii in vim like 𝔳𝔦𝔪 or ᵛⁱᵐ
--   Plug 'segeljakt/vim-isotope'
--   a startup dashboard
--   Plug 'hardcoreplayers/dashboard-nvim'
-- }}}

-- todo's {{{
--------------------------------------------------------------------------------
-- * better organize my mappings
-- * find out why `wundo` wont make the file with a variable
-- * make debug mappings local to debug sessions
-- * figure out a way to change window dimensions so the focused window is always
--   the largest without affection floating windows
-- * find out a way to set NOTE in comments
--   see this stackoverflow for more
--   https://stackoverflow.com/questions/4097259/
--   in-vim-how-do-i-highlight-todo-and-fixme#comment24652856_4097541
-- }}}

-- good ideas {{{
--------------------------------------------------------------------------------
-- plugins to try later
-- * nvim-dap (debugger protocol)
--   https://github.com/mfussenegger/nvim-dap
--   https://github.com/rcarriga/nvim-dap-ui
-- * dont jump to the first search with *
--   https://stackoverflow.com/questions/4256697/
--   vim-search-and-highlight-but-do-not-jump
-- }}}

-- vim: foldmethod=marker
