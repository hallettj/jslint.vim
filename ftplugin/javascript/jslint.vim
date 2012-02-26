
" Global Options
"
" Enable/Disable highlighting of errors in source.
" Default is Enable
" To disable the highlighting put the line
" let g:JSLintHighlightErrorLine = 0
" in your .vimrc
"
if exists("b:did_jslint_plugin")
  finish
else
  let b:did_jslint_plugin = 1
endif

let s:install_dir = expand('<sfile>:p:h')

au BufLeave <buffer> call s:JSLintClear()

au BufEnter <buffer> call s:JSLint()
au InsertLeave <buffer> call s:JSLint()
"au InsertEnter <buffer> call s:JSLint()
au BufWritePost <buffer> call s:JSLint()

" due to http://tech.groups.yahoo.com/group/vimdev/message/52115
if(!has("win32") || v:version>702)
  au CursorHold <buffer> call s:JSLint()
  au CursorHoldI <buffer> call s:JSLint()

  au CursorHold <buffer> call s:GetJSLintMessage()
endif

au CursorMoved <buffer> call s:GetJSLintMessage()

if !exists("g:JSLintHighlightErrorLine")
  let g:JSLintHighlightErrorLine = 1
endif

if !exists("*s:JSLintUpdate")
  function s:JSLintUpdate()
    silent call s:JSLint()
    call s:GetJSLintMessage()
  endfunction
endif

if !exists(":JSLintUpdate")
  command JSLintUpdate :call s:JSLintUpdate()
endif
if !exists(":JSLintToggle")
  command JSLintToggle :let b:jslint_disabled = exists('b:jslint_disabled') ? b:jslint_disabled ? 0 : 1 : 1
endif

noremap <buffer><silent> dd dd:JSLintUpdate<CR>
noremap <buffer><silent> dw dw:JSLintUpdate<CR>
noremap <buffer><silent> u u:JSLintUpdate<CR>
noremap <buffer><silent> <C-R> <C-R>:JSLintUpdate<CR>

" Set up command and parameters
if has("win32")
  let s:cmd = 'cscript /NoLogo '
  let s:runjslint_ext = 'wsf'
else
  let s:runjslint_ext = 'js'
  if exists("$JS_CMD")
    let s:cmd = "$JS_CMD"
  elseif executable('/System/Library/Frameworks/JavaScriptCore.framework/Resources/jsc')
    let s:cmd = '/System/Library/Frameworks/JavaScriptCore.framework/Resources/jsc'
  elseif executable('node')
    let s:cmd = 'node'
  elseif executable('nodejs')
    let s:cmd = 'nodejs'
  elseif executable('js')
    let s:cmd = 'js'
  else
    echoerr('No JS interpreter found. Checked for jsc, js (spidermonkey), and node')
  endif
