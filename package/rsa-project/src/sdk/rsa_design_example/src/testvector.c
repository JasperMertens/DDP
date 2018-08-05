#include <stdint.h>                                              
                                                                 
// This file's content is created by the testvector generator    
// python script for seed = 2017.10                    
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
uint32_t M[32] = {0x9fd8c8ee, 0x5aea7227, 0x6c431388, 0x5b6a6bfe, 0xa8646658, 0x57ec94d3, 0xf6c72e7e, 0x56e854ed, 0x51f34b66, 0xff5f044b, 0x3a898bb2, 0xe62aa956, 0xec1ae264, 0xd2bff9a2, 0x63caf82e, 0x963e77e8, 0x2d381847, 0x9f23a068, 0x3c89cc91, 0x0f72506e, 0x2138917b, 0x71f4fadb, 0x0f86545a, 0x15dab437, 0xf58acf6f, 0xf7307812, 0x1e77a5d0, 0x066885c7, 0xcb8ec1ba, 0xd0c7a119, 0x7ec147d0, 0x93d059ed};                 
                                                                 
// prime p and q                                                 
uint32_t p[16] = {0x59bd5fb1, 0x75621f29, 0x0712fe9f, 0x578c4e4e, 0x693a53e0, 0x4b87e5f0, 0x17297c47, 0xd96f11e6, 0x5f2697c4, 0x8f58f703, 0x30194dcf, 0xb06e105d, 0x5132205e, 0xbfe895f8, 0x1ab634eb, 0xe06b77b4};                 
uint32_t q[16] = {0xaa012ca3, 0x02f6b71f, 0x7c5ae28d, 0xa3f2677d, 0xf6ccf2b6, 0x859109ea, 0x32784984, 0x98719a56, 0x0217848c, 0x9a135231, 0x8787ffb0, 0x4475a05d, 0x6e4d5c93, 0xa04c765f, 0xfccd2e35, 0xafeb244d};                 
                                                                 
// modulus                                                       
uint32_t N[32]       = {0x99b759b3, 0xc3022b78, 0x43082826, 0xc41b2e29, 0x3d8c1b4e, 0x22bbab12, 0x0968266e, 0xb87b5957, 0x1a591d6d, 0xb2180ec7, 0xd68230df, 0xe385f34c, 0xfb432b87, 0x5fdf63e0, 0x4da8331d, 0xc4b6b75c, 0xa652a6c0, 0x40f9302e, 0x0fdf8d6c, 0x9e9259a2, 0x194ad5bb, 0x99d36ac5, 0x612d4ede, 0x59a09529, 0x76f62f1e, 0x73f23534, 0x1a84b096, 0x095d5f4c, 0xdb5704a6, 0xdca5527f, 0x7b5d10c3, 0x9a37994e};           
uint32_t N_prime[32] = {0xdb490285, 0xdbaebd60, 0xf9d5502d, 0x225245b3, 0x724207f2, 0x621ef8be, 0x684d33d1, 0xa147d4a0, 0xf9e7080d, 0x855dff88, 0x9da39cd4, 0xb06828e8, 0x8b9a8af6, 0x479813f8, 0x4eb49113, 0x0b122d5a, 0xf6a44260, 0xfee7d842, 0x9733f288, 0xf82c001e, 0x72008e14, 0x2bbfa8ad, 0xe8c268dd, 0xff4a03f0, 0x11b8e7f5, 0x884fe6cf, 0x0527e4bd, 0x8d37678c, 0x2a4dda10, 0x653216b3, 0xb9311379, 0xeb577409};     
                                                                 
// encryption exponent                                           
uint32_t e[32] = {0x0000e1fd};                  
uint32_t e_len = 16;                                             
                                                                 
// decryption exponent, reduced to p and q                       
uint32_t d_p[16] = {0xd1413515, 0x7cb546f3, 0xc7f20d91, 0x842f7061, 0xeddf2b37, 0x2bc71706, 0x62aba60c, 0x83369443, 0xfa74259e, 0x05bb7feb, 0xe48c8749, 0xfee84dd0, 0x2620bf5d, 0x06e110ce, 0x62a9b681, 0xa719073e};             
uint32_t d_q[16] = {0x05b95ce1, 0x961f300f, 0x85ec20de, 0x6b1db6f7, 0xa505043a, 0x2d169fb8, 0xf2f441c0, 0x4cec004c, 0x3eb6417a, 0xa11e1e04, 0x57e854e7, 0xb9efca36, 0x01c27db1, 0x66051ce3, 0x1b954ba2, 0x83cb2f91};             
uint32_t d_p_len =  512;
uint32_t d_q_len =  512;
                                                                 
