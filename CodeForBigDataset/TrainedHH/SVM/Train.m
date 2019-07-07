%% Portrait

clc; clear;

F1 = [29, 24, 26, 5, 25, 15, 12, 22, 23, 21, 27];

F2 = [29, 24, 26, 5, 25, 15, 22, 12, 23, 21, 27, 2, 28];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

for i = 1 : 138

    Name = strcat("Dataset/HH/Train/TrainHH", num2str(i));
    TrainName = strcat(Name, ".csv");

    if exist(TrainName, 'file')
        TrainData = csvread(TrainName);
        [m1,n1] = size(TrainData);
        X1 = zeros(m1, length(F1));
        X2 = zeros(m1, length(F2));
        X0 = zeros(m1, length(F0));
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                X1(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F2))
                X2(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F0))
                X0(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end

        Y = TrainData(:,30);

        SVMModel1 = fitcsvm(X1, Y, 'Standardize',true);
        SVMModel2 = fitcsvm(X2, Y, 'Standardize',true);
        SVMModel0 = fitcsvm(X0, Y, 'Standardize',true);

        ModelName1 = strcat("TrainedHH/SVM/Portrait/Model11F/Model", num2str(i));
        ModelName2 = strcat("TrainedHH/SVM/Portrait/Model13F/Model", num2str(i));
        ModelName0 = strcat("TrainedHH/SVM/Portrait/Model29F/Model", num2str(i));
        
        save(ModelName1,'SVMModel1'); 
        save(ModelName2,'SVMModel2'); 
        save(ModelName0,'SVMModel0'); 
    end
end




%% Landscape

clc; clear;

F1 = [22, 21, 29, 15, 24, 3, 25, 12];

F2 = [22, 21, 23, 29, 15, 24, 3, 25, 12];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

for i = 139 : 197

    Name = strcat("Dataset/HH/Train/TrainHH", num2str(i));
    TrainName = strcat(Name, ".csv");

    if exist(TrainName, 'file')
        TrainData = csvread(TrainName);
        [m1,n1] = size(TrainData);
        X1 = zeros(m1, length(F1));
        X2 = zeros(m1, length(F2));
        X0 = zeros(m1, length(F0));
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                X1(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F2))
                X2(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F0))
                X0(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end

        Y = TrainData(:,30);

        SVMModel1 = fitcsvm(X1, Y, 'Standardize',true);
        SVMModel2 = fitcsvm(X2, Y, 'Standardize',true);
        SVMModel0 = fitcsvm(X0, Y, 'Standardize',true);

        ModelName1 = strcat("TrainedHH/SVM/Landscape/Model8F/Model", num2str(i));
        ModelName2 = strcat("TrainedHH/SVM/Landscape/Model9F/Model", num2str(i));
        ModelName0 = strcat("TrainedHH/SVM/Landscape/Model29F/Model", num2str(i));
        
        save(ModelName1,'SVMModel1'); 
        save(ModelName2,'SVMModel2'); 
        save(ModelName0,'SVMModel0'); 
    end
end


