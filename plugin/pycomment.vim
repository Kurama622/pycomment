let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/parse.py'

nnoremap <silent> <buffer> <Plug>(pycomment_mark) :call MarkMapping()<CR>
nnoremap <silent> <buffer> <Plug>(pycomment) :call Parse()<CR>
if get(g:, 'pycomment_mark_mapping', 1)
    nmap <silent> <buffer> <M-c> <Plug>(pycomment)
    nmap <silent> <buffer> <leader><leader> <Plug>(pycomment_mark)
endif


function! MarkMapping()
    execute("normal \<ESC>/<++>\<CR>:nohl\<CR>c4l")
endfunction

function! Parse()
    " get cursor line content
    let s:curLineText = getline('.')
    " get cursor line number
    let s:startCurPos = line('.')
    let s:is_head = system("sed -n '" . expand(s:startCurPos) . "," . expand(s:startCurPos) . "p' " . expand('%') . " | grep -E \\[\\ \\t\\]\\*\\(def\\|class\\)\\ ")
    echo is_head
    if s:is_head == ''
        execute('?^ *def\|^ *class\|^\t*def\|^\t*class')
        " get cursor line content
        let s:curLineText = getline('.')
        " get cursor line number
        let s:startCurPos = line('.')
    endif

    try
        let returnStatus = execute('/return')
        let returnLineText = getline('.')
        execute('?^ *def\|^ *class\|^\t*def\|^\t*class')
        let funcHeadPos = line('.')

        execute('py3f ' . expand(s:path))
        if funcType == 'def'
            if funcHeadPos == s:startCurPos
                call WriteDefParameters(s:startCurPos, funcName)
                call WriteDefReturns()
                call IsEnd(s:startCurPos)
            else
                call WriteDefParameters(s:startCurPos, funcName)
                call IsEnd(s:startCurPos)
            endif
        elseif funcType == 'class'
            call WriteClassParameters(s:startCurPos, funcName)
            call IsEnd(s:startCurPos)
        endif
    catch /return$/
        let returnStatus = 'False'
        " parse function
        execute('py3f ' . expand(s:path))
        if funcType == 'def'
            call WriteDefParameters(s:startCurPos, funcName)
            call IsEnd(s:startCurPos)
        elseif funcType == 'class'
            call WriteClassParameters(s:startCurPos, funcName)
            call IsEnd(s:startCurPos)
        endif
    endtry
endfunction

function! WriteDefParameters(startCurPos, funcName)
    execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(a:funcName) . ". \n\n")

    " write parameters
    execute("normal AParameters\<ESC>>>o----------\n")
    let n = len(b:parameterName)
    for i in range(n)
        if expand(b:parameterType[i]) == ''
            execute("normal A" . expand(b:parameterName[i]) .  ". <++>\<ESC>>>o \<ESC>>>o")
        else
            execute("normal A" . expand(b:parameterName[i]) .  " : " . expand(b:parameterType[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
        endif
    endfor
endfunction

function! WriteClassParameters(startCurPos, funcName)
    execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(a:funcName) . ". \n\n")
endfunction

function! WriteDefReturns()
    " write returns
    execute("normal A\nReturns\<ESC>>>o-------\n")
    let n = len(b:returnVar)
    for i in range(n)
        if expand(b:returnType[i]) == ''
            execute("normal A" . expand(b:returnVar[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
        else
            execute("normal A" . expand(b:returnVar[i]) .  " : " . expand(b:returnType[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
        endif
    endfor
endfunction

function! IsEnd(startCurPos)
    let endCurPos = line('.')
    let marks = getline(endCurPos+1)
    let n_marks = len(marks)
    if marks[n_marks-1] == "\""
        execute("normal dd" . eval(a:startCurPos+1) . "G$")
    else
        execute("normal" . eval(endCurPos) . "GA\"\"\"\<ESC>>>")
        execute("normal" . eval(a:startCurPos+1) . "G$")
    endif
endfunction
call Parse()
