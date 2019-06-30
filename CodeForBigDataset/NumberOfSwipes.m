%% Portrait 1

for i = 1 : 138
    Name = strcat("HumanFeatures/Portrait1/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Data = csvread(FileName);
    [m,n] = size(Data);
    P1(i, 1) = i;
    P1(i, 2) = m;

end


%% Portrait 2

for i = 1 : 138
    Name = strcat("HumanFeatures/Portrait2/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Data = csvread(FileName);
    [m,n] = size(Data);
    P2(i, 1) = i;
    P2(i, 2) = m;

end


%% Landscape 1

k = 1;
for i = 139 : 197
    Name = strcat("HumanFeatures/Landscape1/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Data = csvread(FileName);
    [m,n] = size(Data);
    L1(k, 1) = i;
    L1(k, 2) = m;
    k = k + 1;
end


%% Landscape 2

k = 1;
for i = 139 : 197
    Name = strcat("HumanFeatures/Landscape2/User", num2str(i));
    FileName = strcat(Name, ".csv");
    Data = csvread(FileName);
    [m,n] = size(Data);
    L2(k, 1) = i;
    L2(k, 2) = m;
    k = k + 1;
end