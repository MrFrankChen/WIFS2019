
k = 1;
for i = 1 : 197
	Name = strcat("Dataset/HH/Test1/Test", num2str(i));
	Name = strcat(Name, ".csv");
    if (exist(Name, 'file'))


        Data = csvread(Name);
        
        S1 = Data(Data(:,30) == 0, :);
        S2 = Data(Data(:,30) == 1, :);
        
        Name = strcat("Dataset/HH/Test2/Test", num2str(i));
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

            h1 = kstest(S1(:, j));
            h2 = kstest(S3(:, j));
            H1(k, j+1) = h1;
            H2(k, j+1) = h2;
            

        end
        
        k = k + 1;
    end

end

H1(k, :) = sum(H1);
H2(k, :) = sum(H2);