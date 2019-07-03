%% Portrait

FeatureCombo = zeros(200,30);
k = 1;

for i = 1 : 138
    Name = strcat("Dataset/HumanCFS/CFSHuman", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName,'file')
        Data = csvread(FileName);
        MappedData = mapminmax(Data', 0, 1);
        Data = MappedData';
        [FF,M] = CFS(Data);
        FeatureCombo(k,1) = i;
        FeatureCombo(k,2:length(FF)+1) = FF;
        k = k + 1;
    end
end

FeatureCombo(all(FeatureCombo == 0, 2),:) = [];
FeatureCombo(:,all(FeatureCombo == 0, 1)) = [];

Result = zeros(29, 2);
for i = 1 : length(FeatureCombo)
    R = tabulate(FeatureCombo(i,:));
    for j = 1 : length(R)
        if (R(j,1) > 0 && R(j,1) < 30)
            Result(R(j,1),1) = R(j,1);
            Result(R(j,1),2) = Result(R(j,1),2) + R(j,2);
        end
    end
end

csvwrite("FeatureComboForPortrait.csv", FeatureCombo);
csvwrite("FeatureRankForPortrait.csv", Result);



%% Landscape

FeatureCombo = zeros(200,30);
k = 1;

for i = 139 : 197
    Name = strcat("Dataset/HumanCFS/CFSHuman", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName,'file')
        Data = csvread(FileName);
        MappedData = mapminmax(Data', 0, 1);
        Data = MappedData';
        [FF,M] = CFS(Data);
        FeatureCombo(k,1) = i;
        FeatureCombo(k,2:length(FF)+1) = FF;
        k = k + 1;
    end
end

FeatureCombo(all(FeatureCombo == 0, 2),:) = [];
FeatureCombo(:,all(FeatureCombo == 0, 1)) = [];

Result = zeros(29, 2);
for i = 1 : length(FeatureCombo)
    R = tabulate(FeatureCombo(i,:));
    for j = 1 : length(R)
        if (R(j,1) > 0 && R(j,1) < 30)
            Result(R(j,1),1) = R(j,1);
            Result(R(j,1),2) = Result(R(j,1),2) + R(j,2);
        end
    end
end

csvwrite("FeatureComboForLandscape.csv", FeatureCombo);
csvwrite("FeatureRankForLandscape.csv", Result);


