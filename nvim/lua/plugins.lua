return {
  -- Lsp manager
  {
    "williamboman/mason.nvim",
    config = require("plugin_config.mason"),
  },
  -- Link between Mason and LspConfig
  { "williamboman/mason-lspconfig.nvim" },
  -- Lsp manager
  {
    "neovim/nvim-lspconfig",
    dependencies = { {
      "RishabhRD/nvim-lsputils",
      dependencies = { "RishabhRD/popfix" },
    }, },
    config = require("plugin_config.nvim-lspconfig"),
  },
  -- Snippets manager
  {
    'hrsh7th/vim-vsnip',
    config = require('plugin_config.vsnip')
  },
  -- Git manager
  {
    "tpope/vim-fugitive",
  },
  -- Display discord activity
  --  {
  --   "andweeb/presence.nvim",
  --   config = require("plugin_config.presence"),
  -- }
  -- Display the available key bindings
  {
    "folke/which-key.nvim",
    config = require("plugin_config.which-key"),
  },
  -- Arduino manager plugin
  {
    'stevearc/vim-arduino'
  },




  -- Colorscheme

  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = require("plugin_config.catppuccin"),
  },




  -- Coding

  -- Auto pair brackets and parenthesis
  {
    "windwp/nvim-autopairs",
    config = require("plugin_config.nvim-autopairs"),
  },
  -- Smooth infile shifting
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = require("plugin_config.hop"),
  },
  -- Better comment handler
  {
    "numToStr/Comment.nvim",
    config = require("plugin_config.comment")
  },
  -- Spelling checker
  { "rhysd/vim-grammarous" },
  -- Auto close html / javascript tags
  {
    'windwp/nvim-ts-autotag',
    config = require("plugin_config.ts-autotag")
  },
  -- Auto completion handler
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
    },
    config = require('plugin_config.nvim-cmp'),
  },
  -- More auto completion
  {
    'codota/tabnine-nvim',
    build = "./dl_binaries.sh",
    config = require('plugin_config.tabnine'),
  },

  -- Prettier handler
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = require('plugin_config.null_ls'),
  },

  {
    'MunifTanjim/prettier.nvim',
    config = require('plugin_config.prettier'),
  },




  -- Editor

  -- Custom buffer line on top
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.bufferline"),
  },
  -- Custom status line on bottom
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    config = require("plugin_config.lualine"),
  },
  -- Custom startup page
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.alpha"),
  },
  -- File navigator
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
    },
    config = require("plugin_config.telescope"),
  },
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    -- tag = 'nightly', -- lazyional, updated every week. (see issue #1193)
    config = require("plugin_config.nvim-tree")
  },
  -- Better command and infile searchbar
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- lazyIONAL:
      --   `nvim-notify` is only needed, if you want to  the notification view.
      --   If not available, we  `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = require("plugin_config.noice")
  },
  -- Auto adjust window size
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end
  },
  {
    "alec-gibson/nvim-tetris",
  },



  -- UI

  -- Indent marker
  {
    "lukas-reineke/indent-blankline.nvim",
  },
  -- Active indent
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = require("plugin_config.indentscope"),
  },
  -- Pretty list for diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.trouble"),
  },
  -- Enhanced colors and highlighting
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = require("plugin_config.nvim-treesitter"),
  },
  -- Display whitespaces at end of lines
  {
    "ntpeters/vim-better-whitespace",
    config = require("plugin_config.vim-better-whitespace"),
  },
  -- Display hexa, rgb color
  {
    "lilydjwg/colorizer",
  },
  -- Better code action menu
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = require("plugin_config.neovim-code-action-menu"),
  },
  -- Add matching color for matching brackets, parenthesis...
  {
    "HiPhish/nvim-ts-rainbow2",
    config = require("plugin_config.nvim-ts-rainbow2"),
  },
  -- Git decorations
  {
    "lewis6991/gitsigns.nvim",
    config = require("plugin_config.gitsigns"),
  },
  -- Highlight other s of the current cursoe placement
  {
    "RRethy/vim-illuminate",
    config = require("plugin_config.vim-illuminate"),
  },
  {
    "tzachar/highlight-undo.nvim",
    config = require("plugin_config.highlight-undo"),
  },




  -- Markdown

  -- Markdown manager
  {
    "ixru/nvim-markdown",
  },
  -- Better table in Markdown
  {
    "dhruvasagar/vim-table-mode",
  },
  -- Table of content creator in Markdown
  {
    "mzlogin/vim-markdown-toc",
  },
  -- Preview a Markdown file
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = require("plugin_config.markdown-preview"),
    --   ft = { "markdown" },
  },
}

-- require("lazy").setup(plugins, {})
