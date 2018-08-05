import helpers

print "Test Vector for Montgomery Multiplication\n"

a = helpers.getRandomInt(1024)
b = helpers.getRandomInt(1024)
n = helpers.getModulus(1024)
r = 2**1024                      
n_prime = (r - Modinv(n, r))	
expected = (a*b*helpers.Modinv(r,n)) % n

print "A                = ", hex(A)         
print "B                = ", hex(B)         
print "M                = ", hex(M)        
print "(A*B*R^-1) mod M = ", hex(C)        

print "uint32_t a[32] = {" + helpers.WriteConstants(a,32) + "};"
print "uint32_t b[32] = {" + helpers.WriteConstants(b,32) + "};"   
print "uint32_t n[32] = {" + helpers.WriteConstants(n,32) + "};"
print "uint32_t n_prime[32] = {" + helpers.WriteConstants(n_prime,32) + "};" 
print "uint32_t expected_output[32] = {" + helpers.WriteConstants(expected,32) + "};" 

