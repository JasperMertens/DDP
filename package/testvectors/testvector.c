#include <stdint.h>                                              
                                                                 
// This file's content is created by the testvector generator    
// python script for seed = 2017.5                    
//                                                               
//  The variables are defined for the RSA                        
// encryption and decryption operations. And they are assigned   
// by the script for the generated testvector. Do not create a   
// new variable in this file.                                    
//                                                               
// When you are submitting your results, be careful to verify    
// the test vectors created for seed = 2017.1, to 2017.5         
// To create them, run your script as:                           
//   $ python testvectors.py crtrsa 2017.1                       
                                                                 
// message                                                       
uint32_t M[32] = {0xe11a8924, 0x7f4dbfc7, 0x337e872d, 0x23792c76, 0x294fc616, 0x47b8eaf4, 0x283a09e1, 0x12a92c2e, 0x99953796, 0xba3cc955, 0x3504f3eb, 0x8c84eab7, 0x150a1351, 0x681b24f5, 0x15e5db00, 0x698d7743, 0xd819807e, 0xae473f5c, 0x13168e4f, 0x6eba10f4, 0x024c25c3, 0x6b113bf8, 0x10000bcf, 0x2ed00140, 0x0e729842, 0xeca1e539, 0xf947c2be, 0x87a6746b, 0x8b63a9b0, 0x83efcd75, 0xa1074de4, 0x80443760};                 
                                                                 
// prime p and q                                                 
uint32_t p[16] = {0xb4d8c50d, 0xab2d4239, 0xcc52c6bd, 0xbcfc0dc9, 0x06e74d5b, 0x51c9419e, 0x2b625fbe, 0x27752c42, 0xa2e6ed3d, 0x466e8aa1, 0xd6cd644d, 0xc8b75f23, 0xcbb78fe1, 0x5fe14b0c, 0x838da10f, 0x884fb732};                 
uint32_t q[16] = {0x83e846a5, 0x21995141, 0x4e60bd6a, 0xeb399971, 0x430c02ba, 0x6ef05f7f, 0x8187d588, 0x15c6f8ef, 0x1821da6e, 0x93901812, 0x8e44b05d, 0xc8a1d370, 0x1141a890, 0xf5390c86, 0x935478f1, 0xf3aba73d};                 
                                                                 
// modulus                                                       
uint32_t N[32]       = {0x10608f61, 0x33466d3a, 0x1188892b, 0xaeb4d808, 0xd2bae079, 0x803ddcde, 0x902942f0, 0xce1e0e23, 0xc22abd22, 0xf1d50ede, 0x0bc3785e, 0x15dcfb6e, 0x9d7963ee, 0xb012be91, 0x88f702d6, 0x76b22d4e, 0xa51196e3, 0x6d2eb4c6, 0x8414fb4e, 0xd2e9387d, 0x3bf0fdba, 0x05788214, 0x6511659e, 0x637d3170, 0xe387b424, 0x2c466867, 0x943dcd36, 0xe7b60ab1, 0x42238e02, 0x3bb39adb, 0x1b90ab17, 0x81bf1131};           
uint32_t N_prime[32] = {0x4f85ab5f, 0xc937f85a, 0xac11e2b3, 0x8f82ebba, 0x8afeb30a, 0x40a288cc, 0xbcb84950, 0x25c8e746, 0xd0fde675, 0x72194758, 0xd1cc32f6, 0x561c346e, 0xaa4a498a, 0xbfb25dbc, 0xf2a79483, 0xdbf6b636, 0x08b06b60, 0x8637cae9, 0xebca6b8a, 0x9d1cbea6, 0xaec8e9f8, 0x9a317fef, 0xcda866fc, 0xa7c6f575, 0xe4f772c7, 0x2ee305b9, 0x87bea3d4, 0xb3fda161, 0xb11420e4, 0x1d91f3df, 0x75f8dfbd, 0xab5c00d1};     
                                                                 
// encryption exponent                                           
uint32_t e[32] = {0x0000aef5};                  
uint32_t e_len = 16;                                             
                                                                 
// decryption exponent, reduced to p and q                       
uint32_t d_p[16] = {0x4371c58d, 0x826a391f, 0x341d8c35, 0x22882e62, 0x42bf9e70, 0x8acd3990, 0xc20df9cb, 0x33c4ad5d, 0x07ad6ce4, 0xca464ef4, 0xd5fb0b1e, 0xdac8a6cf, 0xc54a4476, 0x8569955f, 0x67b791cb, 0x2dd5731d};             
uint32_t d_q[16] = {0x5cef2b89, 0xd5f2d4ee, 0xd49d304d, 0x23d59d33, 0x9c6f23ed, 0x171acefb, 0xfbafb9b1, 0x8c6219d5, 0xcb61a1ec, 0x3bb0f2cb, 0x48b9b7aa, 0xa93b7b9e, 0x6a416102, 0xba925075, 0x53f0a093, 0xce61c789};             
uint32_t d_p_len =  510;
uint32_t d_q_len =  512;
                                                                 
