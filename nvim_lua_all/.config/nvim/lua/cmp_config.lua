local cmp = require("cmp")

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
    completeopt = "menuone,noselect",
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    -- { name = "zk" },
    -- { name = "orgmode" },
  },
})
