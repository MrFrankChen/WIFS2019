k = 1;

F1 = [27];

F21 = [27, 26];

F22 = [27, 15];

F4 = [27, 26, 15, 19];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

for i = 1 : 89
    if (ismember(i, M))

        Name = strcat("Dataset/HG/Train/TrainHG", num2str(i));
        TrainName = strcat(Name, ".csv");
        TrainData = csvread(TrainName);
        [m1,n1] = size(TrainData);
        
        X1 = zeros(m1, length(F1));
        X21 = zeros(m1, length(F21));
        X22 = zeros(m1, length(F22));
        X4 = zeros(m1, length(F4));
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
            if (ismember(j,F21))
                X21(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F22))
                X22(:,r) = TrainData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F4))
                X4(:,r) = TrainData(:,j);
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
        SVMModel21 = fitcsvm(X21, Y, 'Standardize',true);
        SVMModel22 = fitcsvm(X22, Y, 'Standardize',true);
        SVMModel4 = fitcsvm(X4, Y, 'Standardize',true);
        SVMModel0 = fitcsvm(X0, Y, 'Standardize',true);
        
        ModelName1 = strcat("TrainedHG/SVM/Model1F/Model", num2str(i));
        ModelName2 = strcat("TrainedHG/SVM/Model2F1/Model", num2str(i));
        ModelName3 = strcat("TrainedHG/SVM/Model2F2/Model", num2str(i));
        ModelName4 = strcat("TrainedHG/SVM/Model4F/Model", num2str(i));
        ModelName0 = strcat("TrainedHG/SVM/Model29F/Model", num2str(i));
        
        save(ModelName1,'SVMModel1'); 
        save(ModelName2,'SVMModel21'); 
        save(ModelName3,'SVMModel22'); 
        save(ModelName4,'SVMModel4'); 
        save(ModelName0,'SVMModel0'); 
        
    end
end


