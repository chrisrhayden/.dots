return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    -- tag = '0.1.1',
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        -- layout_strategy = "vertical",
      }
    },
    config = true,
  }
}
