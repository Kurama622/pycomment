let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/parse.py'

nnoremap <silent> <buffer> <Plug>(pycomment_mark) :call MarkMapping()<CR>
nnoremap <silent> <buffer> <Plug>(pycomment) :call Parse()<CR>
if get(g:, 'pycomment_mark_mapping', 1)
    nmap <silent> <buffer> <leader><leader> <Plug>(pycomment_mark)
endif

if get(g:, 'pycomment_enable', 1)
    nmap <silent> <buffer> <M-c> <Plug>(pycomment)
endif

function! MarkMapping()
    execute("normal \<ESC>/<++>\<CR>:nohl\<CR>c4l")
endfunction

function! Parse()
    " get cursor line content
    let curLineText = getline('.')
    " get cursor line number
    let startCurPos = line('.')
    let returnStatus = execute('/return')
    if returnStatus == ''
        let returnLineText = getline('.')
    endif
    " parse function
    execute('py3f ' . expand(s:path))

    if funcType == 'def'
        execute("normal" . eval(startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(funcName) . ". \n\n")

        " write parameters
        execute("normal AParameters\<ESC>>>o----------\n")
        let n = len(parameterName)
        for i in range(n)
            execute("normal A" . expand(parameterName[i]) .  " : " . expand(parameterType[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
        endfor

        if returnStatus == ''
            " write returns
            execute("normal A\nReturns\<ESC>>>o-------\n")
            let n = len(returnVar)
            for i in range(n)
                execute("normal A" . expand(returnVar[i]) .  " : " . expand(returnType[i]) . ". <++>\<ESC>>>o \<ESC>>>o")
            endfor
        endif

        let endCurPos = line('.')
        let marks = getline(endCurPos+1)
        let n_marks = len(marks)
        if marks[n_marks-1] == "\""
            execute("normal dd" . eval(startCurPos+1) . "G$")
        else
            execute("normal" . eval(endCurPos) . "GA\"\"\"\<ESC>>>")
            execute("normal" . eval(startCurPos+1) . "G$")
        endif
    elseif funcType == 'class'
        execute("normal" . eval(startCurPos) . "GA\n\"\"\"\r\<BS>\<BS>" . expand(funcName) . ". \n\n")
        let endCurPos = line('.')
        let marks = getline(endCurPos+1)
        let n_marks = len(marks)
        if marks[n_marks-1] == "\""
            execute("normal dd" . eval(startCurPos+1) . "G$")
        else
            execute("normal" . eval(endCurPos) . "GA\"\"\"\<ESC>>>")
            execute("normal" . eval(startCurPos+1) . "G$")
        endif
    endif
endfunction
