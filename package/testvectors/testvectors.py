import helpers
import HW
import SW

import sys

operation = 0
seed = "random"

print "TEST VECTOR GENERATOR FOR DDP\n"

if len(sys.argv) == 2 or len(sys.argv) == 3:
  if str(sys.argv[1]) == "adder":           operation = 1;
  if str(sys.argv[1]) == "subtractor":      operation = 2;
  if str(sys.argv[1]) == "multiplication":  operation = 3;
  if str(sys.argv[1]) == "exponentiation":  operation = 4;
  if str(sys.argv[1]) == "crtrsa":          operation = 5;
  if str(sys.argv[1]) == "debug_exp":       operation = 6;
  

if len(sys.argv) == 3:
  print "Seed is: ", sys.argv[2], "\n"
  seed = sys.argv[2]
  helpers.setSeed(sys.argv[2])

#####################################################

if operation == 0:
  print "You should use this script by passing an argument like:"
  print " $ python testvectors.py adder"
  print " $ python testvectors.py subractor"
  print " $ python testvectors.py multiplication"
  print " $ python testvectors.py exponentiation"
  print " $ python testvectors.py crtrsa"
  print ""
  print "You can also set a seed for randomness to work"
  print "with the same testvectors at each execution:"
  print " $ python testvectors.py crtrsa 2017"
  print ""

#####################################################

if operation == 1:
  print "Test Vector for Multi Precision Adder\n"

  A = helpers.getRandomInt(514)
  B = helpers.getRandomInt(514)
  C = HW.MultiPrecisionAdd(A,B,"add")

  print "A                = ", hex(A)           # 514-bits
  print "B                = ", hex(B)           # 514-bits
  print "A + B            = ", hex(C)           # 515-bits

#####################################################

if operation == 2:
  print "Test Vector for Multi Precision Subtractor\n"

  A = helpers.getRandomInt(514)
  B = helpers.getRandomInt(514)
  C = HW.MultiPrecisionAdd(A,B,"subtract")

  print "A                = ", hex(A)           # 514-bits
  print "B                = ", hex(B)           # 514-bits
  print "A - B            = ", hex(C)           # 515-bits

#####################################################

if operation == 3:
  print "Test Vector for Montgomery Multiplication\n"

  A = helpers.getRandomInt(512)
  B = helpers.getRandomInt(512)
  M = helpers.getModulus(512)
  C = HW.MontMul_512(A, B, M)
  D = (A*B*helpers.Modinv(2**512,M)) % M
  e = C - D
  
  print "A                = ", hex(A)         # 512-bits
  print "B                = ", hex(B)         # 512-bits
  print "M                = ", hex(M)         # 512-bits
  print "(A*B*R^-1) mod M = ", hex(C)         # 512-bits
  print "(A*B*R^-1) mod M = ", hex(D)         # 512-bits
  print "error            = ", hex(e)    

  print "uint32_t A[16] = {" + helpers.WriteConstants(A,16) + "};"
  print "uint32_t B[16] = {" + helpers.WriteConstants(B,16) + "};"   
  print "uint32_t M[16] = {" + helpers.WriteConstants(M,16) + "};" 
  print "uint32_t EXPECTED[16] = {" + helpers.WriteConstants(C,16) + "};" 

#####################################################
if operation == 6:
  print "Debug Montgomery Exponentiation\n"


 # Generate two primes (p,q), and modulus
  [p,q,N] = helpers.getModuli(512)

 # Generate Exponents
  [e,d] = helpers.getRandomExponents(p,q) 

  print "Enc exp      = ", hex(e)               # 16-bits
  print "Dec exp      = ", hex(d)               # 1024-bits

 # Generate Message
  M     = helpers.getRandomMessage(1024,N)

  print "Message      = ", hex(M)               # 512-bits


  print "p            = ", hex(p)               # 512-bits
  print "q            = ", hex(q)               # 512-bits
  print "Modulus      = ", hex(N)               # 1024-bits

  R       = 2**1024
  R_1024  = R % N
  R2_1024 = (R*R) % N

  print "R_1024       = ", hex(R_1024)          # 1024-bits
  print "R2_1024      = ", hex(R2_1024)         # 1024-bits

  C = SW.MontMul_1024(M, R2_1024, N)
  print "X_tilde     = ", hex(C)               # 1024-bitszz


#####################################################

if operation == 4:

  print "Test Vector for Montgomery Exponentiation\n"

  X = helpers.getRandomInt(512)
  E = helpers.getRandomInt(8)
  M = helpers.getModulus(512)
  C = HW.MontExp_512(X, E, M)
  D = helpers.Modexp(X, E, M)
  e = C - D

  print "X                = ", hex(X)           # 512-bits
  print "E                = ", hex(E)           # 8-bits
  print "M                = ", hex(M)           # 512-bits
  print "(X^E) mod M      = ", hex(C)           # 512-bits
  print "(X^E) mod M      = ", hex(D)           # 512-bits
  print "error            = ", hex(e)   


  print "uint32_t X[16] = {" + helpers.WriteConstants(X,16) + "};"
  print "uint32_t E[16] = {" + helpers.WriteConstants(E,16) + "};"   
  print "uint32_t M[16] = {" + helpers.WriteConstants(M,16) + "};" 
  print "uint32_t EXPECTED[16] = {" + helpers.WriteConstants(C,16) + "};"       

