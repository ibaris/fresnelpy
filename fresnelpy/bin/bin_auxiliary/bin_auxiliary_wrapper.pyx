# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np
from fresnelpy.bin.bin_auxiliary.auxiliary cimport bin_is_forward_angle_real, bin_is_forward_angle_cpx


def is_foreword_angle(double complex[:] n, xza):
    """
    Check if a angle with a refractive index n is a foreword angle.

    Parameters
    ----------
    n : double complex [:]
        Complex refractive index.
    xza : double[:] or double complex[:]
        Incidence or scattering zenith angle.

    Returns
    -------
    out : bool

    """
    if xza.dtype == np.complex:
        return bin_is_forward_angle_cpx(n, xza)
    elif xza.dtype == np.double:
        return bin_is_forward_angle_real(n, xza)
    else:
        raise TypeError("Parameter `xza` must be a `double[:]` or `double complex[:]` data type.")
