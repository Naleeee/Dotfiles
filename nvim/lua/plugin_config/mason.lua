return function()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "dockerls",
      "eslint",
      "graphql",
      "lua_ls",
      "tsserver",
      "vimls",
      "yamlls"
    },
    automatic_installation = true,
  })
end
