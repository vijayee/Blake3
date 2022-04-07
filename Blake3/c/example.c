#include "blake3.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  // Initialize the hasher.
  blake3_hasher* hasher = blake3_hasher_allocate();
  printf("\nSize: %lu\n", sizeof(*hasher));
  blake3_hasher_init(hasher);
  printf("\nSize: %lu\n", sizeof(*hasher));

  // Read input bytes from stdin.
  uint8_t buf[] = {1,2,3,4,5,6,7,8,3,76,4,2,7,3,78,3};
  blake3_hasher_update(hasher, buf, sizeof(buf));

  // Finalize the hash. BLAKE3_OUT_LEN is the default output length, 32 bytes.
  uint8_t output[BLAKE3_OUT_LEN];
  blake3_hasher_finalize(hasher, output, BLAKE3_OUT_LEN);
  blake3_hasher_deallocate(hasher);
  // Print the hash as hexadecimal.
  for (size_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    printf("%d,", output[i]);
  }
  printf("\n");
  return 0;
}
