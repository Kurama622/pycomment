def demo(arg1:int, arg2:float) -> (int, str):
    var1 = arg1
    var2 = str(arg2)

def demo1(arg1:int, arg2) -> (int, str):
    var1 = arg1
    var2 = str(arg2)

def demo2(arg1, arg2:int=1) -> (int, str):
    var1 = arg1
    var2 = str(arg2)


def testdef(a:int, b:list):
    pass

def testdef1(a:int, b:float)->int:
    return a

def testdef2(a:int, b:float):
    return a

class test():
    pass
