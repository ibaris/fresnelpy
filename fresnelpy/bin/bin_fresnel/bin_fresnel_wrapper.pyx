# -*- coding: utf-8 -*-
# cython: cdivision=True
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division
from fresnelpy.bin.bin_fresnel.reflection cimport bin_reflection_matrix, bin_reflection_matrix_extended, bin_reflection

def reflection(double[:] xza, double complex[:] eps):
    return bin_reflection(xza, eps)

def reflection_matrix(double[:] xza, double complex[:] eps):
    return bin_reflection_matrix(xza, eps)

def reflection_matrix_extended(double[:] xza, double complex[:] eps):
    return bin_reflection_matrix_extended(xza, eps)
