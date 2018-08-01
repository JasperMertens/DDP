import helpers

def MultiPrecisionAdd(A, B, addsub):
    # returns (A + B) if   addsub == "add"
    #         (A - B) else
    mask = 2**514 - 1
    if addsub == "add":
        r = (A + B) & mask
    else:
        r = (A - B) & mask
    return r

def MontMul(A, B, M):
    # Returns (A*B*Modinv(R,M)) mod M
    C = 0
    for i in range(0,512):
        C = MultiPrecisionAdd(C, helpers.bit(A,i)*B, "add")
        if (C % 2) == 0:
            C = C / 2;
        else:
            C = MultiPrecisionAdd(C, M, "add") / 2;
    while C >= M:
        C = MultiPrecisionAdd(C, M, "sub")
    return C

def MontExp(X, E, M):
    # Returns (X^E) mod M
    R  = 2**512
    R2 = (R*R) % M;
    A  = R % M;
    X_tilde = MontMul(X,R2,M)
    t = helpers.bitlen(E)
    for i in range(0,t):
        A = MontMul(A,A,M)
        if helpers.bit(E,t-i-1) == 1:
            A = MontMul(A,X_tilde,M)
    A = MontMul(A,1,M)
    return A
