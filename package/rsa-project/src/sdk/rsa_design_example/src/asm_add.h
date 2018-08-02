/*
 * asm_add.h
 *
 *
 */

#ifndef ASM_ADD_H_
#define ASM_ADD_H_

#include <stdint.h>
// carry addition algorithm
void add_c(uint32_t *t, uint32_t i, uint32_t C);
void asm_sum1(uint32_t *C_res, uint32_t *S_res, uint32_t *t, uint32_t *a, uint32_t *b, uint32_t i);
void asm_sum2(uint32_t *C_res, uint32_t S, uint32_t *n0, uint32_t *n);
void asm_end(uint32_t C, uint32_t *t); //*t[SIZE]


#endif /* ASM_ADD_H_ */
