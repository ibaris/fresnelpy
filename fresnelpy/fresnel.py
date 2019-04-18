# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division
from rspy import Sensor, align_all
import numpy as np
from fresnelpy.bin.bin_fresnel import reflection_matrix, reflection_matrix_extended


class Fresnel(Sensor):
    def __init__(self, xza, frequency, eps, rmsh, angle_unit='DEG', frequency_unit='GHz', length_unit='m',
                 name=None, type='stokes'):
        """

        Parameters
        ----------
        xza
        frequency
        eps
        rmsh
        angle_unit
        frequency_unit
        length_unit
        """

        xza, frequency, sigma, eps = align_all((xza, frequency, rmsh, eps))
        raa = np.zeros_like(xza)
        vza = np.zeros_like(xza)

        super(Fresnel, self).__init__(value=frequency, iza=xza, vza=vza, raa=raa, normalize=False,
                                      angle_unit=angle_unit, dtype=np.double,
                                      unit=frequency_unit, output=length_unit, name=name)

        self.type = type
        self.xza = self.iza
        self.eps = eps
        self.rmsh = rmsh

        self.h = 4 * self.rmsh ** 2 * self.wavenumber ** 2
        self.loss = np.exp(-self.h * np.cos(self.xza) ** 2)

    # --------------------------------------------------------------------------------------------------------
    # Callable Methods
    # --------------------------------------------------------------------------------------------------------
    def compute(self, xza=None):
        """

        Parameters
        ----------
        xza

        Returns
        -------

        """

        if xza is None:
            xza = self.xza

        if self.type == 'stokes':
            return reflection_matrix(xza, self.eps)

        return reflection_matrix_extended(xza, self.eps)
