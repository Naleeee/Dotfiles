set nocompatible

set nofixendofline                              " Disable adding new line and end of oppened files
set linebreak                                   " Split too long line smart

" Auto-completion
set wildignorecase                              " Make filenames autocompletion case-insensitive
set wildignore+=*.a,*.o,*.gcno,*.gcda           " Exclude tmp fils from autocompletion
set t_Co=256

set nocompatible

filetype on
filetype plugin on
filetype indent on

set autowriteall                                " Autowrite when replace in multiple buffers

set ignorecase                                  " Make search case insensitive

syntax enable                                   " Enable syntax highlight

set termguicolors                               " Set colorscheme
set cursorline                                  " Highlight current line

set clipboard=unnamedplus                       " Copy and paste between vim and others
set nocp

set number                                      " Display lines number
set nu rnu                                      " Make lines number display relative
set scrolloff=15                                " Make the cursor see x lines above cursor
set showbreak=↪                                 " Show line wrapping character
set pumheight=15                                " Maximum number of items to show in the popup menu

set smartcase

" autocmd FileType markdown :TSDisable highlight
" autocmd FileType markdown :TableModeEnable

" set filetypes as typescriptreact
" autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" Fold with 'zc' and 'zo'
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Keep undo history across sessions, by storing in file.
set undofile
if (!isdirectory("/tmp/undodir"))
  silent !mkdir /tmp/undodir
endif
set undodir=/tmp/undodir


" Clang-format
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
" autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Background
hi Normal ctermbg=none guibg=none

" Separate c file as a new type
" augroup project
  " autocmd!
  " autocmd BufRead,BufNewFile *.h,*.c set filetype=c
" augroup END

" Automatically call clang-format when saving a cpp file
" autocmd FileType cpp autocmd BufWritePre <buffer> ClangFormat
