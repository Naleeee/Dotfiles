return function()
  require("highlight-undo").setup({
    hlgroup = 'HighlightUndo',
    duration = 1000,
    keymaps = {
      { 'n', 'u',     'undo', {} },
      { 'n', '<C-r>', 'redo', {} },
    }
  })
end
