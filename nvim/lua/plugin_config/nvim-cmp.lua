return function()
  local cmp = require('cmp')
  local types = require('cmp.types')

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    mapping = {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }), { 'i', 'c' }),
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }

  -- Enable auto complete on / and : commands
  -- cmp.setup.cmdline('/', {
  --   mappings = cmp.mapping.preset.cmdline(),
  --   sources = { name = 'buffer' }
  -- })
  --
  -- cmp.setup.cmdline(':', {
  --   mappings = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     {
  --       name = 'cmdline',
  --       option = {
  --         ignore_cmds = { 'Man', '!' }
  --       }
  --     }
  --   })
  -- })

  vim.opt.completeopt = { 'menuone', 'noselect' }
  -- Remove cmp status display
  vim.opt.shortmess:append('c')
end
