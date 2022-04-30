print("fuck")
vim.g.vsnip_snippet_dir = vim.fn.stdpath("data")
  .. "/site/pack/packer/start/friendly-snippets/"

vim.api.nvim_set_keymap(
  "i",
  "<C-y>",
  "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'",
  { expr = true }
)

vim.api.nvim_set_keymap(
  "s",
  "<C-y>",
  "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-y>'",
  { expr = true }
)
