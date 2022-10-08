let g:rainbow_active = 1 " Load vim-rainbow for all the files

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ [ 'nerdtree,markdown' , [] ],
    \ ]

let g:rainbow_guifgs = ['magenta', 'firebrick', 'gold', 'deepskyblue', 'slateblue']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
