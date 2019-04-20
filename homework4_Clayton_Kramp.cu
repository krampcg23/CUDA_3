#include <iostream>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Incorrect input style, please do ./homework4 N" << endl;
        return 2;
    }

    int N = argv[1];
    int* arr = new int[N];

    for (int i = 0; i < N; i++) {
        arr[i] = rand() % 1000 + 1;
    }

    int* A_cpu = new int[N];
    A_cpu[0] = 0;
    for (int i = 1; i < N; i++) {
        for (int j = 0; j <= i; j++) {
            A_cpu[i] += arr[j];
        }
    }

    for (int i = 0; i < N; i++) {
        printf("%i,  %i", A_cpu[i], arr[i]);
    }

    return 0;
}

