#include <iostream>
#include <cstdlib>
#include <stdio.h>
#include <ctime>
#include <assert.h>

__global__ void allPrefixSums (long int* A_gpu, long int* arr, int N) {
    int id = threadIdx.x + (blockIdx.x * blockDim.x);
    if (id == 0) return;
    if (id > N-1) return;
    for (int i = 0; i < id; i++) {
        A_gpu[id] += arr[i];
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Incorrect input style, please do ./homework4 N" << std::endl;
        return 2;
    }

    int N = atoi(argv[1]);
    long int* arr = new long int[N];

    for (int i = 0; i < N; i++) {
        arr[i] = rand() % 1000 + 1;
    }

    long int* A_cpu = new long int[N];

    // Sequential Code for all prefix sum
    A_cpu[0] = 0;
    for (int i = 1; i < N; i++) {
        A_cpu[i] += (arr[i-1] + A_cpu[i-1]);
    }

    long int* deviceA;
    cudaMalloc(&deviceA, N * sizeof(long int));
    long int* deviceArr;
    cudaMalloc(&deviceArr, N*sizeof(long int));
    cudaMemcpy(deviceArr, arr, N*sizeof(long int), cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(1024, 1, 1);
    dim3 numBlocks(N / 1024 + 1, 1, 1);

    // Make the parallel call
    allPrefixSums<<<numBlocks, threadsPerBlock>>>(deviceA, deviceArr, N);

    long int* A_gpu = new long int[N];;
    cudaMemcpy(A_gpu, deviceA, N*sizeof(long int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; i++) {
        assert(A_gpu[i] == A_cpu[i]);
    }
    printf("GPU Output Matches CPU Output\n");

    return 0;
}

