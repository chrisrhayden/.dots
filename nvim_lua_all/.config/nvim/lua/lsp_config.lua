local nvim_lsp = require("lspconfig")

require("null-ls").config {}

require("lspconfig")["null-ls"].setup {}

local on_attach = function(client, bufnr)
   vim.lsp.handlers["textDocument/hover"] =
     vim.lsp.with(vim.lsp.handlers.hover, {focusable = false})

   vim.lsp.handlers["textDocument/signatureHelp"] =
     vim.lsp.with(vim.lsp.handlers.hover, {focusable = false})

  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  })

  -- mappings
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  local goto_opts = "{popup_opts = {focusable = false}}"

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "<space>n",
    "<cmd>lua vim.lsp.diagnostic.goto_next(" .. goto_opts .. ")<cr>", opts)

  buf_set_keymap("n", "<space>N",
    "<cmd>lua vim.lsp.diagnostic.goto_prev(" .. goto_opts .. ")<cr>", opts)

  buf_set_keymap("n", "[d",
    "<cmd>lua vim.lsp.diagnostic.goto_prev(" .. goto_opts .. ")<cr>", opts)

  buf_set_keymap("n", "]d",
    "<cmd>lua vim.lsp.diagnostic.goto_next(" .. goto_opts .. ")<cr>", opts)

  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<cr>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)


  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<cr>", opts)

  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
  buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)

  -- workspace mappings
  buf_set_keymap("n", "<space>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", opts)
  buf_set_keymap("n",
    "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", opts)
  buf_set_keymap("n", "<space>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", opts)

  -- buf_set_keymap("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  -- buf_set_keymap("n", "<space>e",
  --   "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", opts)
end

local tsserver_attach = function(client, bufnr)
  on_attach(client, bufnr)

  -- client.resolved_capabilities.document_formatting = false

  local ts_utils = require("nvim-lsp-ts-utils")

  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,

    -- import all
    import_all_timeout = 5000, -- ms
    import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
    },
    import_all_scan_buffers = 100,
    import_all_select_source = false,

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    eslint_bin = "eslint",
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,

    -- formatting
    enable_formatting = false,
    formatter = "prettier",
    formatter_config_fallback = nil,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

  -- required to fix code action ranges
  ts_utils.setup_client(client)

  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gs", ":TSLspOrganize<CR>", {
  --   noremap = true, silent = true
  -- })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>qq", ":TSLspFixCurrent<CR>", {
    noremap = true, silent = true
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gr", ":TSLspRenameFile<CR>", {
    noremap = true, silent = true
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gi", ":TSLspImportAll<CR>", {
    noremap = true, silent = true
  })
end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  pyright = on_attach,
  rust_analyzer = on_attach,
  tsserver = tsserver_attach,
}

for lsp, attach_func in pairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = attach_func,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- auto format files on save/write
--
-- this wont trow an error for file types that dont have an lsp active i guess
vim.api.nvim_exec([[
augroup AutoFormater
  autocmd!
  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END
]], false)


vim.api.nvim_exec([[
augroup HoldForDiagnostics
  autocmd!
  autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics{focusable=false}
augroup END
]], false)


require("compe").setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    -- the border option is the same as `|help nvim_open_win|`
    border = { "", "" ,"", " ", "", "", "", " " },
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    ultisnips = true,
    luasnip = true,
  },
}

require("trouble").setup {
  auto_open = false,
  auto_close = true,
  signs = {
    -- icons / text used for a diagnostic
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = ""
  },
}

vim.api.nvim_set_keymap("n", "<leader>to", "<cmd>Trouble<cr>", {
  noremap = true,
  silent = true
})

vim.fn.sign_define("LspDiagnosticsSignError", {
  text = "",
  texthl = "LspDiagnosticsSignError",
})

vim.fn.sign_define("LspDiagnosticsSignWarning", {
  text = "",
  texthl = "LspDiagnosticsSignWarning",
})

vim.fn.sign_define("LspDiagnosticsSignInformation", {
  text = "",
  texthl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("LspDiagnosticsSignHint", {
  text = "",
  texthl = "LspDiagnosticsSignHint",
})
