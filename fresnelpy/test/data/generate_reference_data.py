# # -*- coding: utf-8 -*-
# """
# Created on 17.04.19 by ibaris
# """
# from __future__ import division
# import numpy as np
# from tmm.tmm_core import is_forward_angle, snell
# import os
#
# DIR = "/home/ibaris/Dropbox/GitHub/fresnelpy/fresnelpy/test/test_bin/test_auxiliary/data"
#
# xmax = 20
# n1r = np.random.uniform(0.001, 10, xmax)  # Real part of n1
# n1i = np.random.uniform(0.001, 5, xmax)  # Imaginary part of n1
#
# n2r = np.random.uniform(0.001, 10, xmax)  # Real part of n2
# n2i = np.random.uniform(0.001, 5, xmax)  # Imaginary part of n2
#
# xza = np.linspace(0.001, np.pi / 4, xmax)
#
# n1 = n1r + n1i * 1j
# n2 = n2r + n2i * 1j
#
# ref_fa = list()
# for i in range(xmax):
#     ref_fa.append(is_forward_angle(n1[i], xza[i]))
#
# ref_snell = list()
# for i in range(len(n1)):
#     ref_snell.append(snell(n1[i], n2[i], xza[i]))
#
# np.savetxt(os.path.join(DIR, 'n1r.out'), n1.real)
# np.savetxt(os.path.join(DIR, 'n2r.out'), n2.real)
# np.savetxt(os.path.join(DIR, 'n1i.out'), n1.imag)
# np.savetxt(os.path.join(DIR, 'n2i.out'), n2.imag)
# np.savetxt(os.path.join(DIR, 'xza.out'), xza)
# np.savetxt(os.path.join(DIR, 'snell_true.out'), ref_snell)
# np.savetxt(os.path.join(DIR, 'forward_true.out'), ref_fa)
