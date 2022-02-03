--------------------------------------------------------------------------------
-- lsp config
--------------------------------------------------------------------------------

CLIENT_NAMES = {}

local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
-- local null_ls = require("null-ls")

function ShowLineDiagnostics()
  local wins = vim.api.nvim_list_wins()
  local show = true

  for _, win in pairs(wins) do
    local win_type = vim.fn.win_gettype(win)

    if win_type == "popup" then
      show = false
    end
  end

  if show == true then
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter" },
      border = "rounded",
    })
  end
end

function LspStatus()
  if #vim.lsp.buf_get_clients() > 0 then
    local progress = lsp_status.status_progress()

    if progress ~= nil and progress ~= "" then
      return progress
    else
      return "[" .. table.concat(CLIENT_NAMES, ", ") .. "]"
    end
  end

  return ""
end

local function on_attach(client, bufnr)
  -- mappings
  local function bmap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function bopt(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  bopt("omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }

  local goto_opts = "{float = {focusable = false, border = 'rounded'}}"

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  bmap(
    "n",
    "<space>n",
    "<cmd>lua vim.diagnostic.goto_next(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap(
    "n",
    "<space>N",
    "<cmd>lua vim.diagnostic.goto_prev(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap(
    "n",
    "[d",
    "<cmd>lua vim.diagnostic.goto_prev(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap(
    "n",
    "]d",
    "<cmd>lua vim.diagnostic.goto_next(" .. goto_opts .. ")<cr>",
    opts
  )

  bmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  bmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>", opts)
  bmap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  bmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  bmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

  bmap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>", opts)

  bmap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  bmap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

  bmap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<cr>", opts)
  bmap("n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)

  -- workspace mappings
  bmap(
    "n",
    "<space>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
    opts
  )

  bmap(
    "n",
    "<space>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
    opts
  )

  bmap(
    "n",
    "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
    opts
  )

  lsp_status.on_attach(client)

  if vim.tbl_contains(CLIENT_NAMES, client.name) == false then
    table.insert(CLIENT_NAMES, client.name)
  end

  -- auto format files on save/write
  -- this wont trow an error for file types that dont have an lsp active i guess
  vim.api.nvim_exec(
    [[
  augroup AutoFormater
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
  augroup END
  ]],
    false
  )

  vim.api.nvim_exec(
    [[
  augroup HoldForDiagnostics
    autocmd!
    autocmd CursorHold * lua ShowLineDiagnostics()
  augroup END
  ]],
    false
  )
end

local function BasicSettings()
  return {
    capabilities = require("cmp_nvim_lsp").update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    ),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

local function CSettings()
  local server_settings = BasicSettings()

  server_settings["on_attach"] = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_buf_set_keymap(
      bufnr,
      "n",
      "<space><BS>",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      { noremap = true, silent = true }
    )
  end

  return server_settings
end

local function CSharpSettings()
  local server_settings = BasicSettings()

  server_settings["cmd"] = {
    "/usr/bin/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid()),
  }

  return server_settings
end

local function LuaSettings()
  local server_settings = BasicSettings()

  -- setup up nvim config files
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  server_settings["cmd"] = {
    "/usr/bin/lua-language-server",
    "-E",
    "/usr/lib/lua-language-server/main.lua",
  }
  server_settings["settings"] = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        -- make "vim" global
        globals = { "vim", "use" },
      },
      workspace = {
        -- add neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }

  return server_settings
end

local function RustSettings()
  local rust_settings = BasicSettings()

  rust_settings["settings"] = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
    },
  }

  return rust_settings
end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  omnisharp = CSharpSettings,
  clangd = CSettings,
  pyright = BasicSettings,
  rust_analyzer = RustSettings,
  tsserver = BasicSettings,
  sumneko_lua = LuaSettings,
}

for lsp, settings_func in pairs(servers) do
  nvim_lsp[lsp].setup(settings_func())
end

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
  },
})

lsp_status.config({
  indicator_errors = "",
  indicator_warnings = "",
  indicator_info = "",
  indicator_hint = "",
  indicator_ok = "",
  status_symbol = "",
})

lsp_status.register_progress()

vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  signs = true,
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { focusable = false, border = "rounded" }
)

vim.fn.sign_define("DiagnosticSignError", {
  text = "",
  texthl = "DiagnosticSignError",
})

vim.fn.sign_define("DiagnosticSignWarn", {
  text = "",
  texthl = "DiagnosticSignWarn",
})

vim.fn.sign_define("DiagnosticSignInfo", {
  text = "",
  texthl = "DiagnosticSignInfo",
})

vim.fn.sign_define("DiagnosticSignHint", {
  text = "",
  texthl = "DiagnosticSignHint",
})
