#include <iostream>
#include <cstdlib>
#include <stdio.h>

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
    A_cpu[0] = 0;
    for (int i = 1; i < N; i++) {
        for (int j = 0; j < i; j++) {
            A_cpu[i] += arr[j];
        }
    }
    return 0;
}

