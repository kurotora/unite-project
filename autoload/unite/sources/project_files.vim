let s:save_cpo = &cpo
set cpo&vim

if !exists('g:unite_project_target_file')
    let g:unite_project_target_file = '.vimprojects'
endif

let s:project_file_list_buf = []

function! unite#sources#project_files#define()
    return s:source
endfunction

" source
let s:source = {
\   'name': 'project_files',
\   'description': 'file list from Project.vim',
\}

function! unite#sources#project_files#GetFileList()
    let ret = []
    let path_stack = []

    if s:project_file_list_buf == []
        let s:project_file_list_buf = readfile(g:unite_project_target_file)
    endif
    
    for l in s:project_file_list_buf
        if match(l, '\S') == -1

        elseif match(l, '}') != -1

        elseif match(l, '=') != -1
            call add(path_stack, matchstr(l, '=\zs\S*'))
        else
            let dir = ''
            for p in path_stack
                let dir = dir . '/' . p
            endfor
            let dir = dir[1:]   " 先頭の'/'を削除
            "let dir = matchstr(dir, '^/\zs\S*')     " 先頭の'/'を削除
            let file = matchstr(l, '\a.*\a*')      " 空白文字を削除
            call add(ret, {'file':file, 'dir':dir})
        endif
    endfor

    return ret
endfunction

function! s:source.gather_candidates(args, context)
    let candidates = map(unite#sources#project_files#GetFileList(), "{
                \ 'word' : v:val.file,
                \ 'kind' : 'file',
                \ 'action__path' : v:val.dir . '/' .  v:val.file,
                \}")
    return candidates
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