endif
let s:plugin_path = s:install_dir . "/jslint/"
if has('win32')
  let s:plugin_path = substitute(s:plugin_path, '/', '\', 'g')
endif
let s:cmd = 'cd "' . s:plugin_path . '" && ' . s:cmd . ' "' . s:plugin_path . 'runjslint.' . s:runjslint_ext . '"'

let s:jslintrc_file = expand('~/.jslintrc')
if filereadable(s:jslintrc_file)
  let s:jslintrc = readfile(s:jslintrc_file)
else
  let s:jslintrc = []
end


" WideMsg() prints [long] message up to (&columns-1) length
" guaranteed without "Press Enter" prompt.
if !exists("*s:WideMsg")
  function s:WideMsg(msg)
    let x=&ruler | let y=&showcmd
    set noruler noshowcmd
    redraw
    echo a:msg
    let &ruler=x | let &showcmd=y
  endfun
endif


function! s:JSLintClear()
  " Delete previous matches
  let s:matches = getmatches()
  for s:matchId in s:matches
    if s:matchId['group'] == 'JSLintError'
      call matchdelete(s:matchId['id'])
    endif
  endfor
  let b:matched = []
  let b:matchedlines = {}
  let b:cleared = 1
endfunction

function! s:JSLint()
  if exists("b:jslint_disabled") && b:jslint_disabled == 1
    return
  endif

  highlight link JSLintError SpellBad

  if exists("b:cleared")
    if b:cleared == 0
      call s:JSLintClear()
    endif
    let b:cleared = 1
  endif

  let b:matched = []
  let b:matchedlines = {}

  " Detect range
  if a:firstline == a:lastline
    " Skip a possible shebang line, e.g. for node.js script.
    if getline(1)[0:1] == "#!"
      let b:firstline = 2
    else
      let b:firstline = 1
    endif
    let b:lastline = '$'
  else
    let b:firstline = a:firstline
    let b:lastline = a:lastline
  endif

  let b:qf_list = []
  let b:qf_window_count = -1

  let lines = join(s:jslintrc + getline(b:firstline, b:lastline), "\n")
  if len(lines) == 0
    return
  endif
  let old_shell = &shell
  let &shell = '/bin/bash'
  let b:jslint_output = system(s:cmd, lines . "\n")
  let &shell = old_shell
  if v:shell_error
    echoerr b:jslint_output
    echoerr 'could not invoke JSLint!'
    let b:jslint_disabled = 1
  end

  for error in split(b:jslint_output, "\n")
    " Match {line}:{char}:{message}
    let b:parts = matchlist(error, '\v(\d+):(\d+):([A-Z]+):(.*)')
    if !empty(b:parts)
      let l:line = b:parts[1] + (b:firstline - 1 - len(s:jslintrc)) " Get line relative to selection
      let l:errorMessage = b:parts[4]

      if l:line < 1
        echoerr 'error in jslintrc, line ' . b:parts[1] . ', character ' . b:parts[2] . ': ' . l:errorMessage
      else
        " Store the error for an error under the cursor
        let s:matchDict = {}
        let s:matchDict['lineNum'] = l:line
        let s:matchDict['message'] = l:errorMessage
        let b:matchedlines[l:line] = s:matchDict
        if b:parts[3] == 'ERROR'
            let l:errorType = 'E'
        else
            let l:errorType = 'W'
        endif
        if g:JSLintHighlightErrorLine == 1
          let s:mID = matchadd('JSLintError', '\v%' . l:line . 'l\S.*(\S|$)')
        endif
        " Add line to match list
        call add(b:matched, s:matchDict)

        " Store the error for the quickfix window
        let l:qf_item = {}
        let l:qf_item.bufnr = bufnr('%')
        let l:qf_item.filename = expand('%')
        let l:qf_item.lnum = l:line
        let l:qf_item.text = l:errorMessage
        let l:qf_item.type = l:errorType

        " Add line to quickfix list
        call add(b:qf_list, l:qf_item)
      endif
    endif
  endfor

  if exists("s:jslint_qf")
    " if jslint quickfix window is already created, reuse it
    call s:ActivateJSLintQuickFixWindow()
    call setqflist(b:qf_list, 'r')
  else
    " one jslint quickfix window for all buffers
    call setqflist(b:qf_list, '')
    let s:jslint_qf = s:GetQuickFixStackCount()
  endif
  let b:cleared = 0
endfunction

let b:showing_message = 0

if !exists("*s:GetJSLintMessage")
  function s:GetJSLintMessage()
    let s:cursorPos = getpos(".")

    " Bail if RunJSLint hasn't been called yet
    if !exists('b:matchedlines')
      return
    endif

    if has_key(b:matchedlines, s:cursorPos[1])
      let s:jslintMatch = get(b:matchedlines, s:cursorPos[1])
      call s:WideMsg(s:jslintMatch['message'])
      let b:showing_message = 1
      return
    endif

    if b:showing_message == 1
      echo
      let b:showing_message = 0
    endif
  endfunction
endif

if !exists("*s:GetQuickFixStackCount")
    function s:GetQuickFixStackCount()
        let l:stack_count = 0
        try
            silent colder 9
        catch /E380:/
        endtry

        try
            for i in range(9)
                silent cnewer
                let l:stack_count = l:stack_count + 1
            endfor
        catch /E381:/
            return l:stack_count
        endtry
    endfunction
endif

if !exists("*s:ActivateJSLintQuickFixWindow")
    function s:ActivateJSLintQuickFixWindow()
        try
            silent colder 9 " go to the bottom of quickfix stack
        catch /E380:/
        endtry

        if s:jslint_qf > 0
            try
                exe "silent cnewer " . s:jslint_qf
            catch /E381:/
                echoerr "Could not activate JSLint Quickfix Window."
            endtry
        endif
    endfunction
endif

