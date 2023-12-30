local set_key = require("util").set_key

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

      local files = require("mini.files")

      files.setup()

      set_key {
        "-",
        function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end,
        desc = "open pwd in mini.files"
      }

      -- highlight and remove trailing spaces
      local trail = require("mini.trailspace")

      trail.setup()

      set_key {
        "<leader>cw",
        trail.trim,
        desc = "clear trailing white space"
      }
    end
  }
}
