pyCUREVERSE
=========

is a boilerplate project to document CUDA-bindings for Numpy using Swig. pyCUREVERSE does not claim

- to have any application in real world scenarios
- to be an efficient reversal algorithm of arrays on CUDA-enabled devices

Nevertheless, you can use pyCUDAREVERSE

- to bind any CUDA-kernel to numpy arrays (fuck yeah CUFFT, CUBLAS, ...)
- to have fun with GPUs
- to visualize the stuff (matplotlib, mayavi) you have calculate with CUDA

Please note, there is pycuda. pyCUREVERSE aims to provide bindings on the lowes level possible (no, ctypes is an alternative)
