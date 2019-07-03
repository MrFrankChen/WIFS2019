function [Feature, Merit] = calculateMerit(corrM, F)

[m,n] = size(corrM);
k = length(F) + 1;

Rff = 0;
Rcf = 0;
Merit = 0;

for i = 1 : length(F)
    Rcf = Rcf + corrM(F(1,i),n);
    for j = i+1 : length(F)
        Rff = Rff + corrM(F(1,i), F(1,j));
    end
end

for i = 1 : n-1
    if (~any(F == i))
        tRcf = Rcf;
        tRff = Rff;
        tRcf = tRcf + corrM(i,n);
        for j = 1 : length(F)
            tRff = tRff + corrM(F(1,j), i);
        end
        tRcf = tRcf / k;
        tRff = tRff / (k * (k - 1) / 2);
        tMerit = k * tRcf / sqrt(k + k * (k - 1) * tRff);
        if (tMerit > Merit) 
            Merit = tMerit;
            Feature = i;
        end
    end
end