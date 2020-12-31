" get cursor line content
let s:curLineText = getline('.')
" get cursor line number
let s:startCurPos = line('.')
execute('/return')
let s:returnLineText = getline('.')

" parse function
execute('py3f parse.py')


function! ParseDef()
    if s:funcType == 'def'
        execute("normal" . eval(s:startCurPos) . "GA\r\"\"\"\r\<BS>" . expand(s:funcName) . ".\r")

        " write parameters
        execute("normal AParameters\r----------\r")
        let n = len(s:parameterName)
        for i in range(n)
            execute("normal A" . expand(s:parameterName[i]) .  ":" . expand(s:parameterType[i]) ."\r")
        endfor

        " write returns
        execute("normal A\rReturns\r-------\r")
        let n = len(s:returnVar)
        for i in range(n)
            execute("normal A" . expand(s:returnVar[i]) .  ":" . expand(s:returnType[i]) ."\r")
        endfor

        let s:endCurPos = line('.')
        if getline(s:endCurPos+1) == "\"\"\""
            execute("normal dd" . eval(s:startCurPos) . "G")
        else
            execute("normal" . eval(s:endCurPos) . "GA\"\"\"")
            execute("normal" . eval(s:startCurPos) . "G")
        endif

    elseif s:funcType == 'class'
        execute("normal" . eval(s:startCurPos) . "GA\r\"\"\"\r\<BS>" . expand(s:funcName) . ".\r")
        let s:endCurPos = line('.')
        if getline(s:endCurPos+1) == "\"\"\""
            execute("normal dd" . eval(s:startCurPos) . "G")
        else
            execute("normal" . eval(s:endCurPos) . "GA\"\"\"")
            execute("normal" . eval(s:startCurPos) . "G")
        endif
    endif
endfunction
finish


def test ( a:int, b:int = 2) -> (int,int):
   return a,b

class test():
    pass
