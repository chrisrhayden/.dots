local cmp = require("cmp")

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

cmp.setup({
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
  },
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = "menuone,noselect",
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "spell", keyword_length = 5 },
    -- { name = "dictionary", keyword_length = 4 },
    -- { name = "zk" },
    -- { name = "orgmode" },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = "symbol",
    })
  },
  experimental = {
    native_menu = false,
  },
})
