vim.api.nvim_set_keymap(
  "n",
  "<leader>pa",
  "<cmd>lua require('harpoon.mark').add_file()<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>pp",
  "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
  { noremap = true }
)

for i = 1, 4 do
  vim.api.nvim_set_keymap(
    "n",
    "<leader>" .. tostring(i),
    "<cmd>lua require('harpoon.ui').nav_file(" .. tostring(i) .. ")<cr>",
    { noremap = true }
  )
end
