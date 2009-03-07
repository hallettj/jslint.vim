function! s:JSLint()
    if exists('b:errors')
      for error in b:errors
        call matchdelete(error)
      endfor
    endif

    let b:errors = []

    if has("win32")
      let s:cmd = 'cscript'
      let s:runjslint_ext = 'wsf'
    else
      let s:cmd = 'js'
      let s:runjslint_ext = 'js'
    endif
    let s:plugin_path = expand("~/") . ".vim/ftplugin/javascript/"
    let s:cmd = "cd " . s:plugin_path . " && " . s:cmd . " runjslint." . s:runjslint_ext

    let b:jslint_output = system(s:cmd, join(getline(1, '$'), "\n") . "\n")

    for error in split(b:jslint_output, "\n")
      let b:parts = matchlist(error, "line\\s\\+\\(\\d\\+\\)\\s\\+")
      if !empty(b:parts)
        call add(b:errors, matchadd('Error', '\%'.b:parts[1].'l'))
      endif
    endfor
endfunction

if !exists(":JSLint")
  command JSLint :call s:JSLint()
endif

