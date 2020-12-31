import vim
import os


curLineText = vim.eval("curLineText")
returnLineText = vim.eval("returnLineText")
# curLineText = 'def test(a:int, b:int = 1) -> int:'
# returnLineText = 'return a, b'
# curpos = vim.eval("s:curpos")


def FuncHead(head):
    headList = head.split()
    funcType = headList[0]
    headstring = "".join(headList[1:])
    if '->' in headstring:
        (inputString, outString) = headstring.split('->')
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
        inputString = headstring
        separatorPos = inputString.index('(')
        funcName = inputString[:separatorPos]
        parameterString = inputString[separatorPos+1:-2]
        returnTypeString = None
        existReturn = 0
    return funcType, funcName, parameterString, returnTypeString, existReturn

def ParseParameters(parameterString):
    parameterList = parameterString.split(',')
    n_parameter = len(parameterList)
    parameterName = []
    parameterType = []
    for i in range(n_parameter):
        (name_, type_) = parameterList[i].split(':')
        parameterName.append(name_)
        if '=' in type_:
            separatorPos = type_.index('=')
            type_ = type_[:separatorPos]
        parameterType.append(type_)
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
    returnVarList = tail.split()[1:]
    # print(returnVarList)
    varNumber = len(returnVarList)
    returnString = ''.join(returnVarList)
    # returnString = ''
    # for i in range(varNumber):
        # returnString += returnVarList[i]
    # print(returnString)
    returnVarList = returnString.split(',')
    N = len(returnVarList)
    return returnVarList, N



funcType, funcName, parameterString, returnTypeString, existReturn = FuncHead(curLineText)
vim.command("let funcType = '%s'" %funcType)
vim.command("let funcName = '%s'" %funcName)

if funcType == 'def':
    parameterName, parameterType = ParseParameters(parameterString)
    returnType = ParseReturnType(returnTypeString, existReturn)
    returnVar, returnVarNum = FuncReturn(returnLineText)
    vim.command("let returnVar = {}".format(returnVar))
    vim.command("let returnVarNum = '%s'"%returnVarNum)
    vim.command("let parameterName = {}".format(parameterName))
    vim.command("let parameterType = {}".format(parameterType))
    vim.command("let returnType = {}" .format(returnType))
elif funcType == 'class':
    pass




# for i in range(returnVarNum):
    # vim.command("let returnVar"+str(i)+" = '%s'"%returnVar[i])