// x_p and x_q                                                   
uint32_t x_p[32] = {0xed40fd5f, 0x2027955b, 0xb300f88b, 0x5ccbd3b1, 0x85f63ccd, 0x5b9a52a3, 0xc864d828, 0x3ede99ce, 0x19093e78, 0x1213a009, 0x64e31994, 0x94d27d62, 0x5f935943, 0xc2f28f8f, 0xea97143e, 0xfc23550e, 0xc15384f8, 0xeb0f5cf9, 0x6ed74766, 0xd63fbf2a, 0x13da0a64, 0x7e77b43f, 0x2ddb0f5d, 0xfd9964e7, 0x4041a4c3, 0x6d72a7fd, 0x38be164b, 0xd49924b1, 0x0addeb7a, 0xae47a156, 0xf44dffad, 0x826a8d95};             
uint32_t x_q[32] = {0xac765c55, 0xa2da961c, 0x90072f9b, 0x674f5a77, 0xb795de81, 0xc721586e, 0x41034e45, 0x799cbf88, 0x014fdef5, 0xa0046ebe, 0x719f174b, 0x4eb375ea, 0x9bafd244, 0x9cecd451, 0x63111ede, 0xc893624d, 0xe4ff21c7, 0x55e9d334, 0xa1084605, 0xc8529a77, 0x0570cb56, 0x1b5bb686, 0x33523f81, 0x5c073042, 0x36b48a5a, 0x067f8d37, 0xe1c69a4b, 0x34c43a9a, 0xd079192b, 0x2e5db129, 0x870f1116, 0x17cd0bb8};             
                                                                 
// R mod p, and R mod q, (R = 2^512)                             
uint32_t Rp[16] = {0xa642a04f, 0x8a9de0d6, 0xf8ed0160, 0xa873b1b1, 0x96c5ac1f, 0xb4781a0f, 0xe8d683b8, 0x2690ee19, 0xa0d9683b, 0x70a708fc, 0xcfe6b230, 0x4f91efa2, 0xaecddfa1, 0x40176a07, 0xe549cb14, 0x1f94884b};               
uint32_t Rq[16] = {0x55fed35d, 0xfd0948e0, 0x83a51d72, 0x5c0d9882, 0x09330d49, 0x7a6ef615, 0xcd87b67b, 0x678e65a9, 0xfde87b73, 0x65ecadce, 0x7878004f, 0xbb8a5fa2, 0x91b2a36c, 0x5fb389a0, 0x0332d1ca, 0x5014dbb2};               
                                                                 
// R^2 mod p, and R^2 mod q, (R = 2^512)                         
uint32_t R2p[16] = {0xd557f829, 0x31537b2d, 0x66ef0252, 0x50c1dcb0, 0x4a3f9783, 0xe5a47943, 0x4f32c19f, 0xcbf1a63e, 0x5421c66f, 0xfb05b4c5, 0x62e32a6a, 0x0a193564, 0xffff3dd6, 0x9add931c, 0x7b172719, 0xaca1d696};             
uint32_t R2q[16] = {0xe9bb9201, 0x90f7af56, 0xac3fb43a, 0x114742e2, 0xacb60d29, 0x5a1b66af, 0xf4c9cf9b, 0x259f05ef, 0xce845f63, 0xd0d72063, 0x4e1eabfb, 0x744d8c1c, 0xf8d8d5b6, 0x196fd1fe, 0xab858e88, 0x8e60c98d};             
                                                                 
// R mod N, and R^2 mod N, (R = 2^1024)                          
uint32_t R_1024[32]  = {0x6648a64d, 0x3cfdd487, 0xbcf7d7d9, 0x3be4d1d6, 0xc273e4b1, 0xdd4454ed, 0xf697d991, 0x4784a6a8, 0xe5a6e292, 0x4de7f138, 0x297dcf20, 0x1c7a0cb3, 0x04bcd478, 0xa0209c1f, 0xb257cce2, 0x3b4948a3, 0x59ad593f, 0xbf06cfd1, 0xf0207293, 0x616da65d, 0xe6b52a44, 0x662c953a, 0x9ed2b121, 0xa65f6ad6, 0x8909d0e1, 0x8c0dcacb, 0xe57b4f69, 0xf6a2a0b3, 0x24a8fb59, 0x235aad80, 0x84a2ef3c, 0x65c866b1};     
uint32_t R2_1024[32] = {0xfa363120, 0x83fee6fc, 0xed0e239a, 0x664301f9, 0x50f16722, 0x7f1260a9, 0xa82f3d13, 0x3d46bdf8, 0xb0172b75, 0xad5606ca, 0x53a6aadc, 0xd4d2c4ad, 0x491af2de, 0xb9e6f90f, 0x88aa5559, 0x9f34ea26, 0x5bf82d53, 0x04ff1656, 0x87572d8c, 0xa2d085a0, 0xbbe2db16, 0xf61c72cf, 0x4db2f414, 0x269bebfc, 0x77ec7291, 0x6dd6f19f, 0xc325899f, 0x3405dcc9, 0xdd4829e6, 0x5048abbe, 0x137ed36a, 0x71a43342};     
                                                                 
