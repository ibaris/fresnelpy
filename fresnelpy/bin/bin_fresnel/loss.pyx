# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division
import numpy as np
cimport numpy as np


cdef double[:, :, :] bin_loss_matrix(double[:, :, :] reflection, double[:] loss):
    cdef:
        Py_ssize_t xmax = loss.shape[0], i, j, k
        double[:, :, :] ref_loss = np.zeros_like(reflection)

    for i in range(xmax):
        for j in range(reflection.shape[1]):
            for k in range(reflection.shape[2]):
                ref_loss[i, j, k] = reflection[i, j, k] * loss[i]

    return ref_loss
