def demo(arg1:int, arg2:float) -> (int, str):
    """demo. 

    Parameters
    ----------

    arg1 : int. <++>

    arg2 : float. <++>

    """
    var1 = arg1
    var2 = str(arg2)

def demo1(arg1:int, arg2) -> (int, str):
    """demo1. 

    Parameters
    ----------

    arg1 : int. <++>

    arg2. <++>

    """
    var1 = arg1
    var2 = str(arg2)

def demo2(arg1, arg2:int=1) -> (int, str):
    """demo2. 

    Parameters
    ----------

    arg1. <++>

    arg2 : int. <++>

    """
    var1 = arg1
    var2 = str(arg2)


def testdef(a:int, b:list):
    """testdef. 

    Parameters
    ----------

    a : int. <++>

    b : list. <++>

    """
    pass

def testdef1(a:int, b:float)->int:
    """testdef1. 

    Parameters
    ----------

    a : int. <++>

    b : float. <++>

    Returns
    -------

    a : int. <++>

    """
    return a

def testdef2(a:int, b:float):
    """testdef2. 

    Parameters
    ----------

    a : int. <++>

    b : float. <++>

    Returns
    -------

    a. <++>

    """
    return a

class test():
    """test. 

    """
    pass

class democlass():
    """democlass. 

    """
    def t1(self, a,b):
        """t1. 

        Parameters
        ----------

        self. <++>

        a. <++>

        b. <++>

        Returns
        -------

        a. <++>

        """
        a=1
        return a