// One                                                           
uint32_t One[32] = {1,0};                                        
                                                                 
///////////////// FOR VERIFICATION //////////////////            
                                                                 
// Ciphertext, input of hardware decryption                      
uint32_t Ciphertext[32]  = {0xeac58818, 0x98f0a451, 0x75ef10f7, 0xed55a032, 0x56463c29, 0x8a81deab, 0x897d4f88, 0xd821f828, 0x4c3b8478, 0x7cd3d6a9, 0xa4ec10c0, 0xfd1c4971, 0xe42dc400, 0x0b71ba62, 0x394e6d35, 0xe713c05d, 0xcf51436b, 0x95f5d032, 0xf9068396, 0x17532959, 0x251fb545, 0xd5899a1c, 0xabc62aef, 0xc40886da, 0x9706679e, 0xa07fdf05, 0x2c3cda00, 0x70b15cff, 0xe6c334bd, 0x0d484b82, 0x3abeae75, 0x347152cd};     
                                                                 
// Ciphertext_p and Ciphertext_q, output of reduction            
uint32_t Ciphertext_p[16]  = {0xd647d50e, 0xe3da3bdd, 0x9a9072b1, 0xfcf885ff, 0x3145aa56, 0x7ebb071c, 0x8eb838bd, 0xf50af29e, 0x7868859f, 0x0ef3e97c, 0x4b8ea02e, 0xf570ef0b, 0x577fb52e, 0x64006906, 0x6572dff6, 0x4c9b5551};  
uint32_t Ciphertext_q[16] = {0x8de09b8d, 0x4f36bc2e, 0xb50c62c4, 0xbbdc65d8, 0x241846ae, 0x0e0410ee, 0xce633abf, 0x68765c82, 0x11f903fa, 0xd94998cf, 0xbea48c03, 0x2211f5b4, 0xf46ba13f, 0x66d3b9dd, 0x04d592f3, 0x26fb854c};   
                                                                 
// Plaintext_p and Plaintext_q, output of exponentiation         
// (needs to be allocate space for 32 words to combine correctly)
uint32_t Plaintext_p[32]  = {0xaee1ee8a, 0x0430ee56, 0x001ab675, 0xf9eba85b, 0xc9e0884c, 0xacfa74c6, 0xf4529181, 0xbd1d5b70, 0x0e33065f, 0xca4831b9, 0x751f0e57, 0x4586f25b, 0x16955a66, 0x986cec83, 0x859be955, 0x18085711};    
uint32_t Plaintext_q[32] = {0xee2e0444, 0x5c604b61, 0x048e6616, 0xc5676a78, 0x3be2dbb9, 0x5dd21efc, 0x5918dfd4, 0xa6f91ba4, 0x77e607e7, 0x5e51bf7d, 0xa1fb588d, 0x250a537c, 0xdee32361, 0x6fd91dae, 0x5e9d96d0, 0x1d352c18};     
                                                                 
// Plaintext, output of hardware decryption                      
uint32_t Plaintext[32]  = {0x9fd8c8ee, 0x5aea7227, 0x6c431388, 0x5b6a6bfe, 0xa8646658, 0x57ec94d3, 0xf6c72e7e, 0x56e854ed, 0x51f34b66, 0xff5f044b, 0x3a898bb2, 0xe62aa956, 0xec1ae264, 0xd2bff9a2, 0x63caf82e, 0x963e77e8, 0x2d381847, 0x9f23a068, 0x3c89cc91, 0x0f72506e, 0x2138917b, 0x71f4fadb, 0x0f86545a, 0x15dab437, 0xf58acf6f, 0xf7307812, 0x1e77a5d0, 0x066885c7, 0xcb8ec1ba, 0xd0c7a119, 0x7ec147d0, 0x93d059ed};        