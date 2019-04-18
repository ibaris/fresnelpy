# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division

import numpy as np
from rspy import Sensor, align_all

from fresnelpy.auxiliary import FresnelResult
from fresnelpy.bin.bin_fresnel import reflection_matrix, reflection_matrix_extended, loss_reflection

__all__ = ['Fresnel']


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

        self.__array = None
        self.__I = None

    # --------------------------------------------------------------------------------------------------------
    # Properties
    # --------------------------------------------------------------------------------------------------------
    @property
    def I(self):
        if self.__I is None:
            self.__I = self.__store_intensity()

        return self.__I

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
            reflection = reflection_matrix(xza, self.eps)
        else:
            reflection = reflection_matrix_extended(xza, self.eps)

        return loss_reflection(reflection, self.loss)

    # --------------------------------------------------------------------------------------------------------
    # Private Methods
    # --------------------------------------------------------------------------------------------------------
    def __store_intensity(self):
        if self.__array is None:
            self.__array = self.compute()

        if self.type == 'stokes':
            I = FresnelResult(array=self.__array,
                              VV=self.__array[:, 0, 0],
                              HH=self.__array[:, 1, 1])

        else:
            I = FresnelResult(array=self.__array,
                              total=self.__array[:, 0, 0],
                              VV=self.__array[:, 1, 1],
                              HH=self.__array[:, 2, 2])

        return I
