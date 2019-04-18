# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
__all__ = ['FresnelResult']


class FresnelResult(dict):
    """ Represents the reflectance result.

    Returns
    -------
    All returns are attributes!
    coef.alpha, coef.beta1, coef.beta2 : array_like
        Alpha and Beta coefficients with individual polarisation access (.VV or .HH).
    BSC.VV, BSC.HH, BSC.VVdB, BSC.HHdB, BSC.ms.VV, BSC.ms.HH, BSC.ms.VVdB, BSC.ms.HHdB : array_like
        Radar Backscatter values.
    I.VV, I.HH, I.VVdB, I.HHdB : array_like
        Intensity values.

    Notes
    -----
    There may be additional attributes not listed above depending of the
    specific solver. Since this class is essentially a subclass of dict
    with attribute accessors, one can see which attributes are available
    using the `keys()` method. adar Backscatter values of multi scattering contribution of surface and volume

    The attribute 'ms' is the multi scattering contribution. This is only available if it is calculated. For detailed
    parametrisation one can use BSC.ms.sms or BSC.ms.smv for the multiple scattering contribution of surface or volume,
    respectively.
    """

    def __getattr__(self, name):
        try:
            return self[name]
        except KeyError:
            raise AttributeError(name)

    __setattr__ = dict.__setitem__
    __delattr__ = dict.__delitem__

    def __repr__(self):
        if self.keys():
            m = max(map(len, list(self.keys()))) + 1
            return '\n'.join([k.rjust(m) + ': ' + repr(v)
                              for k, v in sorted(self.items())])
        else:
            return self.__class__.__name__ + "()"

    def __dir__(self):
        return list(self.keys())
