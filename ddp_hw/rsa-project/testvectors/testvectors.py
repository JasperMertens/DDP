import helpers
import montgomery

import sys

operation = 0

print "TEST VECTOR GENERATOR FOR DDP\n"

if len(sys.argv) == 2:
  if str(sys.argv[1]) == "adder":           operation = 1;
  if str(sys.argv[1]) == "subtractor":      operation = 2;
  if str(sys.argv[1]) == "multiplication":  operation = 3;
  if str(sys.argv[1]) == "exponentiation":  operation = 4;
  if str(sys.argv[1]) == "crtrsa":          operation = 5;


#####################################################

if operation == 0:
  print "You should use this script by passing an argument like:"
  print " $ python testvectors.py adder"
  print " $ python testvectors.py subractor"
  print " $ python testvectors.py multiplication"
  print " $ python testvectors.py exponentiation"
  print " $ python testvectors.py crtrsa"

#####################################################

if operation == 1:
  print "Test Vector for Multi Precision Adder\n"

  A = helpers.getRandomInt(513)
  B = helpers.getRandomInt(513)
  C = montgomery.MultiPrecisionAdd(A,B,"add")

  print "A                = ", hex(A)    # 513-bits
  print "B                = ", hex(B)    # 513-bits
  print "A + B            = ", hex(C)    # 514-bits

#####################################################

if operation == 2:
  print "Test Vector for Multi Precision Subtractor\n"

  A = helpers.getRandomInt(513)
  B = helpers.getRandomInt(513)
  C = montgomery.MultiPrecisionAdd(A,B,"subtract")

  print "A                = ", hex(A)    # 513-bits
  print "B                = ", hex(B)    # 513-bits
  print "A + B            = ", hex(C)    # 514-bits

#####################################################

if operation == 3:
  print "Test Vector for Montgomery Multiplication\n"

  C = 1
  D = 1
  while (C == D):
    A = helpers.getRandomInt(512)
    B = helpers.getRandomInt(512)
    M = helpers.getModulus(512)
    C = montgomery.MontMul(A, B, M)
    D = (A * B * helpers.Modinv(2**512,M)) % M

    print "A                = ", hex(A)    # 512-bits
    print "B                = ", hex(B)    # 512-bits
    print "M                = ", hex(M)    # 512-bits
    print "(A*B*R^-1) mod M = ", hex(C)    # 512-bits
    print "(A*B*R^-1) mod M = ", hex(D)    # 512-bits

#####################################################

if operation == 4:

  print "Test Vector for Montgomery Exponentiation\n"

  X = helpers.getRandomInt(512)
  E = helpers.getRandomInt(8)
  M = helpers.getModulus(512)
  C = montgomery.MontExp(X, E, M)
  D = helpers.Modexp(X, E, M)

  print "X                = ", hex(X)    # 512-bits
  print "E                = ", hex(E)    # 8-bits
  print "M                = ", hex(M)    # 512-bits
  print "(X^E) mod M      = ", hex(C)    # 512-bits
  print "(X^E) mod M      = ", hex(D)    # 512-bits

#####################################################

if operation == 5:

  print "Test Vector for RSA\n"

  print "\n--- Precomputed Values"

  # Generate two primes (p,q), and modulus
  p     = helpers.getRandomPrime(512)        
  q     = helpers.getRandomPrime(512)        
  N     = p*q                

  print "p            = ", hex(p)      # 512-bits
  print "q            = ", hex(q)      # 512-bits
  print "Modulus      = ", hex(N)      # 1024-bits

  # Generate Exponents
  [e,d] = helpers.getRandomExponents(p,q) 

  print "Enc exp      = ", hex(e)      # 16-bits
  print "Dec exp      = ", hex(d)      # 1024-bits

  # Generate Message
  M     = helpers.getRandomMessageForCRT(p,q)

  print "Message      = ", hex(M)      # 512-bits

  # For CRT RSA
  x_p   = q * helpers.Modinv(q, p)              
  x_q   = p * helpers.Modinv(p, q)              

  print "x_p          = ", hex(x_p)    # 1024-bits
  print "x_q          = ", hex(x_q)    # 1024-bits

  #####################################################

  print "\n--- Execute RSA (For verification)"

  # Encrypt
  Ct1 = helpers.Modexp(M, e, N)        # 1024-bit exponentiation
  print "Ciphertext   = ", hex(Ct1)    # 512-bits

  # Decrypt
  Pt1 = helpers.Modexp(Ct1, d, N)      # 1024-bit exponentiation
  print "Plaintext    = ", hex(Pt1)    # 512-bits

  #####################################################

  print "\n--- Execute CRT RSA"

  #### Encrypt
  
  # Exponentiation, in Software
  Ct2 = helpers.Modexp(M, e, N)        # 1024-bit exponentiation
  
  print "Ciphertext   = ", hex(Ct2)    # 1024-bits

  #### Decrypt

  # (Optional) Reduction of the decryption exponents, in Software
  reduce = 1
  if not reduce:
    d_p = d                            # 1024-bits
    d_q = d                            # 1024-bits
  else:
    d_p = d % (p-1)                    # 512-bits
    d_q = d % (q-1)                    # 512-bits

  # Reduction, in Software
  C_p = Ct2 % p;                       # 512-bits
  C_q = Ct2 % q;                       # 512-bits

  # Exponentiation, in Hardware
  
  P_p = montgomery.MontExp(C_p, d_p, p)    # 512-bit exponentiation
  P_q = montgomery.MontExp(C_q, d_q, q)    # 512-bit exponentiation
  # P_p = helpers.Modexp(C_p, d_p, p)    # 512-bit exponentiation
  # P_q = helpers.Modexp(C_q, d_q, q)    # 512-bit exponentiation
  
  # Inverse CRT, in Software
  Pt2 = (P_p*x_p + P_q*x_q) % N;       # (512-bits * 1024-bits) + (512-bits * 1024-bits)

  print "Ciphertext_p = ", hex(P_p)    # 512-bits
  print "Ciphertext_q = ", hex(P_q)    # 512-bits
  print "Plaintext_p  = ", hex(P_p)    # 512-bits
  print "Plaintext_q  = ", hex(P_q)    # 512-bits
  print "Pt2          = ", hex(Pt2)    # (512-bits * 1024-bits) + (512-bits * 1024-bits)