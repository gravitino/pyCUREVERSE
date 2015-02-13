%module pyCUREVERSE

%{
/* Includes the header in the wrapper code */
#define SWIG_FILE_WITH_INIT
#include "pyCUREVERSE.cuh"
%}

%include "typemaps.i"
%include "numpy.i"

%init %{
import_array();
%}

%include "pyCUREVERSE.cuh"

%apply (double* INPLACE_ARRAY1, int DIM1) {(double* x, int N)};
%template(reverseD)  reverse<int, double>;

%apply (float* INPLACE_ARRAY1, int DIM1) {(float* x, int N)};
%template(reverseF)  reverse<int, float>;

%apply (long* INPLACE_ARRAY1, int DIM1) {(long* x, int N)};
%template(reverseL)  reverse<int, long>;

%apply (int* INPLACE_ARRAY1, int DIM1) {(int* x, int N)};
%template(reverseI)  reverse<int, int>;

