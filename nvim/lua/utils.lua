local default_options = {
  noremap = true,
  silent = true
}

local M = {}

function M.map(mode, keys, action, opts)
  local options = default_options
  if opts then options = vim.tbl_extend("force", options, opts) end

  vim.api.nvim_set_keymap(mode, keys, action, options)
end

function M.buf_map(buffer, mode, keys, action, opts)
  local options = default_options
  if opts then options = vim.tbl_extend("force", options, opts) end

  vim.api.nvim_buf_set_keymap(buffer, mode, keys, action, options)
end

return M
