-- auto pairs {{{
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

npairs.setup()

npairs.add_rule(
  Rule("<", ">", {"rust"})
    :with_pair(cond.before_regex_check("%a"))
)
-- }}}
