.DEFAULT_GOAL := run

build: main.cpp
	g++ main.cpp -o raytracing.out

run: build
	./raytracing.out > outputs/test.ppm
