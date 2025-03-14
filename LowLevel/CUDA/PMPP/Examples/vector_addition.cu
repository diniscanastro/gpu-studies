#include <stdio.h>

// Compute vector sum h_C = h_A+h_B
__global__
void vecAdd(float* A, float* B, float* C, int n){
    int i = blockDim.x*blockIdx.x + threadIdx.x;
    if (i<n){
        C[i] = A[i] + B[i];
    } 
}

int main(){
    // Memory allocation for h_A, h_B, and h_C
    // Allocate memory
    const int N = 1000;
    const int N_size = sizeof(float) * N;
    float *h_A, *h_B, *h_C;
    h_A = (float*)malloc(N_size);
    h_B = (float*)malloc(N_size);
    h_C = (float*)malloc(N_size);

    // Initialize input arrays
    for (int i = 0; i < N; i++){
        h_A[i] = 1.0f;
        h_B[i] = 2.0f;
    }

    // Allocate device memory
    float *d_A, *d_B, *d_C;
    cudaMalloc((void**)&d_A, N_size);
    cudaMalloc((void**)&d_B, N_size);
    cudaMalloc((void**)&d_C, N_size);

    // Copy input arrays to device memory
    cudaMemcpy(d_A, h_A, N_size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, N_size, cudaMemcpyHostToDevice);

    // Run kernel
    vecAdd<<<ceil(N/256.0),256>>>(d_A, d_B, d_C, N);

    // Copy output array to host memory
    cudaMemcpy(h_C, d_C, N_size, cudaMemcpyDeviceToHost);

    // Print result
    for (int i=0; i < N; i++){
        printf("%f\n", h_C[i]);
    }

    // Free device allocated memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    // Free host allocated memory
    free(h_A);
    free(h_B);
    free(h_C);
}