local keymap = vim.keymap.set

require("telescope").setup({
  defaults = {
    layout_strategy = "flex",
  },
})

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")

keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

keymap("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>")
