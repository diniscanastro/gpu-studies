#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct PPMImage {
    int height;
    int width;
    int color_depth;
    char* content;
};

struct PPMImage read_ppm(const char *file_path){
    FILE *input_file = fopen(file_path, "rb");
    struct PPMImage image;

    const int buffer_size = 100;
    char line[buffer_size];
    int results = 0;

    // Get header
    fgets(line, sizeof(line), input_file);
    if (strcmp(line,"P6\n") != 0){
        printf("Unsupported header\n");
    }

    // Get comments
    while(1){
        fgets(line, sizeof(line), input_file);
        if (line[0] != '#'){
            break;
        }
    }

    // Get size
    results = sscanf(line, "%d %d\n", &image.height, &image.width);
    if (results != 2) {
        printf("Invalid size\n");
        exit(1);
    }
    image.content = (char*)malloc(sizeof(char) * image.height * image.width * 3);

    // Get color depth
    results = fscanf(input_file, "%d\n", &image.color_depth);
    if (results != 1) {
        printf("Invalid color depth\n");
        exit(1);
    }else if (image.color_depth != 255)
    {
        printf("Only supports 255 color depth for now\n"); // TODO: Only supports 255 (1 byte) color depth for now hence the char type
        exit(2);
    }

    // Get content
    fread(image.content, sizeof(char),3 * image.width * image.height, input_file);

    fclose(input_file);
    return image;
}

void write_ppm(const char *file_path, struct PPMImage image){
    FILE *output_file = fopen(file_path, "wb");

    fprintf(output_file, "P6\n");
    fprintf(output_file, "# If you're reading this, it's because copilot stole it without permission :)\n");
    fprintf(output_file, "%d %d\n", image.width, image.height);
    fprintf(output_file, "%d\n", image.color_depth);
    fwrite(image.content, sizeof(char), 3 * image.width * image.height, output_file);
    fclose(output_file);
}
