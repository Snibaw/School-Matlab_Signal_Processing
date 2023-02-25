function IDCT_n = TransfoInvCosinus(DCT_k,N)
    IDCT_n = zeros(N,1);
    for n = 0:N-1
        for k = 0:N-1
            if k == 0
                c = 1/sqrt(2);
            else
                c = 1;
            end
            IDCT_n(n+1) = IDCT_n(n+1) + c*DCT_k(k+1)*cos(((2*n+1)*k*pi)/(2*N));
        end
        IDCT_n(n+1) = round(IDCT_n(n+1),1);
    end
end

