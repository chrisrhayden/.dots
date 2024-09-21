--------------------------------------------------------------------------------
--- vim init
--------------------------------------------------------------------------------

--- settings {{{
--------------------------------------------------------------------------------

vim.g.mapleader = " "

require("settings")
require("mappings")
require("autocmds")
require("status_line")

require("util").setup_lazy()

--- }}}

--- notes {{{
--------------------------------------------------------------------------------
-- * security:
--   `modeline` should not be set but there really isn't a good replacement
--   for this functionality without annoying setup and/or config
--   NOTE: actually vim added `editorconfig` support so this might not be as
--   necessary, though it still wont help for individual files that want
--   different settings
--
--   `exrc` is off and rather unnecessary with `editorconfig` support. no need
--   to turn it on.

-- * neovim:
--   neovim's default directory's are pretty good, putting most things in to
--   $XDG_{DATA,STATE}_HOME/nvim/thing but `backupdir` still try's for $PWD
--
--   `:help vim-differences` in neovim for the differences

-- ** cache:
--    vim can make a lot of files (e.g. swap, undo, backup, etc,) so there is
--    potential that it will fill up disk space, especially undo's I think.
--    maybe a cron/systemd job to clean up every now and then or if a
--    directory gets to big. over all I've found it not a big deal.
--        meh, its probably not a big deal

-- ** tabstop:
--    it sounds like you should be able to leave `tabstop` alone but there are so
--    many edge cases that it doesn't really work well, along with this I want
--    real tabs to be the equivalent amount of spaces visually so code and other
--    text lines up well, its much easier to set `tabstop` and `expandtab`.

-- ** spell & thesaurus:
--    spelling/thesaurus files can be found here if vim does not download them
--    https://cgit.freedesktop.org/libreoffice/dictionaries/tree/en

-- * misc:
--   netrw is needed for web access like opening or downloading links
--     this is no longer true, yay

-- * code sources:
--   a lot of things in my rc come from stackoverflow but i didn't credit
--   people at first, but i have started to when it seems appropriate,
--   sigh, i cant find where i got a lot of my mappings, I've also changed
--   them a lot by now, i think an issue is the projects i think i got them
--   from have changed, anyway i think its mostly these projects in no
--   particular order
--   github.com/liuchengxu/vim-better-default/
--   github.com/SpaceVim/SpaceVim
--   github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua

-- }}}

--- todo's {{{
--------------------------------------------------------------------------------
-- * set up undo's to be saved on exit or something so they can be reloaded if
--   desired
--     i think this would be hard as you would need to merge old undo with the
--     new ones then re-save so vim can read them, as far as i know there is no
--     way to import undo's without adding them to undo history
-- * make debug mappings local to debug sessions,
--   i made debug mappings use the leader so its probably fine
-- }}}

--- things to try later {{{
--------------------------------------------------------------------------------
-- * a plugin to help make better vim habits
--   https://github.com/m4xshen/hardtime.nvim
-- * improve the nvim ui
--   https://github.com/stevearc/dressing.nvim
--   https://github.com/folke/noice.nvim
-- * nvim-dap (debugger protocol)
--   https://github.com/mfussenegger/nvim-dap
--   https://github.com/rcarriga/nvim-dap-ui
-- * don't jump to the first search with `n_*`
--   https://stackoverflow.com/questions/4256697/
--   vim-search-and-highlight-but-do-not-jump
-- * improve increment/decrement
--   https://github.com/monaqa/dial.nvim
-- * better % match
--   https://github.com/andymass/vim-matchup
-- }}}

-- vim: foldmethod=marker
