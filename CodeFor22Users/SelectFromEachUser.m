function [Matrix1, Matrix2, Matrix3] = SelectFromEachUser(current, k1, k2, k3)

M = [1,2,3,6,8,9,12,14,15,16,17,18,20,22,23,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,45,46,47,48,49,50,51,52,53,54,55,56,57,58,60,61,62,65,66,67,69,71,73,74,75,76,77,78,79,80,81,82,84,86,87,88,89];

M(M == current) = [];

[m1,n1] = size(M);

idx1 = randperm(n1);
idx1 = idx1(1:k1);
M1 = M(:,idx1);

idx2 = randperm(n1);
idx2 = idx2(1:k2);
M2 = M(:,idx2);

idx3 = randperm(n1);
idx3 = idx3(1:k3);
M3 = M(:,idx3);

row1 = 1;
row2 = 1;
row3 = 1;

for i = 1 : 89
    Name = strcat("HumanFeatures/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName, 'file')
        Data = csvread(FileName);
        if (ismember(i,M1))
            Matrix1(row1,:) = Data(1,:);
            row1 = row1 + 1;
        end
        if (ismember(i,M2))
            Matrix2(row2,:) = Data(2,:);
            row2 = row2 + 1;
        end
        if (ismember(i,M3))
            Matrix3(row3,:) = Data(3,:);
            row3 = row3 + 1;
        end
    end
end
