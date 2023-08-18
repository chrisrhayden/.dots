local set_key = require("util").set_key

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
  client.server_capabilities.semanticTokensProvider = nil

  vim.opt.formatexpr = ""

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
  set_key { "K", vim.lsp.buf.hover, desc = "open hover window" }
  set_key { "<leader>rn", vim.lsp.buf.rename, desc = "rename with lsp" }
  set_key { "<leader>ca", vim.lsp.buf.code_action, desc = "code action" }

  -- auto format files on save/write
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    -- idk why i have to wrap this function
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

local function mk_c_settings()
  return {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      set_key {
        "<leader><bs>",
        ":ClangdSwitchSourceHeader<cr>", desc = "switch sourve and header"
      }
    end
  }
end

local function mk_rust_settings()
  local rust_analyzer_cmd = vim.fn.system { "rustup", "which", "rust-analyzer" }

  rust_analyzer_cmd = rust_analyzer_cmd:gsub("[\r\n]", "")

  if rust_analyzer_cmd == "" or rust_analyzer_cmd == nil then
    error("did not find rust-analyzer")
  end

  return {
    cmd = { rust_analyzer_cmd },
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy"
        }
      }
    }
  }
end

local function mk_lua_settings()
  return {
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
  }
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
  text = "",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "󰍉",
  texthl = "DiagnosticSignHint",
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = mk_lua_settings(),
        rust_analyzer = mk_rust_settings(),
        clangd = mk_c_settings(),
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")

      for server_name, server_opts in pairs(opts.servers) do
        local server_setup = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        }, server_opts)

        lsp[server_name].setup(server_setup)
      end
    end
  },
}
