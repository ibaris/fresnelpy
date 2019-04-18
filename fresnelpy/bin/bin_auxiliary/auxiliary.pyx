# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np
from libc.math cimport cos
import cmath

cdef:
    double EPSILON = 2.220446049250313e-16 * 100

cdef bin_is_forward_angle_real(double complex[:] n, double[:] xza):
    """
    if a wave is traveling at angle theta from normal in a medium with index n,
    calculate whether or not this is the forward-traveling wave (i.e., the one
    going from front to back of the stack, like the incoming or outgoing waves,
    but unlike the reflected wave). For real n & theta, the criterion is simply
    -pi/2 < theta < pi/2, but for complex n & theta, it's more complicated.
    See https://arxiv.org/abs/1603.02720 appendix D. If theta is the forward
    angle, then (pi-theta) is the backward angle and vice-versa.
    """
    cdef:
        Py_ssize_t i, xmax = len(xza)
        double complex[:] ny = np.empty_like(n)
        char * error_string
        np.ndarray answer = np.zeros_like(xza, dtype=np.int)

    if n.shape[0] != xza.shape[0]:
        raise AssertionError("The dimensions of the entered parameters must "
                             "be the same: n = {0}, xza = {1}".format(str(n.shape[0]), str(xza.shape[0])))

    for i in range(xmax):
        if n[i].real * n[i].imag < 0:
            raise AssertionError("For materials with gain, it's ambiguous which beam is incoming vs outgoing. "
                                 "Please see: https://arxiv.org/abs/1603.02720 Appendix C. \n" 
                                 "n: {0}, xza: {1}".format(str(n[i]), str(xza[i])))

        ny[i] = n[i] * cos(xza[i])


        if abs(ny[i].imag) > EPSILON:
            # Either evanescent decay or lossy medium. Either way, the one that
            # decays is the forward-moving wave
            if (ny[i].imag > 0):
                answer[i] = 1
            else:
                answer[i] = 0

        else:
            if (ny[i].real > 0):
                answer[i] = 1
            else:
                answer[i] = 0

        if answer[i] == 1:
            if (ny[i].imag < -EPSILON or ny[i].real < -EPSILON
                or n[i].real * cos(xza[i]) < -EPSILON):

                answer[i] = -1

        else:
            if (ny[i].imag > -EPSILON or ny[i].real > -EPSILON
                or n[i].real * cos(xza[i]) > -EPSILON):

                answer[i] = -1

    return answer


cdef bin_is_forward_angle_cpx(double complex[:] n, double complex[:] xza):
    """
    if a wave is traveling at angle theta from normal in a medium with index n,
    calculate whether or not this is the forward-traveling wave (i.e., the one
    going from front to back of the stack, like the incoming or outgoing waves,
    but unlike the reflected wave). For real n & theta, the criterion is simply
    -pi/2 < theta < pi/2, but for complex n & theta, it's more complicated.
    See https://arxiv.org/abs/1603.02720 appendix D. If theta is the forward
    angle, then (pi-theta) is the backward angle and vice-versa.
    """
    cdef:
        Py_ssize_t i, xmax = len(xza)
        double complex[:] ny = np.empty_like(n)
        char * error_string
        np.ndarray answer = np.zeros_like(xza, dtype=np.int)


    if n.shape[0] != xza.shape[0]:
        raise AssertionError("The dimensions of the entered parameters must "
                             "be the same: n = {0}, xza = {1}".format(str(n.shape[0]), str(xza.shape[0])))

    for i in range(xmax):
        if n[i].real * n[i].imag < 0:
            raise AssertionError("For materials with gain, it's ambiguous which beam is incoming vs outgoing. "
                                 "Please see: https://arxiv.org/abs/1603.02720 Appendix C. \n" 
                                 "n: {0}, xza: {1}".format(str(n[i]), str(xza[i])))

        ny[i] = n[i] * cmath.cos(xza[i])


        if abs(ny[i].imag) > EPSILON:
            # Either evanescent decay or lossy medium. Either way, the one that
            # decays is the forward-moving wave
            if (ny[i].imag > 0):
                answer[i] = 1
            else:
                answer[i] = 0

        else:
            if (ny[i].real > 0):
                answer[i] = 1
            else:
                answer[i] = 0

        if answer[i] == 1:
            if (ny[i].imag < -EPSILON or ny[i].real < -EPSILON
                or np.real(n[i] * cmath.cos(xza[i])) < -EPSILON):

                answer[i] = -1

        else:
            if (ny[i].imag > -EPSILON or ny[i].real > -EPSILON
                or np.real(n[i] * cmath.cos(xza[i])) > -EPSILON):

                answer[i] = -1

    return answer
