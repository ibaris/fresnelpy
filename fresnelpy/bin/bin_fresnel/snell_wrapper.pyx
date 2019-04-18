# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np
from fresnelpy.bin.bin_fresnel.snell cimport snell_real, snell_cpx


def snell(xza, double complex[:] n1, double complex[:] n2):
    """
    Check if a angle with a refractive index n is a foreword angle.

    Parameters
    ----------
    xza : double[:] or double complex[:]
        Incidence or scattering zenith angle.
    n1 : double complex [:]
        Complex refractive index of medium 1.
    n2 : double complex [:]
        Complex refractive index of medium 2.

    Returns
    -------
    out : numpy.ndarray
        Angle theta in layer 2 with refractive index n2.

    """
    if xza.dtype == np.complex:
        return snell_cpx(xza, n1, n2)
    elif xza.dtype == np.double:
        return snell_real(xza, n1, n2)
    else:
        raise TypeError("Parameter `xza` must be a `double[:]` or `double complex[:]` data type.")
