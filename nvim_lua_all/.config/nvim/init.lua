--------------------------------------------------------------------------------
-- vim init
--------------------------------------------------------------------------------

-- settings {{{
--------------------------------------------------------------------------------
-- set early so all leader mappings defined use this key
vim.g.mapleader = " "

-- lua/plugins.lua
require("plugins")

-- lua/settings.lua
require("settings")

-- lua/mappings.lua
require("mappings")

-- abbreviations
-- after/plugin/abolish.vim

-- after/ftplugin

-- c_settings.vim

-- web.vim
-- }}}

-- notes {{{
--------------------------------------------------------------------------------
-- * security:
--   `nomodeline` should be set but there really isn't a good replacement for
--   this functionality without crazy setup and config
--
--   since `noexrc` is on by default so `secure` should not be necessary but i
--   set both to on anyway

-- * neovim:
--   neovim has much better defaults, too many settings are changed or have
--   defaults to mention or keep commented out but will need to be set if i ever
--   use this rc with vanilla vim
--
--   neovim's default directory's are pretty good, putting most things in to
--   $XDG_DATA_HOME/nvim/{thing} but `backupdir` still try's for PWD
--
--   `:help vim-differences` in neovim for the differences

-- * cache:
--   meh, its probably not a big deal
--   vim can make a lot of files (e.g. swap, undo, backup, etc,) so there is
--   potential that it will fill up disk space, especially undo's i think.
--   maybe a cron/systemd job to clean up every now and then or if a directory
--   gets to big

-- * tabstop:
--   it sounds like you should be able to leave `tabstop` alone but there are so
--   many edge cases that it doesn't really work well, along with this i want
--   real tabs to be the equivalent amount of spaces visually so code and other
--   text lines up well, so it becomes much easier to set `tabstop` and have the
--   other tab settings like `expandtab` and `shiftwidth` use `tabstop`

-- * spell & thesaurus:
--   spelling/thesaurus files can be found here if vim does not download them
--   https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en

-- * alternative settings:
--   its very cumbersome to have alternative settings spread out, having
--   settings in a central file like `web.vim` can help but still sucks

-- * sources:
--   a lot of things in my rc come from stackoverflow but i didnt credit people
--   at first, but i have started to when it seems appropriate, sigh, i cant
--   find where i got a lot of my mappings, I've also changed them a lot by now,
--   i think an issues is the projects i think i got them from have changed,
--   anyway i think its mostly these projects in no order
--   https://github.com/liuchengxu/vim-better-default/
--   https://github.com/SpaceVim/SpaceVim

-- * misc:
--   netrw is needed for web access like opening or downloading links

-- * cool but unused:
--   insert unicode text instead of regular ascii in vim like 𝔳𝔦𝔪 or ᵛⁱᵐ
--     "segeljakt/vim-isotope"
--
--   a startup dashboard
--     "hardcoreplayers/dashboard-nvim"
-- }}}

-- todo's {{{
--------------------------------------------------------------------------------
-- * better organize my mappings
-- * find out why `wundo` wont make the file with a variable
-- * make debug mappings local to debug sessions
-- * figure out a way to change window dimensions so the focused window is
--   always the largest without affection floating windows
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
-- * a call tree
--   https://github.com/ldelossa/calltree.nvim
-- * a bunch of neovim stuff
--   https://www.reddit.com/r/neovim/comments/o20w3z/
--   what_are_your_favorite_neovim_plugins_exclusive/
-- * improve increment/decrement
--   https://github.com/monaqa/dial.nvim
-- * a file managers
--   https://github.com/tamago324/lir.nvim
--   https://github.com/elihunter173/dirbuf.nvim
-- * a prject manager
--   https://github.com/ahmedkhalf/project.nvim
-- }}}

-- vim: foldmethod=marker
