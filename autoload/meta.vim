if &cp || exists('g:loaded_meta_auto')
    finish
endif

function! meta#open_meta(...) abort
    let file_name = get(a:000, 0, expand('%:p'))
    let meta_file_path = s:get_meta_file_path(file_name)
    execute "vnew " . meta_file_path
endfunction

function! s:get_meta_file_path(file_name) abort
    return g:meta_directory . '/' . substitute(
        \ a:file_name,
        \ '\v' . g:meta_path_separator,
        \ '+',
        \ 'g'
    \ ) . '.vim'
endfunction

function! meta#load_meta(...) abort
    let file_name = get(a:000, 0, expand('%:p'))

    let meta_file_path = s:get_meta_file_path(file_name)
    if filereadable(meta_file_path)
        execute "source " . meta_file_path
        let b:meta_loaded = 1
    endif
endfunction

function! meta#is_meta_loaded() abort
    return exists('b:meta_loaded')
endfunction

let g:loaded_meta_auto = 1
