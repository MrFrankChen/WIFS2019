%% Portrait

D = zeros(1, 29);

for i = 1 : 138
    Name = strcat("Dataset/Human/Whole/Train/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    Temp = csvread(FileName);
    D = [D;Temp];
end

D(1,:) = [];
corrMatrix1 = abs(corr(D));
save Dataset/PortraitCorrMatrix.mat corrMatrix1 ;

%% Landscape

D = zeros(1, 29);

for i = 139 : 197
    Name = strcat("Dataset/Human/Whole/Train/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    Temp = csvread(FileName);
    D = [D;Temp];
end

D(1,:) = [];
corrMatrix2 = abs(corr(D));
save Dataset/LandscapeCorrMatrix.mat corrMatrix1 ;