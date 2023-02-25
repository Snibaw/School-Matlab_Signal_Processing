function DCT_k = TransfoCosinus(f_n,N)
    DCT_k = zeros(N,1);
    for k = 0:N-1
        if k == 0
            c = 1/sqrt(2);
        else
            c = 1;
        end
        for n = 0:N-1
            DCT_k(k+1) = DCT_k(k+1) + (2*c/N)*f_n(n+1)*cos(((2*n+1)*k*pi)/(2*N));
        end
        DCT_k(k+1) = round(DCT_k(k+1),1);
    end
end

