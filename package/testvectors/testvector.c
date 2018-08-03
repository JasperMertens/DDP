#include <stdint.h>                                              
                                                                 
// This file's content is created by the testvector generator    
// python script for seed = 2018                    
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
uint32_t M[32] = {0x63afb1f7, 0xaba87eec, 0xb6764251, 0x1621871e, 0x681db671, 0x3a66370a, 0x16038424, 0xf234598d, 0xa5009e03, 0x68d08548, 0xd87b9eb4, 0x59c17605, 0xf5e083e7, 0x1ff9df49, 0xef859016, 0x3c76a767, 0x97339f71, 0x09050752, 0x5d9fe843, 0x2c09ee7b, 0x98e60159, 0x0c4eac22, 0xffc30f02, 0xe0d26a83, 0xcb29d89e, 0x970f2ca9, 0xe5b50190, 0x9a62c45c, 0x66bd8b51, 0xfa14d73c, 0xa7aaae2e, 0xa33a8771};                 
                                                                 
// prime p and q                                                 
uint32_t p[16] = {0xbca0b1cb, 0x24d86196, 0x4136e0ea, 0xa7fbcaea, 0xeb996da1, 0x4a5cedab, 0x9255ee91, 0x38dd9dd6, 0xa3107e68, 0x47e04312, 0x315f02ef, 0xa45e7b6e, 0x7e7c9d58, 0x643db508, 0xe31b678a, 0xfe461672};                 
uint32_t q[16] = {0x93396323, 0x7d88ab73, 0x96b44b12, 0xb26f168d, 0x089fff62, 0xee90e59f, 0xbdf699bf, 0x5b256d22, 0xfbf87f88, 0x53a0b98c, 0x39a425fd, 0x2641abc1, 0x8aa0e889, 0xc9ebaa28, 0x7064a229, 0xd729c7f3};                 
                                                                 
// modulus                                                       
uint32_t N[32]       = {0x15eccfc1, 0xa5fd5f9e, 0x7f76eca4, 0xa9e435d8, 0xab84283c, 0x4f99fd31, 0x6ca75907, 0x4c0c84c9, 0xc0de16d2, 0x1f35c9b6, 0x83ccb378, 0x7f6f94cc, 0x66790995, 0xb7c94c58, 0xf5954def, 0x421c3722, 0xddbd7efe, 0xe35ab0bb, 0x7bcfedd6, 0x6992174a, 0xe00e6e5b, 0x386fd518, 0x3b6148c4, 0x6885c790, 0x568881ba, 0x98952f40, 0xcfc7065d, 0x34cd4190, 0x930b117c, 0x9413d84d, 0x5cbf9f35, 0xd5b65cae};           
uint32_t N_prime[32] = {0x4950bfbf, 0x26c67233, 0xb2ce12dd, 0x67a25752, 0x22e1761a, 0xe6f2b204, 0x25a0697e, 0xcd5914af, 0x3505ec06, 0xddda9741, 0x7aab37e0, 0x4620fa57, 0x7bef5837, 0x0dbb1fab, 0xe7f8a289, 0x6c9f80e6, 0xf7b033d4, 0xd2a6e9e4, 0xd0a9a82d, 0xb82a800c, 0xec137b79, 0xa75142c5, 0xefb5bf31, 0x02a80107, 0x6b4b2a79, 0x0baf9e5d, 0xe721c448, 0xba912d58, 0xf9e82077, 0x64c88a1c, 0x801041d3, 0x6cb7b698};     
                                                                 
// encryption exponent                                           
uint32_t e[32] = {0x00008563};                  
uint32_t e_len = 16;                                             
                                                                 
// decryption exponent, reduced to p and q                       
uint32_t d_p[16] = {0xc86ae9c1, 0xc819a7b9, 0xeb5452f0, 0x88da8608, 0xa267e179, 0x119a4f9d, 0xffe059e1, 0xe50772ee, 0xeae5e3b7, 0x6526c36e, 0xbec6c866, 0x96eb1986, 0xe855765d, 0x08e04dcd, 0xfbe947c8, 0xb6fb4430};             
uint32_t d_q[16] = {0x3a700b2f, 0x6f990209, 0x03a9ebf5, 0x77baa418, 0x07052197, 0x815e9de3, 0x0bee085b, 0x79f5af31, 0x70732dfa, 0xfbfd5988, 0x89100937, 0x46fa69fe, 0x58e8ae31, 0x11fe9717, 0x1a91c555, 0xd2d8d28f};             
uint32_t d_p_len =  512;   
uint32_t d_q_len =  512;   
                                                                 
