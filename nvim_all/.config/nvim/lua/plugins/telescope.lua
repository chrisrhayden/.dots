return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
      }
    },
    config = true,
  }
}
