# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division

import numpy as np
import pytest

from fresnelpy.auxiliary import FresnelResult


class TestAllDicts:
    def test_dicts(self):
        a = np.random.random()

        a_item = FresnelResult(a=a)

        assert a_item.a == a

    def test_dicts_err(self):
        a = np.random.random()

        a_item = FresnelResult(a=a)

        with pytest.raises(AttributeError):
            a_item.b

    def test_dicts_dir(self):
        a = np.random.random()

        a_item = FresnelResult(a=a)

        assert dir(a_item) == ['a']

    def test_repr(self):
        a = round(np.random.random(), 2)

        a_item = FresnelResult(a=a)

        assert repr(a_item) == ' a: ' + str(a)
