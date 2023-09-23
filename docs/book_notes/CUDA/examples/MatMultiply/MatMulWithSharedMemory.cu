#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <stdio.h>
#include <malloc.h>
#include <random>
//#include <device_functions.h>
#include "../inc/MemFile.h"
#include "../inc/helper_cuda.h"

#define BLOCK_SIZE 16
#define M 1024
#define N 2048
#define L 16

typedef struct{
	int width;
	int height;
	int stride;
	double* elements;
}Matrix;

__device__ __host__ double GetElement(const Matrix A, int row, int col) {
	return A.elements[row * A.stride + col];
}

__device__ __host__ void SetElement(Matrix A, int row, int col, double value) {
	A.elements[row * A.stride + col] = value;
}

__device__ Matrix GetSubMatrix(Matrix A, int row, int col) {
	Matrix Asub;
	Asub.width = BLOCK_SIZE;
	Asub.height = BLOCK_SIZE;
	Asub.stride = A.stride;
	Asub.elements = &A.elements[A.stride * BLOCK_SIZE * row
		+ BLOCK_SIZE * col];
	return Asub;
}

__global__ void MatMulKernel(const Matrix, const Matrix, Matrix);

void MatMul(const Matrix A, const Matrix B, Matrix C) {
	Matrix d_A;
	d_A.width = d_A.stride = A.stride, d_A.height = A.height;
	size_t size = A.width * A.height * sizeof(double);
	checkCudaErrors(cudaMalloc(&d_A.elements, size));
	checkCudaErrors(cudaMemcpy(d_A.elements, A.elements, size, cudaMemcpyHostToDevice));

	Matrix d_B;
	d_B.width = d_B.stride = B.width, d_B.height = B.height;
	size = B.width * B.height * sizeof(double);
	checkCudaErrors(cudaMalloc(&d_B.elements, size));
	checkCudaErrors(cudaMemcpy(d_B.elements, B.elements, size, cudaMemcpyHostToDevice));

	// Allocate result matrix
	Matrix d_C;
	d_C.width = d_C.stride = C.width, d_C.height = C.height;
	size = d_C.width * d_C.height * sizeof(double);
	checkCudaErrors(cudaMalloc(&d_C.elements, size));

	// Invoke kernel
	dim3 dimBlock(BLOCK_SIZE, BLOCK_SIZE);
	dim3 dimGrid((B.width + BLOCK_SIZE - 1) / BLOCK_SIZE, (A.height + BLOCK_SIZE - 1) / BLOCK_SIZE);
	MatMulKernel << <dimGrid, dimBlock >> > (d_A, d_B, d_C);

	checkCudaErrors(cudaMemcpy(C.elements, d_C.elements, size, cudaMemcpyDeviceToHost));

	checkCudaErrors(cudaFree(d_A.elements));
	checkCudaErrors(cudaFree(d_B.elements));
	checkCudaErrors(cudaFree(d_C.elements));
}

__global__ void MatMulKernel(Matrix A, Matrix B, Matrix C) {
	int blockRow = blockIdx.y;
	int blockCol = blockIdx.x;

	Matrix Csub = GetSubMatrix(C, blockRow, blockCol);
	double Cvalue = 0; // Ҫע�⣺����һ���߳��еı�����һ��Block�У�ʵ���� BLOCK_SIZE * BLOCK_SIZE ������

	int row = threadIdx.y;
	int col = threadIdx.x;

	for (int m = 0; m < ((A.width + BLOCK_SIZE - 1) / BLOCK_SIZE); m++) {
		Matrix Asub = GetSubMatrix(A, blockRow, m);
		Matrix Bsub = GetSubMatrix(B, m, blockCol);

		// �ù����ڴ��ݴ��ȫ���ڴ���ȡ��Asub��Bsub������ȫ���ڴ���ʴ���
		// �ô����Ϊ BLOCK_SIZE * BLOCK_SIZE * 2
		// ��Ȼ��A��һ�п��Զ���B�������У��ȵȣ��ܹ��ô����Ϊ (BLOCK_SIZE * BLOCK_SIZE)^2
		__shared__ double As[BLOCK_SIZE][BLOCK_SIZE]; // ������Ϊ block������ֻ�����һ�Σ��� for ѭ��û�й�ϵ
		__shared__ double Bs[BLOCK_SIZE][BLOCK_SIZE]; // TODO: bank conflict

		As[row][col] = GetElement(Asub, row, col);
		Bs[row][col] = GetElement(Bsub, row, col);

		__syncthreads();

		for (int e = 0; e < BLOCK_SIZE; e++)
			Cvalue += As[row][e] * Bs[e][col];

		__syncthreads();
	}
	
	SetElement(Csub, row, col, Cvalue);
}

void SetMatrix(Matrix A, int m, int n) {
	for (int i = 0; i < m; i++)
		for (int j = 0; j < n; j++)
			SetElement(A, i, j, rand() % 10000 / 1e4);
}

int main() {
	Matrix A, B, C;
	A.width = A.stride = N, A.height = M;
	A.elements = (double*)malloc(M * N *  sizeof(double));
	B.width = B.stride = L, B.height = N;
	B.elements = (double *)malloc(N * L * sizeof(double));
	C.width = C.stride = L, C.height = M;
	C.elements = (double*)malloc(M*L * sizeof(double));

	SetMatrix(A, M, N);
	SetMatrix(B, N, L);

	MemFile::writeBin("A.dat", A.elements, N, M);
	MemFile::writeBin("B.dat", B.elements, L, N);

	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start, 0);
	MatMul(A, B, C);
	cudaEventRecord(stop, 0);
	cudaEventSynchronize(stop);
	float elapsedTime;
	cudaEventElapsedTime(&elapsedTime, start, stop);
	printf("elapsed time: %f ms\n", elapsedTime); // ������Բ�׼��������Host-Device���ڴ濽����Device���ڴ��ͷ�ʱ�䡣

	MemFile::writeBin("C.dat", C.elements, L, M);

	return 0;
}