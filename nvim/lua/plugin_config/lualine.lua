return function()
  local colors = {
    cyan      = '#79dac8',
    black     = '#080808',
    white     = '#c6c6c6',
    red       = '#E06C75',
    grey      = '#7893AD',
    orange    = '#fe8019',
    green     = '#98C379',
    main_grey = '#22262E',
    side_grey = '#2D3139',
  }

  -- Sections are structured in 6 different parts
  -- +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+

  local theme = {
    normal = {
      a = { fg = colors.black, bg = colors.red },
      b = { fg = colors.grey, bg = colors.side_grey },
      c = { fg = colors.grey, bg = colors.main_grey },
      x = { fg = colors.grey, bg = colors.main_grey },
      z = { fg = colors.side_grey, bg = colors.red },
      y = { fg = colors.green, bg = colors.side_grey, },
    },

    insert = { a = { fg = colors.black, bg = colors.green } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.orange } },

    inactive = {
      a = { fg = colors.white, bg = colors.black },
      b = { fg = colors.white, bg = colors.black },
      c = { fg = colors.black, bg = colors.black },
    },
  }

  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        'alpha',
        'packer',
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = { {
        'mode',
        separator = { right = '🭛' },
      } },

      lualine_b = {
        {
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 0,                -- 0: Just the filename / 1: Relative path / 2: Absolute path / 3: Absolute path, with tilde as the home directory / 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40,    -- Shortens path to leave 40 spaces in the window for other components.
          symbols = {
            modified = '[+]',      -- Text to show when the file is modified.
            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]',     -- Text to show for newly created file before first write
          },
          separator = { left = '🭋', right = '🭛' },
        }
      },

      lualine_c = {
        'branch',
        'diff'
      },

      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_lsp' },

          -- Displays diagnostics for the defined severity types
          sections = { 'error', 'warn', 'info', 'hint' },

          diagnostics_color = {
            -- Same values as the general color option can be used here.
            error = { bg = colors.main_grey, fg = colors.red },    -- Changes diagnostics' error color.
            warn  = { bg = colors.main_grey, fg = colors.orange }, -- Changes diagnostics' warn color.
            info  = { bg = colors.main_grey, fg = colors.cyan },   -- Changes diagnostics' info color.
            hint  = { bg = colors.main_grey, fg = colors.green },  -- Changes diagnostics' hint color.
          },
          colored = true,                                          -- Displays diagnostics status in color if set to true.
          update_in_insert = false,                                -- Update diagnostics in insert mode.
          always_visible = false,                                  -- Show diagnostics even if there are none.
        },
      },

      lualine_y = {
        {
          icon = {
            '󰉢 ',
            color = { fg = colors.black, bg = colors.green }
          },
          'progress',
          separator = { left = '🭮' },
        },
        {
          'searchcount'
        }
      },

      lualine_z = { {
        'filetype',
        'fileformat',
        colored = false, -- Displays filetype icon without colors
        separator = { left = '🭋' },
      } },
    },
    inactive_sections = {},
    tabline = {},
    inactive_tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'man', 'mason', 'nvim-tree', 'trouble' },
  }
end
