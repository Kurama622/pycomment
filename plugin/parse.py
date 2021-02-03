import vim
import os

b = vim.current.buffer
curLineText = vim.eval("curLineText")
returnStatus = vim.eval("returnStatus")
if returnStatus == '':
    returnLineText = vim.eval("returnLineText")


def FuncHead(head):
    headList = head.split()
    funcType = headList[0]
    headstring = "".join(headList[1:])
    if '->' in headstring:
        (inputString, outString) = headstring.split('->')
        if '(' in inputString:
            separatorPos = inputString.index('(')
            funcName = inputString[:separatorPos]
            parameterString = inputString[separatorPos+1:-1]
            if outString[0] == '(':
                returnTypeString = outString[1:-2]
                existReturn = 2
            else:
                returnTypeString = outString[0:-1]
                existReturn = 1
        else:
            separatorPos = inputString.index(':')
            funcName = inputString[:separatorPos]       # class
            parameterString, returnTypeString, existReturn = 0, 0, 0
    else:
        inputString = headstring
        if '(' in inputString:
            separatorPos = inputString.index('(')
            funcName = inputString[:separatorPos]
            parameterString = inputString[separatorPos+1:-2]
            returnTypeString = None
            existReturn = 0
        else:
            separatorPos = inputString.index(':')
            funcName = inputString[:separatorPos]       # class
            parameterString, returnTypeString, existReturn = 0, 0, 0
    return funcType, funcName, parameterString, returnTypeString, existReturn

def ParseParameters(parameterString):
    parameterList = parameterString.split(',')
    n_parameter = len(parameterList)
    parameterName = []
    parameterType = []
    for i in range(n_parameter):
        if ':' in parameterList[i]:
            (name_, type_) = parameterList[i].split(':')
            parameterName.append(name_)
            if '=' in type_:
                separatorPos = type_.index('=')
                type_ = type_[:separatorPos]
            parameterType.append(type_)
        else:
            if '=' in parameterList[i]:
                namePos = parameterList[i].index('=')
                parameterName.append(parameterList[i][:namePos])
                parameterType.append('')
            else:
                parameterName.append(parameterList[i])
                parameterType.append('')
    return parameterName, parameterType

def ParseReturnType(returnTypeString, existReturn):
    if existReturn == 0:
        returnType = ''
    elif existReturn == 1:
        returnType = [returnTypeString]
    else:
        returnType = returnTypeString.split(',')
    return returnType


def FuncReturn(tail):
"""FuncReturn. 

Parameters
----------

tail. <++>

Returns
-------

=tail.split()[1:]. <++>

"""
    returnVarList = tail.split()[1:]
    returnString = ''.join(returnVarList)
    returnVarList = returnString.split(',')
    N = len(returnVarList)
    return returnVarList, N

funcType, funcName, parameterString, returnTypeString, existReturn = FuncHead(curLineText)

if funcType == 'def':
    vim.command("let funcType = '%s'" %funcType)
    vim.command("let funcName = '%s'" %funcName)
    parameterName, parameterType = ParseParameters(parameterString)
    returnType = ParseReturnType(returnTypeString, existReturn)
    b.vars["returnType"] = returnType
    b.vars["parameterName"] = parameterName
    b.vars["parameterType"] = parameterType
    if returnStatus == '':
        returnVar, returnVarNum = FuncReturn(returnLineText)
        b.vars["returnVar"] = returnVar
        vim.command("let returnVarNum = '%s'"%returnVarNum)
elif funcType == 'class':
    vim.command("let funcType = '%s'" %funcType)
    vim.command("let funcName = '%s'" %funcName)
