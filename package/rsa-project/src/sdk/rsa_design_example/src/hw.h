#ifndef _HW_H_
#define _HW_H_

#include <stdint.h>

// Calculates res = (message^exponent) mod N
void hw_mod_exp(uint32_t *msg, uint32_t *exp, uint32_t exp_len, uint32_t *n, uint32_t *R ,uint32_t *R2, uint32_t *res);

// Calculates res = (a * b / R) mod N where R = 2^1024
void hw_montgomery_multiply_first(unsigned int *a, unsigned int  *b, unsigned int  *n, unsigned int  *res, unsigned int  size);

// Calculates res = (a * a / R) mod N where R = 2^1024 and is the result of the last montgomery multiplication
// and and N is the last used modulus
void hw_montgomery_square_prev(unsigned int  *res, unsigned int SIZE);

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod_no_res(unsigned int  *a, unsigned int  *b, unsigned int size);

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod_no_res_no_a(unsigned int  *b, unsigned int size);

// Executes montgomery multiplication A*B/R % N on the hardware with the last used modulus
void hw_montgomery_multiply_no_mod_no_a(unsigned int  *b, unsigned int  *res, unsigned int size);

// Calculates res = (a * b / R) mod N where R = 2^1024 and N is the last used modulus
void hw_montgomery_multiply_no_mod(unsigned int *a, unsigned int  *b, unsigned int  *res, unsigned int  size);

void copy_bram_to(unsigned int *result, unsigned int SIZE);

void reduce_cipher(unsigned int *cipher, unsigned int *Cp, unsigned int *Cq);
#endif
