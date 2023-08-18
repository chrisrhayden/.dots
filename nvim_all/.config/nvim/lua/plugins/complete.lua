-- local function expand_or_jump()
--   local cmp = require("cmp")
--   local luasnip = require("luasnip")
--
--   if cmp.visible() then
--     cmp.confirm()
--   elseif luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   end
-- end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    -- "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    -- "hrsh7th/cmp-path",
    -- {
    --   "rafamadriz/friendly-snippets",
    --   config = function()
    --     require("luasnip.loaders.from_vscode").lazy_load()
    --     require("luasnip.loaders.from_snipmate")
    --       .lazy_load { paths = "~/.config/nvim/snippets" }
    --   end,
    -- }
  },
  -- keys = {
  --   { "<C-y>", expand_or_jump, mode = { "i", "s" } }
  -- },
  event = "InsertEnter",
  opts = function()
    local cmp = require("cmp")

    local doc_window = cmp.config.window.bordered()

    doc_window.winhighlight =
    "Normal:NormalFLoat,FloatBorder:NormalFLoat,CursorLine:Visual,Search:None"

    return {
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "buffer", },
        { name = "nvim_lua" },
        -- { name = "luasnip" },
        { name = "orgmode" },
      },
      formatting = {
        -- fields = { "abbr", "kind" },
        -- see following ...
        -- `:h complete-items`
        -- https://github.com/hrsh7th/nvim-cmp/issues/88#issuecomment-906585635
        -- https://github.com/hrsh7th/nvim-cmp/issues/1154
        -- format = function(entry, vim_item)
        format = function(_, vim_item)
          vim_item.menu = nil
          -- vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
          -- match all none space characters and get the first match
          -- effectively getting the first word in a `abbr`
          vim_item.abbr = string.gmatch(vim_item.abbr, "%S*")()

          return vim_item
        end
      },
      window = {
        documentation = doc_window,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
      },
      completion = {
        completeopt = "menuone,noselect",
      },
      preselect = cmp.PreselectMode.None,
      -- snippet = {
      --   expand = function(args)
      --     require("luasnip").lsp_expand(args.body)
      --   end
      -- }
    }
  end,
}
