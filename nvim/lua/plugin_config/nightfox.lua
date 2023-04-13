return function()
  require('nightfox').setup({
    options = {
      styles = {
        comments = "italic",
        constants = "bold",
        keywords = "bold",
      },
    },
  })

  vim.cmd("colorscheme nightfox")
end
