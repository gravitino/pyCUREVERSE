CC      = g++
CFLAGS  = -fPIC -march=native

NVCC    = nvcc
NVFLAG  = -arch=sm_30 -O3

PYPATH  = /usr/include/python2.7
CUDALD  = /usr/local/cuda-7.0/targets/x86_64-linux/lib/

OBJ = pyCUREVERSE.o pyCUREVERSE_wrap.o

all: _pyCUREVERSE.so

pyCUREVERSE_wrap.cxx: pyCUREVERSE.i numpy.i pyCUREVERSE.cu pyCUREVERSE.cuh
	swig -python -c++ pyCUREVERSE.i

pyCUREVERSE_wrap.cu: pyCUREVERSE_wrap.cxx
	mv pyCUREVERSE_wrap.cxx pyCUREVERSE_wrap.cu

pyCUREVERSE.o: pyCUREVERSE.cu pyCUREVERSE.cuh
	$(NVCC) $(NVFLAGS) -c pyCUREVERSE.cu -Xcompiler "$(CFLAGS)"

pyCUREVERSE_wrap.o: pyCUREVERSE_wrap.cu
	$(NVCC) $(NVFLAGS) -c pyCUREVERSE_wrap.cu -Xcompiler "$(CFLAGS) -I $(PYPATH)" 

_pyCUREVERSE.so: $(OBJ)
	$(CC) $(CFLAGS) pyCUREVERSE.o pyCUREVERSE_wrap.o -shared -lcuda -lcudart -L $(CUDALD) -o _pyCUREVERSE.so
	rm -f pyCUREVERSE_wrap.cu $(OBJ)

clean:
	rm -f pyCUREVERSE.py pyCUREVERSE.pyc _pyCUREVERSE.so *~

NEWLIBNAME=pymylib
rename:
	sed -i 's/pyCUREVERSE/$(NEWLIBNAME)/g' *
	mv pyCUREVERSE.cu  $(NEWLIBNAME).cu
	mv pyCUREVERSE.cuh $(NEWLIBNAME).cuh
	mv pyCUREVERSE.i   $(NEWLIBNAME).i          

