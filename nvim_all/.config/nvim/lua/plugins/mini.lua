return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- add/remove comments with vim actions
      require("mini.comment").setup()
      -- highlight all the words in the buffer that the cursor in on
      require("mini.cursorword").setup()
      -- highlight (not used) and remove trailing spaces
      require("mini.trailspace").setup()

      require("mini.align").setup()

      local trail = require("mini.trailspace")

      trail.setup()

      require("util").set_key {
        "<leader>cw",
        trail.trim,
        desc = "clear trainling white space"
      }
    end
  }
}
