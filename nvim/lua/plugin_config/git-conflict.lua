return function()
  local map = require("utils").map

  require("git-conflict").setup(
    {
      -- disable buffer local mapping created by this plugin
      default_mappings = true,
      -- disable commands created by this plugin
      default_commands = true,
      -- This will disable the diagnostics in a buffer whilst it is conflicted
      disable_diagnostics = false,
      -- They must have background color, otherwise the default color will be used
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      }
    }
  )

  map("n", "<leader>m", "<Cmd>GitConflictListQf<CR>")
end
