function! JSlint()
    if exists('s:errors')
        for error in s:errors
            call matchdelete(error)
        endfor
    endif

    let s:errors = []
    let s:jslint_output = system('js runjslint.js', join(getline(1, '$'), "\n") . "\n")

    for error in split(s:jslint_output, "\n")
        let s:parts = matchlist(error, "line\\s\\+\\(\\d\\+\\)\\s\\+")
        if !empty(s:parts)
            call add(s:errors, matchadd('Error', '\%'.s:parts[1].'l'))
        endif
    endfor
endfunction

map <F5> :call JSlint()<CR>
