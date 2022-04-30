-- add/remove comments with vim actions
require("mini.comment").setup()
-- highlight all the words in the buffer that the cursor in on
require("mini.cursorword").setup()
-- work with surrounding characters
-- require("mini.surround").setup()

-- highlight (not used) and remove trailing spaces
require("mini.trailspace").setup()

vim.api.nvim_set_keymap(
  "n",
  "<leader>cw",
  "<cmd>lua MiniTrailspace.trim()<cr>",
  { noremap = true }
)

-- meh
-- local indentscope = require("mini.indentscope")
--
-- indentscope.setup({
--   draw = {
--     animation = indentscope.gen_animation("none")
--   },
--   symbol = '|'
-- })
