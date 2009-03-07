function! JSlint()
    if exists('s:errors')
        for error in s:errors
            call matchdelete(error)
        endfor
    endif

    let s:errors = []

    if has("win32")
        let s:cmd = 'cscript runjslint.wsf'
    else
        let s:cmd = 'js runjslint.js'
    endif

    let s:jslint_output = system(s:cmd, join(getline(1, '$'), "\n") . "\n")

    for error in split(s:jslint_output, "\n")
        let s:parts = matchlist(error, "line\\s\\+\\(\\d\\+\\)\\s\\+")
        if !empty(s:parts)
            call add(s:errors, matchadd('Error', '\%'.s:parts[1].'l'))
        endif
    endfor
endfunction

map <F5> :call JSlint()<CR>
