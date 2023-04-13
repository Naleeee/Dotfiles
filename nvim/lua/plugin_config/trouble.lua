return function()
  local map = require("utils").map

  require("trouble").setup {
    mode = "document_diagnostics",
  }

  map("n", "<leader>x", "<Cmd>TroubleToggle<CR>")
  map("n", "<leader>X", "<Cmd>TroubleToggle workspace_diagnostics<CR>")
end
