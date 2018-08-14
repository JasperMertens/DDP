#ifndef _HW_H_
#define _HW_H_

#include <stdint.h>

// Calculates res = (message^exponent) mod N
void hw_mod_exp(uint32_t *msg, uint32_t *exp, uint32_t exp_len, uint32_t *n, uint32_t *R ,uint32_t *R2, uint32_t *res);

// Calculates res = (a * b / R) mod N where R = 2^512 and writes the result to res
void hw_montgomery_multiply_first(unsigned int *a, unsigned int  *b, unsigned int  *n, unsigned int  *res, unsigned int  size);

// Calculates res = (a * a / R) mod N where R = 2^512. a and N are the result and the modulus of the last montgomery multiplication respectively
void hw_montgomery_square_prev();

// Calculates res = (a * b / R) mod N where R = 2^512. N is the modulus of the last montgomery multiplication
void hw_montgomery_multiply_A_B(unsigned int  *a, unsigned int  *b, unsigned int size);

// Calculates res = (a * b / R) mod N where R = 2^512. a and N are the result and the modulus of the last montgomery multiplication respectively
void hw_montgomery_multiply_B(unsigned int  *b, unsigned int size);

// Calculates res = (a * b / R) mod N where R = 2^512 and writes the result to res.
// a and N are the result and the modulus of the last montgomery multiplication respectively
void hw_montgomery_multiply_B_result(unsigned int  *b, unsigned int  *res, unsigned int size);

void copy_bram_to(unsigned int *result, unsigned int SIZE);

void reduce_cipher(unsigned int *cipher, unsigned int *Cp, unsigned int *Cq);
#endif
