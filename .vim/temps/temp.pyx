# cython: language_level=3, boundscheck=False, wraparound=False, nonecheck=False, cdivision=True
import numpy as np
cimport numpy as np
from libc.math cimport sin, cos, sqrt, pow
np.import_array()


### SHELL FILE
#!/bin/sh
python cython_build.py build_ext --inplace
# `cython evection_solver.pyx -a` to produce a python code report


### cython_build.py
from setuptools import setup, Extension
from Cython.Distutils import build_ext
import numpy as np

ext_modules = [Extension(
    'evection_solver',
    ['evection_solver.pyx'],
    libraries=['m', ],
    extra_compile_args=['-Ofast'],
    define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")],
)]

setup(
    name='evection_solver',
    cmdclass={'build_ext': build_ext},
    ext_modules=ext_modules,
    include_dirs=np.get_include(),
)
