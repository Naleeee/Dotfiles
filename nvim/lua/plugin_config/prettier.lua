return function()
  local prettier = require("prettier")

  prettier.setup({
    bin = 'prettier', -- or `'prettier'` (v0.23.3+)
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
    cli_options = {
      config_precedence = "prefer-file", -- or "cli-override" or "file-override"

      arrow_parens = "always",
      bracket_spacing = true,
      bracket_same_line = true,
      embedded_language_formatting = "auto",
      end_of_line = "lf",
      html_whitespace_sensitivity = "css",
      jsx_single_quote = false,
      print_width = 100,
      prose_wrap = "preserve",
      quote_props = "as-needed",
      semi = true,
      single_attribute_per_line = false,
      single_quote = true,
      tab_width = 2,
      trailing_comma = "all",
      use_tabs = false,
      vue_indent_script_and_style = false,
    },
  })
end
