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
    let curLineText = getline('.')
    " get cursor line number
    let startCurPos = line('.')
    let is_head = system("sed -n '" . expand(startCurPos) . "," . expand(startCurPos) . "p' " . expand('%') . " | grep -E \\[\\ \\t\\]\\*\\(def\\|class\\)\\ ")
    if is_head == ''
        execute('?^ *def\|^ *class\|^\t*def\|^\t*class')
        " get cursor line content
        let curLineText = getline('.')
        " get cursor line number
        let startCurPos = line('.')
    endif

    try
        let returnStatus = execute('/return')
        let returnLineText = getline('.')
        execute('?^ *def\|^ *class\|^\t*def\|^\t*class')
        let funcHeadPos = line('.')

        execute('py3f ' . expand(s:path))
        if funcType == 'def'
            if funcHeadPos == startCurPos
                call WriteDefParameters(startCurPos, funcName)
                call WriteDefReturns()
                call IsEnd(startCurPos)
            else
                call WriteDefParameters(startCurPos, funcName)
                call IsEnd(startCurPos)
            endif
        elseif funcType == 'class'
            call WriteClassParameters(startCurPos, funcName)
            call IsEnd(startCurPos)
        endif
    catch /return$/
        let returnStatus = 'False'
        " parse function
        execute('py3f ' . expand(s:path))
        if funcType == 'def'
            call WriteDefParameters(startCurPos, funcName)
            call IsEnd(startCurPos)
        elseif funcType == 'class'
            call WriteClassParameters(startCurPos, funcName)
            call IsEnd(startCurPos)
        endif
    endtry
    execute(':w')
endfunction

function! WriteDefParameters(startCurPos, funcName)
    "execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(a:funcName) . ". \n\n")
    execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r")
    execute("normal kA" . expand(a:funcName) . '. ')

    " write parameters
    "execute("normal AParameters\<ESC>>>o----------\n")
    execute("normal A\n\nParameters\n----------")
    let n = len(b:parameterName)
    for i in range(n)
        if expand(b:parameterType[i]) == ''
            execute("normal A\n\n" . expand(b:parameterName[i]) .  ". <++>")
        else
            execute("normal A\n\n" . expand(b:parameterName[i]) .  " : " . expand(b:parameterType[i]) . ". <++>")
        endif
    endfor
endfunction

function! WriteClassParameters(startCurPos, funcName)
    "execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(a:funcName) . ". \n\n")
    execute("normal" . eval(a:startCurPos) . "GA\n\"\"\"\r")
    execute("normal kA" . expand(a:funcName) . '. ')
endfunction

function! WriteDefReturns()
    " write returns
    "execute("normal A\nReturns\<ESC>>>o-------\n")
    execute("normal A\n\nReturns\n-------")
    let n = len(b:returnVar)
    for i in range(n)
        if expand(b:returnType[i]) == ''
            ""execute("normal A" . expand(b:returnVar[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
            execute("normal A\n\n" . expand(b:returnVar[i]) . ". <++>")
        else
            "execute("normal A" . expand(b:returnVar[i]) .  " : " . expand(b:returnType[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
            execute("normal A\n\n" . expand(b:returnVar[i]) .  " : " . expand(b:returnType[i]) . ". <++>")
        endif
    endfor
endfunction

function! IsEnd(startCurPos)
    let endCurPos = line('.')
    let marks = getline(endCurPos+2)
    let n_marks = len(marks)
    if marks[n_marks-1] == "\""
        execute("normal " . eval(a:startCurPos+1) . "G$")
    else
        execute("normal " . eval(endCurPos) . "GA\n\n\"\"\"")
        execute("normal jdd")
        execute("normal " . eval(a:startCurPos+1) . "G$")
    endif
endfunction
"call Parse()
