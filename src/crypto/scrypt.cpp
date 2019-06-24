// Copyright 2019 Ronsor Labs, The LiteNote Developers, et al.

#include <crypto/scrypt.h>

#include <stdlib.h>
#include <stdint.h>
#include <string.h>

// FIXME: not really scrypt N,r,p=1024,1,1
void scrypt_1024_1_1_256(const char *input, char *output)
{
	if (libscrypt_scrypt((uint8_t*)input, 80, (uint8_t*)input, 80, 8192, 8, 1, (uint8_t*)output, 32) == -1)
		abort();
}
