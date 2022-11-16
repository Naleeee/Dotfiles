call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Install Coc

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'
" With colors
Plug 'luochen1990/rainbow'

" A snazzy nail_care buffer line
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }

" Lean & mean status/tabline at the bottom for vim
Plug 'vim-airline/vim-airline'

" Add/Delete surrounders
" Plug 'tpope/vim-surround'

" Make scroll smooth
Plug 'psliwka/vim-smoothie'

" Automatically rename closing HTML/XML tags when editing opening ones
Plug 'AndrewRadev/tagalong.vim'

" Syntax highlighting and improved indentation for javascript
Plug 'pangloss/vim-javascript'

" Adds Discord support to show activity
Plug 'vbe0201/vimdiscord'

" Shows the history of commits under the cursor in popup window
Plug 'rhysd/git-messenger.vim'

" A file system explorer for the Vim editor
Plug 'preservim/nerdtree'
" Plugin show git status flags
Plug 'Xuyuanp/nerdtree-git-plugin'

" Compiling, uploading, and debugging arduino sketches
" Plug 'stevearc/vim-arduino'

" Display thin vertical lines at each indentation level for code indented with spaces
Plug 'yggdroot/indentline'

" Vim graphical debugger for multiple languages
" Plug 'puremourning/vimspector'

" Add better files icons
Plug 'ryanoasis/vim-devicons'

" Highlight trailing spaces
Plug 'ntpeters/vim-better-whitespace'

" Shows a git diff in the sign column
Plug 'airblade/vim-gitgutter'

" Open markdown preview on browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Better TODO manager
Plug 'wsdjeg/vim-todo'

" Building CMake projects inside
Plug 'cdelledonne/vim-cmake'

" Collaborative editor
Plug 'jbyuki/instant.nvim'

" Better comment functions
Plug 'preservim/nerdcommenter'

" This plugin formats your code with specific coding style using clang-format
Plug 'rhysd/vim-clang-format'

" A color picker/selector directly from the editor
Plug 'KabbAmine/vCoolor.vim'

" THEME
" Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
" Plug 'catppuccin/nvim', { 'as': 'catppuccin'  }
Plug 'EdenEast/nightfox.nvim'

" HTML5 + inline SVG omnicomplete function, indent and syntax
Plug 'othree/html5.vim'

" Makes your javascript files support React jsx correctly
Plug 'neoclide/vim-jsx-improve'

" A powerful grammar checker
Plug 'rhysd/vim-grammarous'

" Image Viewer as ASCII Art
Plug 'samodostal/image.nvim'

" Dependency plenary
Plug 'nvim-lua/plenary.nvim'

" Make quickfix window better
Plug 'kevinhwang91/nvim-bqf'

" A fancy, configurable, notification manager
Plug 'rcarriga/nvim-notify'

" Git plugin
Plug 'tpope/vim-fugitive'

" The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Colorize all text in the form #rgb, #rgba, #rrggbb, #rrgbbaa, rgb(...), rgba(...)
Plug 'lilydjwg/colorizer'

" Keyword and regex-based syntax highlighting for C and C++
Plug 'bfrg/vim-cpp-modern'

" file and infile search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Jump anywhere in a document with as few keystrokes as possible
Plug 'phaazon/hop.nvim'

call plug#end()
