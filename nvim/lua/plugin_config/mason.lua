return function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "clangd",
      "cssls",
      "eslint",
      "lua_ls",
      "tsserver",
      "vimls",
    },
    automatic_installation = true,
  })
end
