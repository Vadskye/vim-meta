" meta.vim - store file-specific meta information and vim commands
" Author: Kevin Johnson <vadskye@gmail.com>

" if vi compatible mode is set, don't load
if &cp || exists('g:loaded_meta')
    finish
endif
let g:loaded_meta = 1

" set default options
let g:meta_directory = get(g:, "meta_directory",
    \ $HOME . "/.vim/meta")
let g:meta_path_separator = get(g:, "meta_path_separator",
    \ has('win32')
        \ ? (&shellslash ? '[/:]' : '[\\:]')
        \ : '/')

" validate the options
" make sure the meta directory exists
if !isdirectory(g:meta_directory)
    call mkdir(g:meta_directory, 'p')
endif

command! -nargs=? Meta call meta#open_meta(<f-args>)
command! -nargs=1 MetaRelative call meta#open_meta(expand('%:p:h') . g:meta_path_separator . "<args>")
command! -nargs=? MetaLoad call meta#load_meta(<f-args>)
command! -nargs=1 MetaLoadRelative call meta#load_meta(expand('%:p:h') . g:meta_path_separator . "<args>")

autocmd BufReadPost * call meta#load_meta()
