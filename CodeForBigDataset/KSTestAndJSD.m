%% Portrait

clc; clear;

k = 1;
for i = 1 : 138
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
            % KS test
            
            [h1,p1,ks2stat1] = kstest2(S1(:, j), S2(:, j)');
            [h2,p2,ks2stat2] = kstest2(S1(:, j)', S3(:, j)');
            P1(k, j+1) = p1;
            P2(k, j+1) = p2;
            H1(k, j+1) = h1;
            H2(k, j+1) = h2;
            Stat1(k, j+1) = ks2stat1;
            Stat2(k, j+1) = ks2stat2;
            
            % JSD test

            Dist1(k, j+1) = JSDiv(S1(:, j), S2(:, j));
            Dist2(k, j+1) = JSDiv(S1(:, j), S3(:, j));

        end
        
        k = k + 1;
    end

end

F = (0:1:29);
H1(k, :) = sum(H1); H1 = [F;H1];
H2(k, :) = sum(H2); H2 = [F;H2];
P1(k, :) = sum(P1) / (k-1); P1 = [F;P1];
P2(k, :) = sum(P2) / (k-1); P2 = [F;P2];
Stat1(k, :) = sum(Stat1) / (k-1); Stat1 = [F;Stat1];
Stat2(k, :) = sum(Stat2) / (k-1); Stat2 = [F;Stat2];
Dist1(k, :) = sum(Dist1) / (k-1); Dist1 = [F;Dist1];
Dist2(k, :) = sum(Dist2) / (k-1); Dist2 = [F;Dist2];

csvwrite("TestResult/PortraitKSResultHH.csv", H1);
csvwrite("TestResult/PortraitKSPvalueHH.csv", P1);
csvwrite("TestResult/PortraitKSStatHH.csv", Stat1);
csvwrite("TestResult/PortraitJSDHH.csv", Dist1);

csvwrite("TestResult/PortraitKSResultHG.csv", H2);
csvwrite("TestResult/PortraitKSPvalueHG.csv", P2);
csvwrite("TestResult/PortraitKSStatHG.csv", Stat2);
csvwrite("TestResult/PortraitJSDHG.csv", Dist2);




% Landscape

clc; clear;

k = 1;
for i = 139 : 197
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
            % KS test
            
            [h1,p1,ks2stat1] = kstest2(S1(:, j), S2(:, j)');
            [h2,p2,ks2stat2] = kstest2(S1(:, j)', S3(:, j)');
            P1(k, j+1) = p1;
            P2(k, j+1) = p2;
            H1(k, j+1) = h1;
            H2(k, j+1) = h2;
            Stat1(k, j+1) = ks2stat1;
            Stat2(k, j+1) = ks2stat2;
            
            % JSD test

            Dist1(k, j+1) = JSDiv(S1(:, j), S2(:, j));
            Dist2(k, j+1) = JSDiv(S1(:, j), S3(:, j));

        end
        
        k = k + 1;
    end

end

F = (0:1:29);
H1(k, :) = sum(H1); H1 = [F;H1];
H2(k, :) = sum(H2); H2 = [F;H2];
P1(k, :) = sum(P1) / (k-1); P1 = [F;P1];
P2(k, :) = sum(P2) / (k-1); P2 = [F;P2];
Stat1(k, :) = sum(Stat1) / (k-1); Stat1 = [F;Stat1];
Stat2(k, :) = sum(Stat2) / (k-1); Stat2 = [F;Stat2];
Dist1(k, :) = sum(Dist1) / (k-1); Dist1 = [F;Dist1];
Dist2(k, :) = sum(Dist2) / (k-1); Dist2 = [F;Dist2];

csvwrite("TestResult/LandscapeKSResultHH.csv", H1);
csvwrite("TestResult/LandscapeKSPvalueHH.csv", P1);
csvwrite("TestResult/LandscapeKSStatHH.csv", Stat1);
csvwrite("TestResult/LandscapeJSDHH.csv", Dist1);

csvwrite("TestResult/LandscapeKSResultHG.csv", H2);
csvwrite("TestResult/LandscapeKSPvalueHG.csv", P2);
csvwrite("TestResult/LandscapeKSStatHG.csv", Stat2);
csvwrite("TestResult/LandscapeJSDHG.csv", Dist2);

