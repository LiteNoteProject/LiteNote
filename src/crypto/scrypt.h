#ifndef BITCOIN_CRYPTO_SCRYPT_H
#define BITCOIN_CRYPTO_SCRYPT_H

#include <stdlib.h>
#include <stdint.h>
#include "scrypt-impl.h"

#define SCRYPT_SCRATCHPAD_SIZE 8
#define scrypt_1024_1_1_256_sp_generic(a,b,c) scrypt_1024_1_1_256(a,b)
void scrypt_1024_1_1_256(const char *input, char *output);
#endif // BITCOIN_CRYPTO_SCRYPT_H