// x_p and x_q                                                   
uint32_t x_p[32] = {0x12014150, 0xf5b78916, 0xeac2e63c, 0x055a0bbf, 0xe097e961, 0xd29cd977, 0x060faf19, 0x0e089b43, 0x51ace6b3, 0x1029b5ab, 0x7d3c90b1, 0x3d83efe7, 0x5c5fcbc3, 0x6bebe74f, 0xc36f20db, 0xf2ccf2ff, 0xed0688d5, 0xd818bfdd, 0x34dacc3b, 0x358c281d, 0x44db585f, 0x572e15e7, 0x4522f2b0, 0xb04ac07c, 0xfa268d13, 0x6b75ad3b, 0x814e9197, 0x592b3f17, 0x686b2935, 0x1a3912b8, 0x88f24da9, 0x55e7a69f};             
uint32_t x_q[32] = {0xfe5f4e12, 0x3d8ee423, 0x26c5a2ee, 0xa95acc48, 0xf222f718, 0xada10366, 0x8a1993d6, 0xc01572e0, 0x707dd66f, 0xe1ab5933, 0x8e86e7ad, 0xd8590b86, 0x4119982a, 0x4426d742, 0xc587e1fb, 0x83e53a4e, 0xb80b0e0d, 0x9515f4e8, 0x4f3a2f12, 0x9d5d1060, 0xf715a55b, 0xae4a6c2c, 0x1fee72ed, 0xb33270f4, 0xe9612710, 0xc0d0bb2b, 0x12ef3b9e, 0x8e8acb9a, 0xd9b864cd, 0x217a8822, 0x929e5d6e, 0x2bd76a91};             
                                                                 
// R mod p, and R mod q, (R = 2^512)                             
uint32_t Rp[16] = {0x4b273af3, 0x54d2bdc6, 0x33ad3942, 0x4303f236, 0xf918b2a4, 0xae36be61, 0xd49da041, 0xd88ad3bd, 0x5d1912c2, 0xb991755e, 0x29329bb2, 0x3748a0dc, 0x3448701e, 0xa01eb4f3, 0x7c725ef0, 0x77b048cd};               
uint32_t Rq[16] = {0x7c17b95b, 0xde66aebe, 0xb19f4295, 0x14c6668e, 0xbcf3fd45, 0x910fa080, 0x7e782a77, 0xea390710, 0xe7de2591, 0x6c6fe7ed, 0x71bb4fa2, 0x375e2c8f, 0xeebe576f, 0x0ac6f379, 0x6cab870e, 0x0c5458c2};               
                                                                 
// R^2 mod p, and R^2 mod q, (R = 2^512)                         
uint32_t R2p[16] = {0xaef0309e, 0x835b1c26, 0x7c8c7c98, 0x5bd1261d, 0xba15e4d9, 0xe9e5286e, 0x3d7700f6, 0xc89b0109, 0xb2489412, 0x68095cd1, 0x23c27478, 0x4ee0f592, 0x980b80e8, 0xd42d7d6f, 0xa80a8645, 0x268171a0};             
uint32_t R2q[16] = {0xb9c99741, 0xec907711, 0x50bd2d55, 0xe84d3360, 0x471a57cd, 0xb621a00f, 0x73a8f825, 0x98709e3f, 0xd8803758, 0xe8133abb, 0xb3e3ed72, 0xff9e44d1, 0x3a356738, 0x3887a15b, 0x4b246434, 0x2be22a28};             
                                                                 
