# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np
from libc.math cimport sin
import cmath
from fresnelpy.bin.bin_auxiliary import is_foreword_angle

cdef:
    double PI = 3.14159265359


cdef snell_real(double[:] xza, double complex[:] n1, double complex[:] n2):
    """
    return angle theta in layer 2 with refractive index n_2, assuming
    it has angle th_1 in layer with refractive index n_1. Use Snell's law. Note
    that "angles" may be complex!!
    """
    cdef:
        Py_ssize_t i, xmax = xza.shape[0]
        double complex[:] gza = np.empty_like(n1, dtype=np.complex), temp = np.empty_like(n1, dtype=np.complex)

    if n1.shape[0] != xmax or n2.shape[0] != xmax:
        raise AssertionError("The dimensions of the entered parameters must "
                             "be the same: xza = {0}, n1 = {1}, n2 = {2}".format(str(xza.shape[0]),
                                                                                 str(n1.shape[0]),
                                                                                 str(n2.shape[0])))

    for i in range(xmax):
        temp[i] = cmath.asin(n1[i] * sin(xza[i]) / n2[i])

    check = is_foreword_angle(n2.base, temp.base)

    for i in range(xmax):
        if check[i] == 0:
            gza[i] = PI - temp[i]
        else:
            gza[i] = temp[i]

    return gza


cdef snell_cpx(double complex[:] xza, double complex[:] n1, double complex[:] n2):
    """
    return angle theta in layer 2 with refractive index n_2, assuming
    it has angle th_1 in layer with refractive index n_1. Use Snell's law. Note
    that "angles" may be complex!!
    """
    cdef:
        Py_ssize_t i, xmax = xza.shape[0]
        double complex[:] gza = np.empty_like(xza), temp = np.empty_like(n1, dtype=np.complex)

    if n1.shape[0] != xmax or n2.shape[0] != xmax:
        raise AssertionError("The dimensions of the entered parameters must "
                             "be the same: xza = {0}, n1 = {1}, n2 = {2}".format(str(xza.shape[0]),
                                                                                 str(n1.shape[0]),
                                                                                 str(n2.shape[0])))

    for i in range(xmax):
        temp[i] = cmath.asin(n1[i] * cmath.sin(xza[i]) / n2[i])

    check = is_foreword_angle(n2.base, temp.base)

    for i in range(xmax):
        if check[i] == 0:
            gza[i] = PI - temp[i]
        else:
            gza[i] = temp[i]

    return gza