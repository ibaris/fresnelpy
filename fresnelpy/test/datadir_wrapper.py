# -*- coding: utf-8 -*-
"""
Created on 17.04.19 by ibaris
"""
import pytest
import os
from distutils import dir_util


@pytest.fixture
def datadir(tmpdir, request):
    """
    Fixture responsible for locating the test data directory and copying it
    into a temporary directory.
    Taken from  http://www.camillescott.org/2016/07/15/travis-pytest-scipyconf/
    """
    filename = __file__
    test_dir = os.path.dirname(filename)
    print (test_dir)
    data_dir = os.path.join(test_dir, 'data')
    dir_util.copy_tree(data_dir, str(tmpdir))

    def getter(filename, as_str=True):
        filepath = tmpdir.join(filename)
        if as_str:
            return str(filepath)
        return filepath

    return getter
