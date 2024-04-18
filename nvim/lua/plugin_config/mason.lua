return function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "eslint",
      "lua_ls",
      "tsserver",
      "vimls",
      "volar",
    },
    automatic_installation = true,
  })
end
