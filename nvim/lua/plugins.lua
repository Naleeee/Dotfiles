local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  ---@diagnostic disable-next-line: lowercase-global
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.api.nvim_create_autocmd("FileType", {
  pattern = "",
  command = "setlocal shiftwidth=2 tabstop=2"
})

return require("packer").startup(function(use)
  -- Utils

  -- Plugin manager
  use { "wbthomason/packer.nvim" }
  -- Package manager
  use {
    "williamboman/mason.nvim",
    config = require("plugin_config.mason"),
  }
  -- Link between Mason and LspConfig
  use { "williamboman/mason-lspconfig.nvim" }
  -- Lsp manager
  use {
    "neovim/nvim-lspconfig",
    requires = { {
      "RishabhRD/nvim-lsputils",
      requires = { "RishabhRD/popfix" },
    }, },
    config = require("plugin_config.nvim-lspconfig"),
  }
  -- Snippets manager
  use {
    'hrsh7th/vim-vsnip',
    config = require('plugin_config.vsnip')
  }
  -- Git diff viewer
  use {
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = require("plugin_config.diff-view"),
  }
  -- Display discord activity
  -- use {
  --   "andweeb/presence.nvim",
  --   config = require("plugin_config.presence"),
  -- }
  -- Display the available key bindings
  use {
    "folke/which-key.nvim",
    config = require("plugin_config.which-key"),
  }
  -- Arduino manager plugin
  use {
    'stevearc/vim-arduino'
  }




  -- Colorscheme

  -- Catppuccin theme
  use {
    "catppuccin/nvim",
    name = "catppuccin",
    config = require("plugin_config.catppuccin"),
  }




  -- Coding

  -- Auto pair brackets and parenthesis
  use {
    "windwp/nvim-autopairs",
    config = require("plugin_config.nvim-autopairs"),
  }
  -- Smooth infile shifting
  use {
    "phaazon/hop.nvim",
    branch = "v2",
    config = require("plugin_config.hop"),
  }
  -- Better comment handler
  use {
    "numToStr/Comment.nvim",
    config = require("plugin_config.comment")
  }
  -- Spelling checker
  use { "rhysd/vim-grammarous" }
  -- Auto close html / javascript tags
  use {
    'windwp/nvim-ts-autotag',
    config = require("plugin_config.ts-autotag")
  }
  -- Auto completion handler
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-cmdline',
    },
    config = require('plugin_config.nvim-cmp'),
  }
  -- More auto completion
  use {
    'codota/tabnine-nvim',
    run = "./dl_binaries.sh",
    config = require('plugin_config.tabnine'),
  }

  -- Prettier handler
  use {
    "prettier/vim-prettier",
  }




  -- Editor

  -- Custom buffer line on top
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.bufferline"),
  }
  -- Custom status line on bottom
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = require("plugin_config.lualine"),
  }
  -- Custom startup page
  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.alpha"),
  }
  -- File navigator
  use {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.2',
    requires = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make"
      },
    },
    config = require("plugin_config.telescope"),
  }
  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    -- tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = require("plugin_config.nvim-tree")
  }
  -- Fancy notifications about events
  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("plugin_config.notify")
    end,
  }
  -- Better command and infile searchbar
  use {
    "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = require("plugin_config.noice")
  }
  -- Auto adjust window size
  use {
    "anuvyklack/windows.nvim",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end
  }
  use {
    "alec-gibson/nvim-tetris",
  }



  -- UI

  -- Indent marker
  use {
    "lukas-reineke/indent-blankline.nvim",
  }
  -- Active indent
  use {
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
  }
  -- Pretty list for diagnostics
  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.trouble"),
  }
  -- Enhanced colors and highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = require("plugin_config.nvim-treesitter"),
  }
  -- Display whitespaces at end of lines
  use {
    "ntpeters/vim-better-whitespace",
    config = require("plugin_config.vim-better-whitespace"),
  }
  -- Display hexa, rgb color
  use {
    "lilydjwg/colorizer",
  }
  -- Better code action menu
  use {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = require("plugin_config.neovim-code-action-menu"),
  }
  -- Add matching color for matching brackets, parenthesis...
  use {
    "HiPhish/nvim-ts-rainbow2",
    config = require("plugin_config.nvim-ts-rainbow2"),
  }
  -- Git decorations
  use {
    "lewis6991/gitsigns.nvim",
    config = require("plugin_config.gitsigns"),
  }
  -- Highlight other uses of the current cursoe placement
  use {
    "RRethy/vim-illuminate",
    config = require("plugin_config.vim-illuminate"),
  }
  use {
    "tzachar/highlight-undo.nvim",
    config = require("plugin_config.highlight-undo"),
  }




  -- Markdown

  -- Markdown manager
  use {
    "ixru/nvim-markdown",
  }
  -- Better table in Markdown
  use {
    "dhruvasagar/vim-table-mode",
  }
  -- Table of content creator in Markdown
  use {
    "mzlogin/vim-markdown-toc",
  }
  -- Preview a Markdown file
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    config = require("plugin_config.markdown-preview"),
    --   ft = { "markdown" },
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
