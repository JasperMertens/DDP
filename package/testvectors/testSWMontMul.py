import helpers

print "Test Vector for Montgomery Multiplication\n"

n = helpers.getModulus(1024)
a = helpers.getRandomInt(1024) % n
b = helpers.getRandomInt(1024) % n

r = 2**1024                      
n_prime = (r - helpers.Modinv(n, r))	
expected = (a*b*helpers.Modinv(r,n)) % n

#print "a                = ", hex(a)         
#print "b                = ", hex(b)         
#print "n                = ", hex(n)        
#print "(a*b*r^-1) mod n = ", hex(expected)        
print
print "uint32_t a[32] = {" + helpers.WriteConstants(a,32) + "};"
print "uint32_t b[32] = {" + helpers.WriteConstants(b,32) + "};"   
print "uint32_t N[32] = {" + helpers.WriteConstants(n,32) + "};"
print "uint32_t n_prime[32] = {" + helpers.WriteConstants(n_prime,32) + "};" 
print "uint32_t expected_output[32] = {" + helpers.WriteConstants(expected,32) + "};" 

