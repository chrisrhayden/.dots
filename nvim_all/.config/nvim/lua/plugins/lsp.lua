-- only show diagnostics if there isn't a popup window
function ShowLineDiagnostics()
  local wins = vim.api.nvim_list_wins()

  for _, win in pairs(wins) do
    local win_type = vim.fn.win_gettype(win)

    if win_type == "popup" then
      return
    end
  end

  vim.diagnostic.open_float(nil, {
    close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
  })
end

local function on_attach(client, bufnr)
  -- client.server_capabilities.semanticTokensProvider = nil
  client.server_capabilities.semanticTokensProvider = nil

  vim.opt.formatexpr = ""

  local set_key = require("util").set_key

  set_key {
    "<leader>n",
    vim.diagnostic.goto_next,
    buffer = bufnr,
    desc = "go to next diagnostic",
  }

  set_key {
    "<leader>N",
    vim.diagnostic.goto_prev,
    buffer = bufnr,
    desc = "go to prev diagnostic",
  }

  set_key { "gd", vim.lsp.buf.definition, desc = "go to definition" }
  set_key { "K", vim.lsp.buf.hover, desc = "open hove window" }
  set_key { "<leader>rn", vim.lsp.buf.rename, desc = "rename with lsp" }
  set_key { "<leader>ca", vim.lsp.buf.code_action, desc = "code action" }

  -- set_key {"<leader>q", vim.diagnostic.set_loclist, desc = ""}
  -- set_key {"gD", vim.lsp.buf.declaration, desc = ""}
  -- set_key {"<leader>D", vim.lsp.buf.type_definition, desc = ""}
  -- set_key {"gi", vim.lsp.buf.implementation, desc = ""}
  -- set_key {"gr", vim.lsp.buf.references, desc = ""}

  -- auto format files on save/write
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function() vim.lsp.buf.format() end,
    group = vim.api.nvim_create_augroup("AutoFormater", {}),
  })

  -- show diagnostics on hold
  vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = ShowLineDiagnostics,
    group = vim.api.nvim_create_augroup("HoldForDiagnostics", {}),
  })
end

vim.diagnostic.config {
  virtual_text = false,
  underline = false,
  signs = true,
  update_in_insert = true,
  float = {
    focusable = false,
    border = "rounded",
  }
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { focusable = false, border = "rounded" }
)

-- technically DiagnosticSign's are not lsp specific
-- but this is as good a place as any to set them
vim.fn.sign_define("DiagnosticSignError", {
  text = "E",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "W",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "I",
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "H",
  texthl = "DiagnosticSignHint",
})


return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim"
                },
                needdedFileStatus = {
                  ["codestyle-check"] = "Any"
                }
              }
            }
          }
        },
        rust_analyzer = {},
        clangd = {},
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for k, v in pairs(opts.servers) do
        lsp[k].setup(vim.tbl_deep_extend("force",
          { on_attach = on_attach, capabilities = capabilities }, v))
      end
    end
  },
}
