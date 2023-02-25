function M = matriceM()
M = zeros(8,8);
for i = 0:7
    for j = 0:7
        if i == 0
            c = 1/sqrt(2);
        else
            c = 1;
        end
        M(i+1,j+1) = (c/2)*cos((i*(2*j+1)*pi)/16);
    end
end