" Setup leader
let mapleader=","


" Global

inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>
inoremap jK <Esc>
inoremap Jk <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>
nnoremap <C-k> <C-w>j
nnoremap <C-j> <C-w>h
nnoremap <C-i> <C-w>k
nnoremap <C-l> <C-w>l
map h <Insert>
map i <Up>
map k <Down>
map j <Left>
nmap <C-s> :x<CR>
map <C-u> <leader>c<Space><CR>
imap <C-s> <Esc>:x<CR>
nmap <ScrollWheelUp> i
nmap <ScrollWheelDown> k


" Git gutter

" Show preview popup
:nmap <leader>gp :GitGutterPreviewHunk<CR>
" HighLight modified lines
:nmap <leader>gh :GitGutterLineHighlightsToggle<CR>
" Reduce unchanging lines
:nmap <leader>gf :GitGutterFold<CR>
" Go to next change
:nmap <leader>gn :GitGutterNextHunk<CR>
" Go to previous change
:nmap <leader>gN :GitGutterPrevHunk<CR>


" Markdown preview

" Toggle Markdown Preview
nmap <C-p> :MarkdownPreviewToggle<CR>


" NERDTree

" Toggle NERDTree tab
map <C-n> :NERDTreeToggle<CR>


" Cmake

" Generate
nmap <leader>mg :CMakeGenerate<CR>
" Build
nmap <leader>mb :CMakeBuild<CR>
" Install
nmap <leader>mi :CMakeInstall<CR>
" Clean
nmap <leader>mc :CMakeClean<CR>
" Open window
nmap <leader>mo :CmakeOpen<CR>
" Close window
nmap <leader>mq :CMakeClose<CR>


" CoC

" Use `<leader>n` and `<leader>N` to navigate errors/warnings
nmap <silent> <leader>N <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>n <Plug>(coc-diagnostic-next)

" Code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Snippets
" Trigger snippets in completion
imap <C-l> <Plug>(coc-snippets-expand)

" Jump to next placeholder
vmap <C-j> <Plug>(coc-snippets-select)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show avaible quickfixs
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix
nmap <leader>qf  <Plug>(coc-fix-current)

" Forece display coc
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Toggle coc-tabnine
nmap <leader>tn :call CocAction('toggleExtension', 'coc-tabnine')<CR>

" Naviguate in buffers
nnoremap <leader>k :bn<CR>
nnoremap <leader>j :bp<CR>
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Toggle file and infile search
let g:ackprg = 'ag --vimgrep'
nmap <silent> <leader>e :Ag <CR>

" Open nmap
nmap <leader>l :HopWord<CR>