#####################################################

if operation == 5:

  print "Test Vector for RSA\n"

  print "\n--- Precomputed Values"

  # Generate two primes (p,q), and modulus
  [p,q,N] = helpers.getModuli(512)

  print "p            = ", hex(p)               # 512-bits
  print "q            = ", hex(q)               # 512-bits
  print "Modulus      = ", hex(N)               # 1024-bits

  # Generate Exponents
  [e,d] = helpers.getRandomExponents(p,q) 

  print "Enc exp      = ", hex(e)               # 16-bits
  print "Dec exp      = ", hex(d)               # 1024-bits

  # Generate Message
  M     = helpers.getRandomMessage(1024,N)

  print "Message      = ", hex(M)               # 512-bits

  # For CRT RSA
  x_p   = q * helpers.Modinv(q, p)              
  x_q   = p * helpers.Modinv(p, q)              

  print "x_p          = ", hex(x_p)             # 1024-bits
  print "x_q          = ", hex(x_q)             # 1024-bits

  # Since decryption exponent is 1024-bits large, 
  # the exponentiation will take a long time to execute. 
  # Therefore, the exponenet can be reduced to 512-bits
  # for optimizing the operation.
  # Following, condition is provided for this reduction:

  d_p = d % (p-1)                               
  d_q = d % (q-1)                               

  print "d_p          = ", hex(d_p)             # 512-bits
  print "d_q          = ", hex(d_q)             # 512-bits

  R       = 2**512
  Rp      = R % p
  Rq      = R % q
  R2p     = (R*R) % p
  R2q     = (R*R) % q
  R       = 2**1024
  R_1024  = R % N
  R2_1024 = (R*R) % N

  print "R_p          = ", hex(Rp)              # 512-bits
  print "R_q          = ", hex(Rq)              # 512-bits
  print "R2_p         = ", hex(R2p)             # 512-bits
  print "R2_q         = ", hex(R2q)             # 512-bits
  print "R_1024       = ", hex(R_1024)          # 1024-bits
  print "R2_1024      = ", hex(R2_1024)         # 1024-bits

  helpers.CreateConstants(M, p, q, N, e, d_p, d_q, x_p, x_q, Rp, Rq, R2p, R2q, R_1024, R2_1024, seed);
    
  #####################################################

  print "\n--- Execute RSA (For verification)"

  # Encrypt
  Ct1 = SW.MontExp_1024(M, e, N)                # 1024-bit exponentiation
  print "Ciphertext   = ", hex(Ct1)             # 512-bits

  # Decrypt
  Pt1 = SW.MontExp_1024(Ct1, d, N)              # 1024-bit exponentiation
  print "Plaintext    = ", hex(Pt1)             # 512-bits

  #####################################################

  print "\n--- Execute CRT RSA"

  #### Encrypt
  
  # Exponentiation, in Software
  Ct2 = SW.MontExp_1024(M, e, N)                # 1024-bit SW montgomery exp. 
  
  print "Ciphertext   = ", hex(Ct2)             # 1024-bits
  print "uint32_t Ciphertext[32] = {" + helpers.WriteConstants(Ct2,32) + "};"

  #### Decrypt

  # Reduction
  #
  # Here we reduce the ciphertext with p and q:
  #   Cp = Ciphertext mod p
  #   Cq = Ciphertext mod q
  #  
  # For this reduction, we divide the 1024-bit C
  # into two 512-bit blocks Ch and Cl such as:
  #   C = Ch * 2^512 + Cl
  #     = Ch * R     + Cl
  # 
  # Now we will reduce by using the formula:
  #   Cp = C mod p
  #      = (Ch * R + Cl)  mod p
  #      = (Ch * R^2 / R + Cl) mod p
  #      = (MontMul(Ch,R^2,p) + Cl) mod p
        
        # For verification, ignore these lines 
        # C_p = Ct2 % p;                        # 512-bits
        # C_q = Ct2 % q;                        # 512-bits        
        # print "Ciphertext_p = ", hex(C_p)     # 512-bits
        # print "Ciphertext_q = ", hex(C_q)     # 512-bits
  
  Ct2h = Ct2 >> 512;                            # 512-bits
  Ct2l = Ct2 % (2**512);                        # 512-bits

  tp   = HW.MontMul_512(Ct2h, R2p, p)           # 512-bits HW montgomery mult.
  #print "uint32_t Ct2h[16] = {" + helpers.WriteConstants(Ct2h,16) + "};"
  #print "uint32_t R2p[16] = {" + helpers.WriteConstants(R2p,16) + "};"
  #print "uint32_t p[16] = {" + helpers.WriteConstants(p,16) + "};"
  #print "uint32_t tp[16] = {" + helpers.WriteConstants(tp,16) + "};"
  tq   = HW.MontMul_512(Ct2h, R2q, q)           # 512-bits HW montgomery mult.

  Ct_p = (tp + Ct2l) % p                        # 512-bits HW/SW modular add.
  #print "uint32_t C_tp[16] = {" + helpers.WriteConstants(Ct_p,16) + "};"
  #print "uint32_t Ct2l[16] = {" + helpers.WriteConstants(Ct2l,16) + "};"
  Ct_q = (tq + Ct2l) % q                        # 512-bits HW/SW modular add.

  print "Ciphertext_p = ", hex(Ct_p)            # 512-bits
  print "Ciphertext_q = ", hex(Ct_q)            # 512-bits

  # Exponentiation, in Hardware
  
        # Below two lines implement the exponentiation following
        # the algorithm that students will use in the lab sessions
        # However, as it will run so slow in python, they are commented here
        # If need to debug, by observing the intermediate values,
        # then can be uncommented.

  #P_p = HW.MontExp_512(Ct_p, d_p, p)           # 512-bit HW modular exp.
  #P_q = HW.MontExp_512(Ct_q, d_q, q)           # 512-bit HW modular exp.
 

  P_p = helpers.Modexp(Ct_p, d_p, p)            # 512-bit HW modular exp.
  P_q = helpers.Modexp(Ct_q, d_q, q)            # 512-bit HW modular exp.

  #x_tilde   = HW.MontMul_512(Ct_p, R2p, p)           # 512-bits HW montgomery mult.
  #A = HW.MontMul_512(Rp, Rp, p) 


  #t = helpers.bitlen(d_p)
  #for i in range(0,t):
   # A = HW.MontMul_512(A,A,p)
    #if helpers.bit(d_p,t-i-1) == 1:
     # A = HW.MontMul_512(A,x_tilde,p)
  #Ai2 = HW.MontMul_512(A,1,p)

  #Ai1 = HW.MontMul_512(A, x_tilde, p)

  #print "uint32_t P_p[16] = {" + helpers.WriteConstants(P_p,16) + "};"
  #print "uint32_t x_tilde[16] = {" + helpers.WriteConstants(x_tilde,16) + "};"
  #print "uint32_t A[16] = {" + helpers.WriteConstants(A,16) + "};"
  #print "uint32_t Ai1 = {" + helpers.WriteConstants(Ai1,16) + "};"

  #print "uint32_t Ct_p[16] = {" + helpers.WriteConstants(Ct_p,16) + "};"
  #print "uint32_t d_p[16] = {" + helpers.WriteConstants(d_p,16) + "};"
  #print "uint32_t p[16] = {" + helpers.WriteConstants(p,16) + "};"
  
  # Inverse CRT, in Software
  #
  # We need to execute the following operation to combine the 
  # two 512-bit partial plaintext results P_p and P_q for calculating
  # the final 1024-bit plaintext:
  # 
  #   Plaintext = (P_p*x_p + P_q*x_q) mod N;
  #               (512-bits * 1024-bits) + (512-bits * 1024-bits)
  #
  # To simplify this calculation we will use the following formula
  # with a 1024-bit montgomery multiplication function, implemented
  # in software
  #
  #   Plaintext =  (P_p*x_p + P_q*x_q) mod N;
  #             = ((P_p*x_p/R + P_q*x_q/R) * R^2 / R) mod N;
  #             = ((MontMul(P_p,x_p,N) + MontMul(P_q,x_q,N)) * R^2 / R) mod N
  #             =  MontMul((MontMul(P_p,x_p,N) + MontMul(P_q,x_q,N)), R^2, N) mod N

        # For verification, ignore these lines 
        # Pt2 = (P_p*x_p + P_q*x_q) mod N;
        # print "Plaintext_p  = ", hex(P_p)     # 512-bits
        # print "Plaintext_q  = ", hex(P_q)     # 512-bits
        # print "Pt2          = ", hex(Pt2)     # (512-bits * 1024-bits) + (512-bits * 1024-bits)

  tp      = SW.MontMul_1024(P_p,x_p,N);         # 1024-bit SW montgomery mult.
  tq      = SW.MontMul_1024(P_q,x_q,N);         # 1024-bit SW montgomery mult.
  s       = (tp + tq) % N                       # 1024-bit SW addition
  Pt3     = SW.MontMul_1024(s , R2_1024, N);    # 1024-bit SW montgomery mult.

  print "Plaintext    = ", hex(Pt3)             # 1024-bits
  print "uint32_t Plaintext[32] = {" + helpers.WriteConstants(Pt3,32) + "};"

  print "\n\ntestvector.c file is created in this directory."
