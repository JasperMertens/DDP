/*montgomeryASM.h*/

#ifndef MONTGOMERYASM_H_
#define MONTGOMERYASM_H_

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

void mont_mult_asm(uint32_t *a, uint32_t *b, uint32_t *n, uint32_t *n0, uint32_t *res, uint32_t SIZE);

#endif /* MONTGOMERYASM_H_ */

