return function()
  local map = require("utils").map

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

  require("bufferline").setup({
    highlights = {
      -- fill = { bg = colors.main_grey },
      -- buffer_selected = { bold = true, bg = colors.grey },
      -- tab_separator_selected = { fg = '', bg = colors.grey },
      -- separator = { fg = '', bg = colors.side_grey },
    },

    options = {
      mode = "buffers",                    -- set to "tabs" to only show tabpages instead
      numbers = "none", --[[ | "ordinal" | "buffer_id" | "both", ]]
      close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
      modified_icon = '●',
      max_name_length = 18,
      max_prefix_length = 8, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 18,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        if context.buffer:current() then
          return ''
        end
        if level:match('error') then
          return ' ' .. vim.g.diagnostic_icons.Error
        elseif level:match('warning') then
          return ' ' .. vim.g.diagnostic_icons.Warning
        end
        return ''
      end,
      custom_filter = function(buf_number, buf_numbers)
        if vim.bo[buf_number].filetype ~= 'oil' then
          return true
        end
      end,
      offsets = { {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      } },
      color_icons = true,              -- whether or not to add the filetype icon highlights
      show_buffer_icons = true,        -- disable filetype icons for buffers
      show_buffer_close_icons = false,
      show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
      show_close_icon = false,
      show_tab_indicators = false,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
      separator_style = 'thin',
      enforce_regular_tabs = true,
      always_show_bufferline = false,
      sort_by = 'insert_at_end',
    }
  })

  -- Buffer switching
  map("n", "<leader>j", "<Cmd>BufferLineCyclePrev<CR>")
  map("n", "<leader>k", "<Cmd>BufferLineCycleNext<CR>")
end
