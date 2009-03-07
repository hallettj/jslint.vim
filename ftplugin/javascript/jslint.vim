function! s:JSLint()
    if exists('b:errors')
      for error in b:errors
        call matchdelete(error)
      endfor
    endif

    let b:errors = []

    if has("win32")
      let s:cmd = 'cscript runjslint.wsf'
    else
      let s:cmd = 'js runjslint.js'
    endif

    let b:jslint_output = system(s:cmd, join(getline(1, '$'), "\n") . "\n")

    for error in split(b:jslint_output, "\n")
      let b:parts = matchlist(error, "line\\s\\+\\(\\d\\+\\)\\s\\+")
      if !empty(b:parts)
        call add(b:errors, matchadd('Error', '\%'.b:parts[1].'l'))
      endif
    endfor
endfunction

if !exists(":JSLint")
  command JSLint :call s:JSlint()
endif

