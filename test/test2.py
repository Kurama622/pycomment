def testdef1(a):
    """testdef1. 

    Parameters
    ----------

    a. <++>

    Returns
    -------

    a. <++>

    """
    return a


class testClass:
    """testClass. 

    """
    def testfunc1(self, a:int, b:float) -> int:
        """testfunc1. 

        Parameters
        ----------

        self. <++>

        a : int. <++>

        b : float. <++>

        Returns
        -------

        a : int. <++>

        """
        a = 100
        b = float(a)
        return a
    def testfunc2(self, a:int=100, b:float=1.0):
        """testfunc2. 

        Parameters
        ----------

        self. <++>

        a : int. <++>

        b : float. <++>

        """
        print("")

