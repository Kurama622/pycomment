let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/parse.py'


function! ParseDef()
    " get cursor line content
    let curLineText = getline('.')
    " get cursor line number
    let startCurPos = line('.')
    execute('/return')
    let returnLineText = getline('.')
    " parse function
    execute('py3f ' . expand(s:path))
    if funcType == 'def'
        execute("normal" . eval(startCurPos) . "GA\r\"\"\"\r\<BS>" . expand(funcName) . ".\r")

        " write parameters
        execute("normal AParameters\r----------\r")
        let n = len(parameterName)
        for i in range(n)
            execute("normal A" . expand(parameterName[i]) .  ":" . expand(parameterType[i]) ."\r")
        endfor

        " write returns
        execute("normal A\rReturns\r-------\r")
        let n = len(returnVar)
        for i in range(n)
            execute("normal A" . expand(returnVar[i]) .  ":" . expand(returnType[i]) ."\r")
        endfor

        let endCurPos = line('.')
        if getline(endCurPos+1) == "\"\"\""
            execute("normal dd" . eval(startCurPos) . "G")
        else
            execute("normal" . eval(endCurPos) . "GA\"\"\"")
            execute("normal" . eval(startCurPos) . "G")
        endif

    elseif funcType == 'class'
        execute("normal" . eval(startCurPos) . "GA\r\"\"\"\r\<BS>" . expand(funcName) . ".\r")
        let endCurPos = line('.')
        if getline(endCurPos+1) == "\"\"\""
            execute("normal dd" . eval(startCurPos) . "G")
        else
            execute("normal" . eval(endCurPos) . "GA\"\"\"")
            execute("normal" . eval(startCurPos) . "G")
        endif
    endif
endfunction
"call ParseDef()
finish


def test ( a:int, b:int = 2) -> (int,int):
   return a,b

class test():
    pass
