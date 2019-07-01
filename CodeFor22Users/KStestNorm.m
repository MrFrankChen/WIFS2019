
M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];
 
k = 1;
for i = 1 : 89
    if (ismember(i, M))

        Name = strcat("DataSets/HH/Test1/Test", num2str(i));
        Name = strcat(Name, ".csv");
        Data = csvread(Name);
        
        S1 = Data(Data(:,30) == 0, :);
        S2 = Data(Data(:,30) == 1, :);
        
        Name = strcat("DataSets/HH/Test2/Test", num2str(i));
        Name = strcat(Name, ".csv");
        Data = csvread(Name);
        S3 = Data(Data(:,30) == 1, :);
        
        P1(k, 1) = i;
        P2(k, 1) = i;
        H1(k, 1) = i;
        H2(k, 1) = i;
        Stat1(k, 1) = i;
        Stat2(k, 1) = i;
        Dist1(k, 1) = i;
        Dist2(k, 1) = i;
        
        for j = 1 : 29
            % KS test
            
%             [h1,p1,ks2stat1] = kstest2(S1(:, j), S2(:, j)');
%             [h2,p2,ks2stat2] = kstest2(S1(:, j)', S3(:, j)');
%             P1(k, j+1) = p1;
%             P2(k, j+1) = p2;
%             H1(k, j+1) = h1;
%             H2(k, j+1) = h2;
%             Stat1(k, j+1) = ks2stat1;
%             Stat2(k, j+1) = ks2stat2;
%             
%             % JSD test
% 
%             Dist1(k, j+1) = JSDiv(S1(:, j), S2(:, j));
%             Dist2(k, j+1) = JSDiv(S1(:, j), S3(:, j));

            h1 = kstest(S1(:, j));
            h2 = kstest(S3(:, j));
            H1(k, j+1) = h1;
            H2(k, j+1) = h2;
            

        end
        
        k = k + 1;
    end
    
    
    
end