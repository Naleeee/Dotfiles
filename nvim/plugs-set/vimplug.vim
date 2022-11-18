call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'} "-------------------------------- Install Coc

Plug 'jiangmiao/auto-pairs' "------------------------------------------------------ Insert or delete brackets, parens, quotes in pair
Plug 'luochen1990/rainbow' "------------------------------------------------------- With colors

" Plug 'vim-airline/vim-airline' "--------------------------------------------------- Lean & mean status/tabline at the top and bottom for vim
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' } "-------------------------------- A snazzy nail_care buffer line

" Plug 'tpope/vim-surround' "------------------------------------------------------ Add/Delete surrounders

Plug 'psliwka/vim-smoothie' "------------------------------------------------------ Make scroll smooth

Plug 'AndrewRadev/tagalong.vim' "-------------------------------------------------- Automatically rename closing HTML/XML tags when editing opening ones

Plug 'pangloss/vim-javascript' "--------------------------------------------------- Syntax highlighting and improved indentation for javascript

Plug 'andweeb/presence.nvim' "-------------------------------------------------------- Adds Discord support to show activity

Plug 'rhysd/git-messenger.vim' "--------------------------------------------------- Shows the history of commits under the cursor in popup window

Plug 'preservim/nerdtree' "-------------------------------------------------------- A file system explorer for the Vim editor

Plug 'Xuyuanp/nerdtree-git-plugin' "----------------------------------------------- Plugin show git status flags

" Plug 'stevearc/vim-arduino' "---------------------------------------------------- Compiling, uploading, and debugging arduino sketches

Plug 'yggdroot/indentline' "------------------------------------------------------- Display thin vertical lines at each indentation level for code indented with spaces

" Plug 'puremourning/vimspector' "------------------------------------------------- Vim graphical debugger for multiple languages

Plug 'nvim-tree/nvim-web-devicons' "----------------------------------------------- Add better files icons
Plug 'chrisbra/unicode.vim' "------------------------------------------------------ Add unicode icon search

Plug 'ntpeters/vim-better-whitespace' "-------------------------------------------- Highlight trailing spaces

" Plug 'airblade/vim-gitgutter' "---------------------------------------------------- Shows a git diff in the sign column

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } "--------- Open markdown preview on browser

" Plug 'wsdjeg/vim-todo' "----------------------------------------------------------- Better todo manager

" Plug 'cdelledonne/vim-cmake' "----------------------------------------------------- Building CMake projects inside

" Plug 'jbyuki/instant.nvim' "------------------------------------------------------- Collaborative editor

Plug 'preservim/nerdcommenter' "--------------------------------------------------- Better comment functions

Plug 'rhysd/vim-clang-format' "---------------------------------------------------- This plugin formats your code with specific coding style using clang-format

Plug 'KabbAmine/vCoolor.vim' "----------------------------------------------------- A color picker/selector directly from the editor

" Plug 'rmehri01/onenord.nvim', { 'branch': 'main' } "----------------------------- Theme
" Plug 'catppuccin/nvim', { 'as': 'catppuccin'  }
Plug 'EdenEast/nightfox.nvim'

Plug 'othree/html5.vim' "---------------------------------------------------------- HTML5 + inline SVG omnicomplete function, indent and syntax

Plug 'neoclide/vim-jsx-improve' "-------------------------------------------------- Makes your javascript files support React jsx correctly

" Plug 'rhysd/vim-grammarous' "------------------------------------------------------ A powerful grammar checker

Plug 'nvim-lua/plenary.nvim' "----------------------------------------------------- Dependency plenary

Plug 'samodostal/image.nvim' "----------------------------------------------------- Image Viewer as ASCII Art

Plug 'kevinhwang91/nvim-bqf' "----------------------------------------------------- Make quickfix window better

Plug 'rcarriga/nvim-notify' "------------------------------------------------------ A fancy, configurable, notification manager

Plug 'tpope/vim-fugitive' "-------------------------------------------------------- Git plugin

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "----------------------- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter

Plug 'lilydjwg/colorizer' "-------------------------------------------------------- Colorize all text in the form #rgb, #rgba, #rrggbb, #rrgbbaa, rgb(...), rgba(...)

Plug 'bfrg/vim-cpp-modern' "------------------------------------------------------- Keyword and regex-based syntax highlighting for C and C++

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "------------------------------ File and infile search
Plug 'junegunn/fzf.vim'

Plug 'phaazon/hop.nvim' "---------------------------------------------------------- Jump anywhere in a document with as few keystrokes as possible

call plug#end()
