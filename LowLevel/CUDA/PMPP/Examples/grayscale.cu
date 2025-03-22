#include <stdio.h>
#include "include/auxiliary.c"

// Device Kernel



int main(){
    // Allocate host memory
    
    // Initialize host memory input values from file
    const char* input_file_path = "test_images/test_image.ppm";
    struct PPMImage image = read_ppm(input_file_path);

    // Allocate device memory

    // Transfer input to device memory

    // Run Kernel

    // Transfer output to host memory

    // Write results to new file
    const char* output_file_path = "outputs/output_test.ppm";
    write_ppm(output_file_path, image);

    // De-allocate device memory

    // De-allocate host memory
}