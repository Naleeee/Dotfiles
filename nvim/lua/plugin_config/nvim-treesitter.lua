return function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "c", "cpp", "css", "python", "lua", "vim", "vimdoc", "markdown", "markdown_inline",
      "typescript", "tsx" },
    auto_install = true,
    highlight = {
      enable = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { "c", "rust" },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang)
        if lang == "diff" then
          return true
        end
      end,
      -- NOTE: Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    }
  })
end
