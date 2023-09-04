local set_key = require("util").set_key

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover,
    { focusable = false, border = "rounded" })

local function on_attach(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil

  set_key {
    "gd",
    vim.lsp.buf.definition,
    buffer = bufnr,
    desc = "go to definition"
  }

  set_key {
    "gi",
    vim.lsp.buf.implementation,
    buffer = bufnr,
    desc = "show implementations in quick fix"
  }

  set_key {
    "K",
    vim.lsp.buf.hover,
    buffer = bufnr,
    desc = "open hover window"
  }
  set_key {
    "<leader>rn",
    vim.lsp.buf.rename,
    buffer = bufnr,
    desc = "rename with lsp"
  }

  set_key {
    "<leader>ca",
    vim.lsp.buf.code_action,
    buffer = bufnr,
    desc = "code action"
  }

  -- auto format files on save/write
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("AutoFormater", {}),
    -- idk why i have to wrap this function
    callback = function() vim.lsp.buf.format() end,
  })
end

local function mk_rust_settings()
  local rust_analyzer_cmd = vim.fn.system { "rustup", "which", "rust-analyzer" }

  if rust_analyzer_cmd == "" or rust_analyzer_cmd == nil then
    error("rustup did not find rust-analyzer")
  end

  rust_analyzer_cmd = rust_analyzer_cmd:gsub("[\r\n]", "")

  if rust_analyzer_cmd == "" or rust_analyzer_cmd == nil then
    error("could not find rust-analyzer from rust up output")
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


return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neodev.nvim",
        config = true,
      }
    },
    opts = {
      servers = {
        lua_ls = {},
        rust_analyzer = mk_rust_settings(),
        clangd = {
          {
            on_attach = function(client, bufnr)
              on_attach(client, bufnr)

              set_key {
                "<leader><bs>",
                ":ClangdSwitchSourceHeader<cr>",
                buffer = bufnr,
                desc = "switch to source or header files"
              }
            end
          }
        },
      }
    },
    config = function(_, opts)
      local lsp = require("lspconfig")

      for server_name, server_opts in pairs(opts.servers) do
        local server_setup =
          vim.tbl_deep_extend("force", {
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          }, server_opts)

        lsp[server_name].setup(server_setup)
      end
    end
  },
}
