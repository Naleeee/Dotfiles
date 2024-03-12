return function()
  vim.g.strip_whitespace_on_save = 1

  -- Go to browser when opening a .md
  vim.g.mkdp_auto_start = 0

  -- Close browser when leaving a .md
  vim.g.mkdp_auto_close = 1

  -- Refreshes automatically the browser window
  vim.g.mkdp_refresh_slow = 1

  -- Give a name to your window
  vim.g.mkdp_page_title = "「${name}」-- Vim Markdown"

  vim.g.mkdp_filetypes = { "markdown", "md" }
end
