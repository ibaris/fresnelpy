# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np
from libc.math cimport sin, cos
import cmath


cdef tuple bin_reflection(double[:] xza, double complex[:] eps):
    cdef:
        Py_ssize_t xmax = xza.shape[0], i
        double complex[:] Rvi = np.empty_like(eps), Rhi = np.empty_like(eps)
        double complex rt

    for i in range(xmax):
        rt = cmath.sqrt(eps[i] - pow(sin(xza[i]), 2))

        Rvi[i] = (eps[i] * cos(xza[i]) - rt) / (eps[i] * cos(xza[i]) + rt)
        Rhi[i] = (np.cos(xza[i]) - rt) / (cos(xza[i]) + rt)

    return Rvi, Rhi


cdef double[:, :, :] bin_reflection_matrix(double[:] xza, double complex[:] eps):
    cdef:
        Py_ssize_t xmax = xza.shape[0], i
        double complex[:] Rvi, Rhi
        double[:, :, :] matrix = np.zeros((xmax, 4, 4))

    Rvi, Rhi = bin_reflection(xza, eps)

    for i in range(xmax):
        matrix[i, 0, 0] = pow(abs(Rvi[i]), 2)

        matrix[i, 1, 1] = pow(abs(Rhi[i]), 2)

        matrix[i, 2, 2] = np.real(Rvi[i] * np.conjugate(Rhi[i]))
        matrix[i, 2, 3] = -np.imag(Rvi[i] * np.conjugate(Rhi[i]))

        matrix[i, 3, 2] = np.imag(Rvi[i] * np.conjugate(Rhi[i]))
        matrix[i, 3, 3] = np.real(Rvi[i] * np.conjugate(Rhi[i]))

    return matrix


cdef double[:, :, :] bin_reflection_matrix_extended(double[:] xza, double complex[:] eps):
    cdef:
        Py_ssize_t xmax = xza.shape[0], i
        double complex[:] Rvi, Rhi
        double[:, :, :] matrix = np.zeros((xmax, 5, 5))

    Rvi, Rhi = bin_reflection(xza, eps)

    for i in range(xmax):
        matrix[i, 0, 0] = 0.5 * (pow(abs(Rvi[i]), 2) + pow(abs(Rhi[i]), 2))
        matrix[i, 0, 1] = 0.5 * pow(abs(Rvi[i]), 2)
        matrix[i, 0, 2] = -0.5 * pow(abs(Rhi[i]), 2)

        matrix[i, 1, 1] = pow(abs(Rvi[i]), 2)

        matrix[i, 2, 2] = pow(abs(Rhi[i]), 2)

        matrix[i, 3, 3] = np.real(Rvi[i] * np.conjugate(Rhi[i]))
        matrix[i, 3, 4] = -np.imag(Rvi[i] * np.conjugate(Rhi[i]))

        matrix[i, 4, 3] = np.imag(Rvi[i] * np.conjugate(Rhi[i]))
        matrix[i, 4, 4] = np.real(Rvi[i] * np.conjugate(Rhi[i]))

    return matrix
