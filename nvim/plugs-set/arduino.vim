" Location path of arduino binary
let g:arduino_cmd = '/usr/share/arduino/arduino'
" Location path of arduino directory
let g:arduino_dir = '/usr/share/arduino'

" Status down airline
setl statusline=%!MyStatusLine()
function! MyStatusLine()
  let port = arduino#GetPort()
  let line = '[' . g:arduino_board . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction
setl statusline=%!MyStatusLine()
autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{MyStatusLine()}'
