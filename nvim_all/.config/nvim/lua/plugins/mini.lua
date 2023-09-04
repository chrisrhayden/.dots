return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- add/remove comments with vim actions
      require("mini.comment").setup()
      -- highlight all the words in the buffer that the cursor in on
      require("mini.cursorword").setup()
      -- align based on certain characters like `=`
      require("mini.align").setup()

      -- highlight and remove trailing spaces
      local trail = require("mini.trailspace")

      trail.setup()

      require("util").set_key {
        "<leader>cw",
        trail.trim,
        desc = "clear trailing white space"
      }
    end
  }
}
