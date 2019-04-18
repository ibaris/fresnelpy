# -*- coding: utf-8 -*-
"""
Created on 17.04.19 by ibaris
"""
from __future__ import division

import numpy as np

from fresnelpy.bin.bin_fresnel import snell
from fresnelpy.test.datadir_wrapper import datadir

class TestValues:
    def test1(self, datadir):
        nr = np.loadtxt(datadir("n1r.out"), unpack=True)
        ni = np.loadtxt(datadir("n1i.out"), unpack=True)
        n = nr + ni * 1j
        n2r = np.loadtxt(datadir("n2r.out"), unpack=True)
        n2i = np.loadtxt(datadir("n2i.out"), unpack=True)
        n2 = n2r + n2i * 1j

        xza = np.loadtxt(datadir("xza.out"), unpack=True)
        reference = np.loadtxt(datadir("snell_true.out"), unpack=True, dtype=complex)

        value = snell(xza, n, n2)

        for i in range(value.shape[0]):
            assert np.allclose(value[i], reference[i])
