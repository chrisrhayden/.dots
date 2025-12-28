return {
  {
    "nvim-telescope/telescope.nvim",
    tage = "v0.2.0",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {},
    -- opts = {
    --   defaults = {
    --     layout_strategy = "flex",
    --     border = true,
    --   }
    -- },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)

      local builtin = require("telescope.builtin")
      local set_key = require("util").set_key

      set_key { "<leader>ff",
        builtin.find_files,
        desc = "find file in dir"
      }

      set_key { "<leader>fg",
        builtin.live_grep,
        desc = "live grep"
      }
    end,
  }
}
