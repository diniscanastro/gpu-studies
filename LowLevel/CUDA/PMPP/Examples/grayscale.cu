#include <stdio.h>
#include "include/auxiliary.c"

#define CHANNELS 3

// Device Kernel
__global__
void colorToGreyscaleConversion(unsigned char *Pout, unsigned char *Pin, int height, int width){
    int col = blockDim.x*blockIdx.x + threadIdx.x;
    int row = blockDim.y*blockIdx.y + threadIdx.y;

    if (col < width && row < height){
        int offset = (row * width + col) * CHANNELS;

        unsigned char r = Pin[offset];
        unsigned char g = Pin[offset + 1];
        unsigned char b = Pin[offset + 2];

        unsigned char grey_value = 0.21f*r + 0.71f*g + 0.07f*b;

        Pout[offset] = grey_value;
        Pout[offset + 1] = grey_value;
        Pout[offset + 2] = grey_value;
    } 
}


int main(){    
    // Initialize host memory input values from file
    const char *input_file_path = "test_images/test_image.ppm";
    struct PPMImage input_image = read_ppm(input_file_path);

    // Allocate device memory
    int total_size = input_image.height * input_image.width * CHANNELS;
    unsigned char *Pin, *Pout;
    cudaMalloc((void**)&Pin, total_size);
    cudaMalloc((void**)&Pout, total_size);

    // Transfer input to device memory
    cudaMemcpy(Pin, input_image.content, total_size, cudaMemcpyHostToDevice);

    // Run Kernel
    dim3 dimGrid(ceil(input_image.height/16.0), ceil(input_image.width/16.0), 1);
    dim3 dimBlock(16, 16, 1);
    colorToGreyscaleConversion<<<dimGrid,dimBlock>>>(Pout, Pin, input_image.height, input_image.width);

    // Transfer output to host memory
    struct PPMImage output_image = copy_ppm(input_image);
    cudaMemcpy(output_image.content, Pout, total_size, cudaMemcpyDeviceToHost);
    
    // Write results to new file
    const char* output_file_path = "outputs/output_test.ppm";
    write_ppm(output_file_path, output_image);

    // De-allocate device memory
    cudaFree(Pin);
    cudaFree(Pout);

    // De-allocate host memory
    free(input_image.content);
    free(output_image.content);
}