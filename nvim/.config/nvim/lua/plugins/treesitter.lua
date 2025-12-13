--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------

local set_keys = require("util").set_keys

local ts_langs = {
  "vimdoc",
  "bash",
  "c",
  "cmake",
  "cpp",
  "fish",
  "html",
  "json",
  "just",
  "lua",
  "make",
  "markdown",
  "python",
  "regex",
  "rust",
  "toml",
  "typescript",
  "javascript",
  "vim",
  "hyprlang",
}

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = function()
    local ts = require("nvim-treesitter")

    ts.install(ts_langs):wait()
    ts.update()
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ts_langs,
      callback = function(args)
        local ts = require("nvim-treesitter")
        local ts_installed = ts.get_installed();

        if not vim.tbl_contains(ts_installed, args.match) then
          vim.notify("installing treesitter for " .. args.match,
            vim.log.levels.INFO)

          ts.install(args.match):wait()
        end

        vim.treesitter.start(args.buf)
      end,
    })
  end
}

local text_objs = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  opts = {
    move = {
      set_jumps = true,
    }
  },
  config = function(_, opts)
    require("nvim-treesitter-textobjects").setup(opts)

    local select_textobject = require("nvim-treesitter-textobjects.select")
      .select_textobject

    local move_textobject = require("nvim-treesitter-textobjects.move")

    local text_mode = { "x", "o" }

    set_keys {
      {
        "af",
        function()
          select_textobject("@function.outer")
        end,
        mode = text_mode,
      },
      {
        "if",
        function()
          select_textobject("@function.inner")
        end,
        mode = text_mode,
      },
      {
        "ac",
        function()
          select_textobject("@class.outer")
        end,
        mode = text_mode,
      },
      {
        "ic",
        function()
          select_textobject("@class.inner")
        end,
        mode = text_mode,
      },
      {
        "]]",
        function()
          move_textobject.goto_next_start("@function.outer")
        end,
        mode = { "n", "x", "o" }
      },
      {
        "[[",
        function()
          move_textobject.goto_previous_start("@function.outer")
        end,
        mode = { "n", "x", "o" }
      }
    }

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "cpp",
    --   callback = function()
    --     vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    --     vim.wo.foldmethod = "expr"
    --   end
    -- })
  end
}

local endwise = {
  "RRethy/nvim-treesitter-endwise",
}

return { treesitter, text_objs, endwise }
