# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 17.04.19 by ibaris
"""
cdef snell_real(double[:] xza, double complex[:] n1, double complex[:] n2)
cdef snell_cpx(double complex[:] xza, double complex[:] n1, double complex[:] n2)
