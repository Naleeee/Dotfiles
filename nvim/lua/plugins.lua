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
  -- Package manager
  use { "wbthomason/packer.nvim" }

  -- Color theme
  -- use {
  --   "EdenEast/nightfox.nvim",
  --   config = require("plugin_config.nightfox"),
  -- }
  use {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require('plugin_config.catppuccin').setup()
    end,
    -- config = require("plugin_config.catppuccin"),
  }

  -- Portable package manager (LSP, DAP, Linters, ...)
  use {
    "williamboman/mason.nvim",
    config = require("plugin_config.mason"),
  }
  use { "williamboman/mason-lspconfig.nvim" }

  -- Enhanced colors and highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = require("plugin_config.nvim-treesitter"),
  }

  -- Buffers on top of the screen
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.bufferline"),
  }

  -- Line on the bottom of the screen
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = require("plugin_config.lualine"),
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      {
        "RishabhRD/nvim-lsputils",
        requires = { "RishabhRD/popfix" },
      },
    },
    config = require("plugin_config.nvim-lspconfig"),
  }

  -- Code action menu
  use {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = require("plugin_config.neovim-code-action-menu"),
  }
  -- Completion menu
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

  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- Snippets
  use {
    'hrsh7th/vim-vsnip',
    config = require('plugin_config.vsnip')
  }

  -- Greeter
  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.alpha"),
  }

  -- Editing
  use {
    "windwp/nvim-autopairs",
    config = require("plugin_config.nvim-autopairs"),
  }
  use {
    "luochen1990/rainbow",
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = require("plugin_config.indent-blankline"),
  }
  use {
    "rhysd/vim-grammarous",
  }

  -- Stylings
  use {
    "lilydjwg/colorizer",
  }

  -- Diagnostics menu
  use {
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = require("plugin_config.trouble"),
  }

  -- Git modification (on the left)
  use {
    "lewis6991/gitsigns.nvim",
    config = require("plugin_config.gitsigns"),
  }

  -- Navigation
  use {
    "phaazon/hop.nvim",
    branch = "v2",
    config = require("plugin_config.hop"),
  }

  -- Comments lines
  use {
    "numToStr/Comment.nvim",
    config = require("plugin_config.comment")
  }

  -- Highlight trailing whitespace
  use {
    "ntpeters/vim-better-whitespace",
    config = require("plugin_config.vim-better-whitespace"),
  }

  -- Search utilities
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
    },
    config = require("plugin_config.telescope"),
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
    config = require("plugin_config.nvim-tree")
  }

  -- JavaScript
  use {
    'windwp/nvim-ts-autotag',
    config = require("plugin_config.ts-autotag")
  }

  -- Todo Comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = require("plugin_config.todo-comments")
  }

  -- Markdown
  use {
    "ixru/nvim-markdown",
  }
  use {
    "dhruvasagar/vim-table-mode",
  }
  use {
    "mzlogin/vim-markdown-toc",
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = require("plugin_config.markdown-preview"),
    ft = { "markdown" },
  }

  -- Discord
  use {
    "andweeb/presence.nvim",
    config = require("plugin_config.presence"),
  }

  -- Image viewer
  use {
    "samodostal/image.nvim"
  }

  -- Notifier
  use {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  }

  use {
    "wakatime/vim-wakatime",
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
