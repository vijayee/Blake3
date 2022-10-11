build:
	mkdir -p build
	mkdir -p build/lib
	mkdir -p build/test
	mkdir -p build/example
build/example: build
	clang -o build/example/example Blake3/c/example.c Blake3/c/blake3.c Blake3/c/blake3_dispatch.c Blake3/c/blake3_portable.c \
    Blake3/c/blake3_sse2_x86-64_unix.S Blake3/c/blake3_sse41_x86-64_unix.S Blake3/c/blake3_avx2_x86-64_unix.S \
    Blake3/c/blake3_avx512_x86-64_unix.S
example:
	./build/example/example
libblake3: build
	clang -o build/lib/blake3.o -fPIC -O3 -c Blake3/c/blake3.c
	clang -o build/lib/blake3_dispatch.o -fPIC -O3 -c Blake3/c/blake3_dispatch.c
	clang -o build/lib/blake3_portable.o -fPIC -O3 -c Blake3/c/blake3_portable.c
	clang -o build/lib/blake3_sse2_x86-64_unix.o -O3 -fPIC -c Blake3/c/blake3_sse2_x86-64_unix.S
	clang -o build/lib/blake3_sse41_x86-64_unix.o -O3 -fPIC -c Blake3/c/blake3_sse41_x86-64_unix.S
	clang -o build/lib/blake3_avx2_x86-64_unix.o -O3 -fPIC -c Blake3/c/blake3_avx2_x86-64_unix.S
	clang -o build/lib/blake3_avx512_x86-64_unix.o -O3 -fPIC -c Blake3/c/blake3_avx512_x86-64_unix.S
	ar rcs build/lib/libblake3.a build/lib/blake3.o build/lib/blake3_dispatch.o build/lib/blake3_portable.o \
	build/lib/blake3_sse2_x86-64_unix.o build/lib/blake3_sse41_x86-64_unix.o build/lib/blake3_avx2_x86-64_unix.o \
	build/lib/blake3_avx512_x86-64_unix.o
install: libblake3
	mkdir -p /usr/local/lib/Blake3
	cp build/lib/libblake3.a /usr/local/lib/Blake3
test: libblake3
	ponyc --pic -p ./build/lib Blake3/test -o build/test --debug
	./build/test/test
