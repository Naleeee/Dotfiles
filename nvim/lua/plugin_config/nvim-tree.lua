return function()
  local map = require("utils").map

  -- disable netrw at the very start of your init.lua (strongly advised)
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  require("nvim-tree").setup({
    hijack_cursor = false,
    modified = {
      enable = true,
    },
    filters = {
      dotfiles = true,
    },
    git = {
      ignore = false,
    },
  });

  map("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")
end
