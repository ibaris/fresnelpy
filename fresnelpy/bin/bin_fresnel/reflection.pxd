# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 18.04.19 by ibaris
"""
cdef tuple bin_reflection(double[:] xza, double complex[:] eps)
cdef double[:, :, :] bin_reflection_matrix(double[:] xza, double complex[:] eps)
cdef double[:, :, :] bin_reflection_matrix_extended(double[:] xza, double complex[:] eps)
