return function()
  local lsp = require("lspconfig")

  local utils = require("utils")

  local map = utils.map

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  map("n", "<leader>of", "<Cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", "<leader>N", "<Cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", "<leader>n", "<Cmd>lua vim.diagnostic.goto_next()<CR>")

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) utils.buf_map(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if client.supports_method "textDocument/declaration" then
      buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
    end

    if client.supports_method "textDocument/definition" then
      buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
    end

    if client.supports_method "textDocument/implementation" then
      buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>")
    end

    if client.supports_method "textDocument/references" then
      buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
    end

    if client.supports_method "textDocument/hover" then
      buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
    end

    if client.supports_method "textDocument/rename" then
      buf_set_keymap("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>")
    end

    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Enable formatting on save",
        pattern = "*",
        group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
        command = "lua vim.lsp.buf.format()",
      })
    end
  end

  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        prefix = ""
      },
    }
  )

  vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

  lsp["lua_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    }
  }

  lsp["tsserver"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- Vue specific config
    -- init_options = {
    --   plugins = {
    --     {
    --       name = "@vue/typescript-plugin",
    --       location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
    --       languages = { "javascript", "typescript", "vue" },
    --     },
    --   },
    -- },
    -- filetypes = {
    --   "javascript",
    --   "typescript",
    --   "vue",
    -- },
  }

  local servers = {
    { name = "bashls" },
    { name = "clangd" },
    { name = "cssls" },
    -- { name = "cmake" },
    { name = "dockerls" },
    { name = "eslint" },
    { name = "vimls" },
    { name = "volar" },
    { name = "yamlls" },
  }

  for _, server in ipairs(servers) do
    lsp[server.name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
