return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        border = true,
      }
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)

      local builtin = require("telescope.builtin")
      local set_key = require("util").set_key

      set_key { "<leader>ff",
        builtin.find_files,
        desc = "find file in dir"
      }
      set_key { "<leader>fb",
        builtin.buffers,
        desc = "find buffer"
      }
      set_key { "<leader>fg",
        builtin.live_grep,
        desc = "live grep"
      }
      set_key { "<leader>fs",
        builtin.grep_string,
        desc = "search for string under cursor"
      }
      set_key { "<leader>fh",
        builtin.help_tags,
        desc = "find help tags"
      }
    end,
  }
}
