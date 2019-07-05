k = 1;

F1 = [24, 16, 12, 22, 26, 17, 13, 29];

F2 = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28];

F3 = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28, 2, 25, 3, 8, 27];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

for i = 1 : 89
    if (ismember(i, M))
        Name = strcat("Dataset/HH/Train/TrainHH", num2str(i));
        TrainName = strcat(Name, ".csv");
        TrainData = csvread(TrainName);
        [m1,n1] = size(TrainData);
        X1 = zeros(m1, length(F1));
        X2 = zeros(m1, length(F2));
        X3 = zeros(m1, length(F3));
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
            if (ismember(j,F3))
                X3(:,r) = TrainData(:,j);
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
        SVMModel3 = fitcsvm(X3, Y, 'Standardize',true);
        SVMModel0 = fitcsvm(X0, Y, 'Standardize',true);

        ModelName1 = strcat("TrainedHH/SVM/Model8F/Model", num2str(i));
        ModelName2 = strcat("TrainedHH/SVM/Model10F/Model", num2str(i));
        ModelName3 = strcat("TrainedHH/SVM/Model15F/Model", num2str(i));
        ModelName0 = strcat("TrainedHH/SVM/Model29F/Model", num2str(i));
        
        save(ModelName1,'SVMModel1'); 
        save(ModelName2,'SVMModel2'); 
        save(ModelName3,'SVMModel3'); 
        save(ModelName0,'SVMModel0'); 
    end
end

