# -*- coding: utf-8 -*-
"""
Created on 18.04.19 by ibaris
"""
from __future__ import division
from fresnelpy.__version__ import __version__, version_info


class TestVersion:
    def test_version(self):
        assert __version__ == '.'.join(map(str, version_info))
