return function()
    vim.g.strip_whitespace_on_save = 1
    vim.g.strip_whitespace_confirm = 0
    vim.g.better_whitespace_ctermcolor = 'Red'
    vim.g.better_whitespace_guicolor = '#E06C75'
    vim.g.better_whitespace_filetypes_blacklist =
    {
        "diff",
        "fugitive",
        "git",
        "gitcommit",
        "help",
        "markdown",
        "qf",
        "startify",
        "unite",
    }
end