// R mod N, and R^2 mod N, (R = 2^1024)                          
uint32_t R_1024[32]  = {0xef9f709f, 0xccb992c5, 0xee7776d4, 0x514b27f7, 0x2d451f86, 0x7fc22321, 0x6fd6bd0f, 0x31e1f1dc, 0x3dd542dd, 0x0e2af121, 0xf43c87a1, 0xea230491, 0x62869c11, 0x4fed416e, 0x7708fd29, 0x894dd2b1, 0x5aee691c, 0x92d14b39, 0x7beb04b1, 0x2d16c782, 0xc40f0245, 0xfa877deb, 0x9aee9a61, 0x9c82ce8f, 0x1c784bdb, 0xd3b99798, 0x6bc232c9, 0x1849f54e, 0xbddc71fd, 0xc44c6524, 0xe46f54e8, 0x7e40eece};     
uint32_t R2_1024[32] = {0xa8f60bea, 0xd8d4c019, 0xa925b641, 0xc6c371b4, 0x0db41577, 0xeae25b70, 0xcae79a5c, 0xb4adb3a7, 0x124059e5, 0xb4d2d62e, 0x9dda8e41, 0xc3463ca2, 0x79ef025a, 0x4d2a1685, 0x1d825501, 0xa53d3898, 0xfba817c3, 0x96bb141b, 0x9cbfda29, 0xdefd0f4c, 0x53660854, 0x9ab72e9d, 0xdd0f5440, 0xc238453d, 0xf6bd0683, 0xb1b4eecf, 0x054d10dd, 0x576f18da, 0x868eef14, 0x3c74fbfe, 0x86d1a606, 0x5efeb65b};     
                                                                 
// One                                                           
uint32_t One[32] = {1,0};                                        
                                                                 
///////////////// FOR VERIFICATION //////////////////            
                                                                 
// Ciphertext, input of hardware decryption                      
uint32_t Ciphertext[32]  = {0x19165bf2, 0x1a1e07ac, 0xa710d7e8, 0x8a73ce23, 0xf0e74c50, 0x45314e0f, 0x7d208d38, 0x56b2d58d, 0x26f4443b, 0x77e3874f, 0x77414fb2, 0x001c768a, 0x9d3866bb, 0x6bea2e7a, 0x67772f96, 0xd805b8f2, 0x69b231e5, 0xedcf485b, 0x7296a3a5, 0x18e7359e, 0xdb6ee0fe, 0xf44a328e, 0x6ed95807, 0x13f8e5fe, 0xaacf2980, 0x5da1b6b3, 0xf909711a, 0x752c6f44, 0x055d877d, 0x71898cee, 0x2b81d3e0, 0x29612ac0};     
                                                                 
// Ciphertext_p and Ciphertext_q, output of reduction            
uint32_t Ciphertext_p[16]  = {0xd45299a3, 0x233e8a2b, 0x07c58d93, 0x24de286d, 0x1aec4816, 0xb17990fd, 0x9054f72a, 0xc743b14d, 0x7c74705c, 0x9eb94df0, 0x0ee46990, 0x0d72f0d4, 0x6e5346c0, 0x996ab972, 0x34ed14ea, 0x285b3432};  
uint32_t Ciphertext_q[16] = {0xc9e89ac0, 0x00d419a6, 0xf73ef354, 0xee802d63, 0x934bdfaf, 0x4fd71a80, 0x95fb52a1, 0xed78c28e, 0x4635326a, 0xae6f6f4d, 0x12436081, 0x1784430f, 0xd758ff3f, 0x99c5aaaf, 0x7407be32, 0x55ace494};   
                                                                 
// Plaintext_p and Plaintext_q, output of exponentiation         
// (needs to be allocate space for 32 words to combine correctly)
uint32_t Plaintext_p[32]  = {0x6d03f2a1, 0x9dbbf34b, 0x32c154e2, 0xcf44181c, 0xe5580123, 0x6252379e, 0x2ba391f6, 0xb660c32c, 0xab799a5a, 0x37b48ac7, 0x319f8150, 0x994d3298, 0xda1e3211, 0xe78626d4, 0xc00896f8, 0x7cb577df};    
uint32_t Plaintext_q[32] = {0x0ab34579, 0x6731e56a, 0x75d0f818, 0xcfa6d8dd, 0xf555ba0a, 0xea35f748, 0xebc9a556, 0xe3f8f0f6, 0x7592b55f, 0x28a16576, 0x2a50999a, 0x1310f20d, 0xa029b0a6, 0x4157a01b, 0x34ea1edc, 0x5044b344};     
                                                                 
// Plaintext, output of hardware decryption                      
uint32_t Plaintext[32]  = {0xe11a8924, 0x7f4dbfc7, 0x337e872d, 0x23792c76, 0x294fc616, 0x47b8eaf4, 0x283a09e1, 0x12a92c2e, 0x99953796, 0xba3cc955, 0x3504f3eb, 0x8c84eab7, 0x150a1351, 0x681b24f5, 0x15e5db00, 0x698d7743, 0xd819807e, 0xae473f5c, 0x13168e4f, 0x6eba10f4, 0x024c25c3, 0x6b113bf8, 0x10000bcf, 0x2ed00140, 0x0e729842, 0xeca1e539, 0xf947c2be, 0x87a6746b, 0x8b63a9b0, 0x83efcd75, 0xa1074de4, 0x80443760};        