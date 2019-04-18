# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division

import numpy as np

from fresnelpy import Fresnel

n = 100

xza = np.random.uniform(np.deg2rad(10), np.deg2rad(90), n)
eps = np.random.uniform(1, 40, n) + np.random.uniform(1, 40, n) / 10 * 1j
frequency = np.random.uniform(1, 2, n)
rmsh = np.random.uniform(0.001, 0.05, n)


class TestInit:
    def test1(self):
        f = Fresnel(xza=xza, frequency=frequency, eps=eps, rmsh=rmsh)

        for i in range(f.I.array.shape[0]):
            assert f.I.array[i].shape[0] == 4
            assert f.I.array[i].shape[1] == 4

    def test2(self):
        f = Fresnel(xza=xza, frequency=frequency, eps=eps, rmsh=rmsh, type='extended')

        for i in range(f.I.array.shape[0]):
            assert f.I.array[i].shape[0] == 5
            assert f.I.array[i].shape[1] == 5

    def test3(self):
        f = Fresnel(xza=xza, frequency=frequency, eps=eps, rmsh=rmsh, type='extended')

        for i in range(f.I.array.shape[0]):
            assert np.allclose(f.I.array[i][0, 0] + f.I.array[i][0, 1] + f.I.array[i][0, 2], f.I.array[i][1, 1])
            assert np.allclose(f.I.array[i][0, 0] - f.I.array[i][0, 1] - f.I.array[i][0, 2], f.I.array[i][2, 2])
