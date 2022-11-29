set nofixendofline                              " Disable adding new line and end of oppened files
set linebreak                                   " Split too long line smart

" Auto-completion
set wildignorecase                              " Make filenames autocompletion case-insensitive
set wildignore+=*.a,*.o,*.gcno,*.gcda           " Exclude tmp fils from autocompletion
set t_Co=256

set autowriteall                                " Autowrite when replace in multiple buffers

set ignorecase                                  " Make search case insensitive

set termguicolors                               " Set colorscheme

set clipboard=unnamedplus                       " Copy and paste between vim and others
set nocp

set number                                      " Display lines number
set nu rnu                                      " Make lines number display relative

" Separate c file as a new type
augroup filetypedetect
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" Tab
set ts=4 sw=4
set expandtab
autocmd FileType javascript,groovy,yaml,vue,css,json,vim setlocal ts=2 sw=2 expandtab " Tab of 2 for js files

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

autocmd FileType c set cc=80                   " Show line for 80 columns

" Clang-format
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

source $HOME/.config/nvim/plugs-set/vimplug.vim

source $HOME/.config/nvim/plugs-set/notify.vim

syntax enable                                   " Enable syntax higllighing

source $HOME/.config/nvim/plugs-set/coc.vim
source $HOME/.config/nvim/plugs-set/coc-notify.vim

" source $HOME/.config/nvim/plugs-set/airline.vim
source $HOME/.config/nvim/plugs-set/alpha-nvim.vim
" source $HOME/.config/nvim/plugs-set/arduino.vim
source $HOME/.config/nvim/plugs-set/better-whitespace.vim
source $HOME/.config/nvim/plugs-set/bufferline.vim
source $HOME/.config/nvim/plugs-set/clang-format.vim
" source $HOME/.config/nvim/plugs-set/cmake.vim
" source $HOME/.config/nvim/plugs-set/gitgutter.vim
source $HOME/.config/nvim/plugs-set/gitmessenger.vim
source $HOME/.config/nvim/plugs-set/hop.vim
source $HOME/.config/nvim/plugs-set/image.vim
source $HOME/.config/nvim/plugs-set/indentline.vim
" source $HOME/.config/nvim/plugs-set/instant.vim
source $HOME/.config/nvim/plugs-set/mkdp.vim
source $HOME/.config/nvim/plugs-set/nerdcommenter.vim
source $HOME/.config/nvim/plugs-set/nerdtree.vim
source $HOME/.config/nvim/plugs-set/presence.vim
source $HOME/.config/nvim/plugs-set/rainbow.vim
source $HOME/.config/nvim/plugs-set/treesitter.vim
" source $HOME/.config/nvim/plugs-set/vimspector.vim

" Theme
" source $HOME/.config/nvim/plugs-set/onenord.vim
source $HOME/.config/nvim/plugs-set/nightfox.vim
" source $HOME/.config/nvim/plugs-set/catppuccin.vim

source $HOME/.config/nvim/keybindings/map.vim

" Separate c file as a new type
augroup project
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" Automatically call clang-format when saving a cpp file
autocmd FileType cpp autocmd BufWritePre <buffer> ClangFormat
