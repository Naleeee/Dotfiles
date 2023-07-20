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
      component_separators = '',
      section_separators = '',
      theme = theme,
    },
    sections = {

      -- Sections are structured in 6 different parts
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+

      lualine_a = { {
        'mode',
        separator = { right = '' },
      } },

      lualine_b = { {
        'filename',
        separator = { left = '', right = '' },
      } },

      lualine_c = {
        'branch',
        'diff'
      },

      lualine_x = {
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'error' },
          diagnostics_color = { error = { bg = colors.main_grey, fg = colors.red } },
        },
        {
          'diagnostics',
          source = { 'nvim' },
          sections = { 'warn' },
          diagnostics_color = { warn = { bg = colors.main_grey, fg = colors.orange } },
        },
      },

      lualine_y = { {
        icon = {
          '󰉢 ',
          color = { fg = colors.black, bg = colors.green }
        },
        'progress',
        separator = { left = '' },
      }, },

      lualine_z = { {
        'filetype',
        colored = false, -- Displays filetype icon without colors
        separator = { left = '' },
      } },
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
  }
end
