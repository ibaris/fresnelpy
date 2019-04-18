# -*- coding: utf-8 -*-
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division

import os
from distutils import dir_util

import numpy as np
import pytest
from fresnelpy.bin.bin_auxiliary import is_foreword_angle
from fresnelpy.test.datadir_wrapper import datadir


class TestValues:
    def test1(self, datadir):
        nr = np.loadtxt(datadir("n1r.out"), unpack=True)
        ni = np.loadtxt(datadir("n1i.out"), unpack=True)
        n = nr + ni * 1j
        xza = np.loadtxt(datadir("xza.out"), unpack=True)
        reference = np.loadtxt(datadir("forward_true.out"), unpack=True)

        value = is_foreword_angle(n, xza)

        for i in range(value.shape[0]):
            assert np.allclose(value[i], reference[i])


n = np.random.uniform(0, 5, 10) + np.random.uniform(0, 5, 10) * 1j
xza = np.random.uniform(0, 3.14, 10)
xza_cpx = np.random.uniform(0, 3.14, 10) + xza * 1j


class Test_Error:
    def test_1(self):
        with pytest.raises(AssertionError):
            is_foreword_angle(n, np.append(xza, 1))

        with pytest.raises(AssertionError):
            is_foreword_angle(n, np.append(xza_cpx, 1))

    def test2(self):
        with pytest.raises(AssertionError):
            is_foreword_angle(n.conjugate(), xza)

        with pytest.raises(AssertionError):
            is_foreword_angle(n.conjugate(), xza_cpx)
