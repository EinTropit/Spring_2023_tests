
#ifndef TEST_FUNC_H
#define TEST_FUNC_H
#include <stdint.h>
#include <stdio.h>
#include "aux_code.h"

void keyMixing(uint8_t input[4][4], uint8_t key[4][4]);
void byteSubstitution(uint8_t input[4][4]);
void shiftRows(uint8_t input[4][4]);
void cipher(uint8_t input[][4][4], uint8_t key[4][4], uint8_t len);

#endif //TEST_FUNC_H