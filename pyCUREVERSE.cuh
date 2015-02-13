#ifndef PYCUREVERSE_CUH
#define PYCUREVERSE_CUH

#include <iostream>

#define CUERR {                                                              \
    cudaError_t err;                                                         \
    if ((err = cudaGetLastError()) != cudaSuccess) {                         \
       std::cout << "CUDA error: " << cudaGetErrorString(err) << " : "       \
                 << __FILE__ << ", line " << __LINE__ << std::endl;          \
       exit(1);                                                              \
    }}

#define GRIDDIM  (1024)
#define BLOCKDIM (1024)

#ifndef SWIG
template <class index_t, class value_t> __global__
void reverse_kernel(value_t * x_d, index_t N) {

    size_t thid = blockIdx.x*blockDim.x + threadIdx.x;
    
    for (; thid < N/2; thid += gridDim.x*blockDim.x) {
        value_t temporary = x_d[thid];
        x_d[thid] = x_d[N-thid-1];
        x_d[N-thid-1] = temporary;
    }
}
#endif

template <class index_t, class value_t> 
void reverse(value_t * x, index_t N) {

    value_t * x_d;
    cudaMalloc((void**) &x_d, sizeof(value_t)*N);                         CUERR
    cudaMemcpy(x_d, x, sizeof(value_t)*N, cudaMemcpyHostToDevice);        CUERR
    reverse_kernel<<<GRIDDIM, BLOCKDIM>>>(x_d, N);                        CUERR
    cudaMemcpy(x, x_d, sizeof(value_t)*N, cudaMemcpyDeviceToHost);        CUERR
    cudaFree(x_d);                                                        CUERR
}

#endif