// x_p and x_q                                                   
uint32_t x_p[32] = {0x43be7af1, 0xeafc80db, 0x54e9ee44, 0x158c2fe4, 0xe6ef1620, 0x088d3615, 0x188a0ca2, 0x8d8cdd1f, 0x06e202c9, 0x41d8a6f3, 0xa649a603, 0x7cfd8116, 0xc8c86d3f, 0x062bc5e5, 0x072e75fb, 0xa293659f, 0xf2ca2a61, 0x5c3a9f79, 0xf9142817, 0x6f3f84e4, 0xb02af2ae, 0xfa90b41d, 0x70c1143a, 0xb7da447e, 0xc836d610, 0x5e8425d3, 0x1e7b2c9a, 0x9243974d, 0xe080d1d7, 0xf9d17d39, 0xa6a021e1, 0x6720eba4};             
uint32_t x_q[32] = {0xd22e54d1, 0xbb00dec2, 0x2a8cfe5f, 0x945805f4, 0xc495121c, 0x470cc71b, 0x541d4c65, 0xbe7fa7aa, 0xb9fc1408, 0xdd5d22c3, 0xdd830d74, 0x027213b5, 0x9db09c56, 0xb19d8672, 0xee66d7f4, 0x9f88d183, 0xeaf3549c, 0x87201141, 0x82bbc5bf, 0xfa529265, 0x2fe37bac, 0x3ddf20fb, 0xcaa03489, 0xb0ab8311, 0x8e51aba9, 0x3a11096c, 0xb14bd9c3, 0xa289aa43, 0xb28a3fa4, 0x9a425b13, 0xb61f7d53, 0x6e957109};             
                                                                 
// R mod p, and R mod q, (R = 2^512)                             
uint32_t Rp[16] = {0x435f4e35, 0xdb279e69, 0xbec91f15, 0x58043515, 0x1466925e, 0xb5a31254, 0x6daa116e, 0xc7226229, 0x5cef8197, 0xb81fbced, 0xcea0fd10, 0x5ba18491, 0x818362a7, 0x9bc24af7, 0x1ce49875, 0x01b9e98d};               
uint32_t Rq[16] = {0x6cc69cdd, 0x8277548c, 0x694bb4ed, 0x4d90e972, 0xf760009d, 0x116f1a60, 0x42096640, 0xa4da92dd, 0x04078077, 0xac5f4673, 0xc65bda02, 0xd9be543e, 0x755f1776, 0x361455d7, 0x8f9b5dd6, 0x28d6380c};               
                                                                 
// R^2 mod p, and R^2 mod q, (R = 2^512)                         
uint32_t R2p[16] = {0x28734ef9, 0x01b7bd78, 0xc885cd0b, 0xc479be8c, 0xcc61678c, 0x7c3fa2e8, 0x96c8b393, 0x832832b9, 0x088a2eba, 0x87e2a89e, 0x029bc403, 0x29aba830, 0xbac7c0bd, 0x6554ed76, 0xccc74159, 0x149a089a};             
uint32_t R2q[16] = {0x72e77588, 0x71b33185, 0x2a10c349, 0xa16080bc, 0xe40ed53d, 0x43d31874, 0xbacee420, 0x806a07bf, 0xc054808f, 0x99520250, 0xd03ab28f, 0xadbe0ccc, 0x3dd91dfd, 0x9061354d, 0x75a1e9bd, 0xa1d16fd2};             
                                                                 
// R mod N, and R^2 mod N, (R = 2^1024)                          
uint32_t R_1024[32]  = {0xea13303f, 0x5a02a061, 0x8089135b, 0x561bca27, 0x547bd7c3, 0xb06602ce, 0x9358a6f8, 0xb3f37b36, 0x3f21e92d, 0xe0ca3649, 0x7c334c87, 0x80906b33, 0x9986f66a, 0x4836b3a7, 0x0a6ab210, 0xbde3c8dd, 0x22428101, 0x1ca54f44, 0x84301229, 0x966de8b5, 0x1ff191a4, 0xc7902ae7, 0xc49eb73b, 0x977a386f, 0xa9777e45, 0x676ad0bf, 0x3038f9a2, 0xcb32be6f, 0x6cf4ee83, 0x6bec27b2, 0xa34060ca, 0x2a49a351};     
uint32_t R2_1024[32] = {0xe05ad3c4, 0x4683bb50, 0x19ba868f, 0xf64a1457, 0xfa2bf0a3, 0xd3f6d012, 0xfecbf785, 0xbe21f4f8, 0x6cd05919, 0x80829172, 0xfff10f85, 0x5cff37a3, 0xb6274559, 0x84c779c1, 0x730a8b73, 0x3830c691, 0xfb08a33c, 0x07a65455, 0x65bc52dc, 0xf67f0a85, 0xbbb491da, 0xcba14cf3, 0xb6e05dd6, 0xc38cd29a, 0x4d3261f7, 0x71922d91, 0x36852af4, 0x31d74f03, 0x2d885108, 0xf583e488, 0x1a3ecd20, 0x179970de};     
                                                                 
// One                                                           
uint32_t One[32] = {1,0};                                          