#!/bin/sh
cd ../../
mkdir -p build/lib
clang -o build/lib/blake3.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3.c
clang -o build/lib/blake3_dispatch.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_dispatch.c
clang -o build/lib/blake3_portable.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_portable.c
clang -o build/lib/blake3_sse2_x86-64_unix.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_sse2_x86-64_unix.S
clang -o build/lib/blake3_sse41_x86-64_unix.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_sse41_x86-64_unix.S
clang -o build/lib/blake3_avx2_x86-64_unix.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_avx2_x86-64_unix.S
clang -o build/lib/blake3_avx512_x86-64_unix.o -c _corral/github_com_vijayee_Blake3/Blake3/c/blake3_avx512_x86-64_unix.S
ar rcs build/lib/libblake3.a build/lib/blake3.o build/lib/blake3_dispatch.o build/lib/blake3_portable.o \
build/lib/blake3_sse2_x86-64_unix.o build/lib/blake3_sse41_x86-64_unix.o build/lib/blake3_avx2_x86-64_unix.o \
build/lib/blake3_avx512_x86-64_unix.o
rm build/lib/blake3.o build/lib/blake3_dispatch.o build/lib/blake3_portable.o \
build/lib/blake3_sse2_x86-64_unix.o build/lib/blake3_sse41_x86-64_unix.o build/lib/blake3_avx2_x86-64_unix.o \
build/lib/blake3_avx512_x86-64_unix.o
cd _corral/github_com_vijayee_Blake3/
