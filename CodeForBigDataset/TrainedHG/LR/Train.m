k = 1;

F1 = [27];

F21 = [27, 26];

F22 = [27, 15];

F4 = [27, 26, 15, 19];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

for i = 1 : 197
    
    Name = strcat("Dataset/HG/Train/TrainHG", num2str(i));
    TrainName = strcat(Name, ".csv");
    if exist(TrainName, 'file')
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
        
        Y = categorical(TrainData(:,30));

        LRModel1 = mnrfit(X1, Y);
        LRModel21 = mnrfit(X21, Y);
        LRModel22 = mnrfit(X22, Y);
        LRModel4 = mnrfit(X4, Y);
        LRModel0 = mnrfit(X0, Y);
        
        ModelName1 = strcat("TrainedHG/LR/Model1F/Model", num2str(i));
        ModelName2 = strcat("TrainedHG/LR/Model2F1/Model", num2str(i));
        ModelName3 = strcat("TrainedHG/LR/Model2F2/Model", num2str(i));
        ModelName4 = strcat("TrainedHG/LR/Model4F/Model", num2str(i));
        ModelName0 = strcat("TrainedHG/LR/Model29F/Model", num2str(i));
        
        save(ModelName1,'LRModel1'); 
        save(ModelName2,'LRModel21'); 
        save(ModelName3,'LRModel22'); 
        save(ModelName4,'LRModel4'); 
        save(ModelName0,'LRModel0'); 
        
    end
end


