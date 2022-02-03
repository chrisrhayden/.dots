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

-- a start menu when vim is invoked without a file to edit
local starter = require("mini.starter")

local items = {
  {
    name = "edit new file",
    action = [[enew]],
    section = "basic actions",
  },
  {
    name = "quit vim",
    action = [[quit]],
    section = "basic actions",
  },
}

local config_items = {
  { "init", "init.lua" },
  { "settings", "lua/settings.lua" },
  { "plugins", "lua/plugins.lua" },
  { "mappings", "lua/mappings.lua" },
  { "lsp_config", "lua/lsp_config.lua" },
  { "treesitter", "lua/treesitter_config.lua" },
}

-- this is stupid
for _, item in pairs(config_items) do
  table.insert(items, {
    name = item[1],
    action = [[execute "cd " . stdpath("config") | edit ]] .. item[2],
    section = "config",
  })
end

starter.setup({
  header = "praise the omnissiah",
  evaluate_single = true,
  items = items,
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.aligning("center", "center"),
  },
})

vim.cmd([[
  augroup StarterG
    autocmd!
    autocmd User MiniStarterOpened let &fillchars='eob: '
  augroup END
]])
