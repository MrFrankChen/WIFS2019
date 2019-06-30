%% Portrait

D = zeros(1, 30);

for i = 1 : 138
    Name = strcat("HumanFeatures/Portrait1/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Temp = csvread(FileName);
    D = [D;Temp];
end

D(1,:) = [];
D(:, 30) = [];
corrMatrix = abs(corr(D));


%% Landscape

D = zeros(1, 30);
for i = 139 : 197
    Name = strcat("HumanFeatures/Landscape1/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Temp = csvread(FileName);
    D = [D;Temp];
end

D(1,:) = [];
D(:, 30) = [];
corrMatrix = abs(corr(D));