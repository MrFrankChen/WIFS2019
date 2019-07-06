k = 1;

F1 = [27];

F21 = [27, 26];

F22 = [27, 15];

F4 = [27, 26, 15, 19];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

flag = 0;

for i = 1 : 197

    Name1 = strcat("TrainedHG/SVM/Model1F/Model", num2str(i));
    Name21 = strcat("TrainedHG/SVM/Model2F1/Model", num2str(i));
    Name22 = strcat("TrainedHG/SVM/Model2F2/Model", num2str(i));
    Name4 = strcat("TrainedHG/SVM/Model4F/Model", num2str(i));
    Name0 = strcat("TrainedHG/SVM/Model29F/Model", num2str(i));

    ModelName1 = strcat(Name1, ".mat");
    ModelName21 = strcat(Name21, ".mat");
    ModelName22 = strcat(Name22, ".mat");
    ModelName4 = strcat(Name4, ".mat");
    ModelName0 = strcat(Name0, ".mat");

    if exist(ModelName1, 'file')
        
        Model_Mat1 = load(ModelName1);
        Model_Mat21 = load(ModelName21);
        Model_Mat22 = load(ModelName22);
        Model_Mat4 = load(ModelName4);
        Model_Mat0 = load(ModelName0);
        
        SVMModel1 = Model_Mat1.SVMModel1;
        SVMModel21 = Model_Mat21.SVMModel21;
        SVMModel22 = Model_Mat22.SVMModel22;
        SVMModel4 = Model_Mat4.SVMModel4;
        SVMModel0 = Model_Mat0.SVMModel0;

        % Test
        TestName = strcat("Dataset/HG/Test/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData = csvread(TestName);
        [m1,n1] = size(TestData);
        
        newX1 = zeros(m1,length(F1));
        newX21 = zeros(m1,length(F21));
        newX22 = zeros(m1,length(F22));
        newX4 = zeros(m1,length(F4));
        newX0 = zeros(m1,length(F0));

        r = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                newX1(:,r) = TestData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F21))
                newX21(:,r) = TestData(:,j);
                r = r + 1;
            end
        end

        r = 1;
        for j = 1 : 29
            if (ismember(j,F22))
                newX22(:,r) = TestData(:,j);
                r = r + 1;
            end
        end

        r = 1;
        for j = 1 : 29
            if (ismember(j,F4))
                newX4(:,r) = TestData(:,j);
                r = r + 1;
            end
        end
        
        r = 1;
        for j = 1 : 29
            if (ismember(j,F0))
                newX0(:,r) = TestData(:,j);
                r = r + 1;
            end
        end
            

        [label1,score1] = predict(SVMModel1,newX1);
        Temp1 = [score1, TestData(:,30), label1];
        [EER1, Threshold1] = calculateEER(Temp1);
        
        [label21,score21] = predict(SVMModel21,newX21);
        Temp21 = [score21, TestData(:,30), label21];
        [EER21, Threshold21] = calculateEER(Temp21);

        [label22,score22] = predict(SVMModel22,newX22);
        Temp22 = [score22, TestData(:,30), label22];
        [EER22, Threshold22] = calculateEER(Temp22);

        [label4,score4] = predict(SVMModel4,newX4);
        Temp4 = [score4, TestData(:,30), label4];
        [EER4, Threshold4] = calculateEER(Temp4);

        [label0,score0] = predict(SVMModel0,newX0);
        Temp0 = [score0, TestData(:,30), label0];
        [EER0, Threshold0] = calculateEER(Temp0);
        
        
        R1(k, 1) = i;
        R1(k, 2) = length(find(TestData(:,30) == label1)) / m1;
        R1(k, 3) = EER1;
        CM1 = getConfusionMatrix(TestData(:,30), label1);
        R1(k, 4) = CM1(1, 6);
        R1(k, 5) = CM1(1, 7);
        R1(k, 6) = Threshold1;
        
        
        R21(k, 1) = i;
        R21(k, 2) = length(find(TestData(:,30) == label21)) / m1;
        R21(k, 3) = EER21;
        CM21 = getConfusionMatrix(TestData(:,30), label21);
        R21(k, 4) = CM21(1, 6);
        R21(k, 5) = CM21(1, 7);
        R21(k, 6) = Threshold21;
        
        
        R22(k, 1) = i;
        R22(k, 2) = length(find(TestData(:,30) == label22)) / m1;
        R22(k, 3) = EER22;
        CM22 = getConfusionMatrix(TestData(:,30), label22);
        R22(k, 4) = CM22(1, 6);
        R22(k, 5) = CM22(1, 7);
        R22(k, 6) = Threshold22;
        
        
        R4(k, 1) = i;
        R4(k, 2) = length(find(TestData(:,30) == label4)) / m1;
        R4(k, 3) = EER4;
        CM4 = getConfusionMatrix(TestData(:,30), label4);
        R4(k, 4) = CM4(1, 6);
        R4(k, 5) = CM4(1, 7);
        R4(k, 6) = Threshold4;
        
        
        R0(k, 1) = i;
        R0(k, 2) = length(find(TestData(:,30) == label0)) / m1;
        R0(k, 3) = EER0;
        CM0 = getConfusionMatrix(TestData(:,30), label0);
        R0(k, 4) = CM0(1, 6);
        R0(k, 5) = CM0(1, 7);
        R0(k, 6) = Threshold0;
        
        k = k + 1;
        
        if (i == 138)
            Temp1 = R1;
            Temp21 = R21;
            Temp22 = R22;
            Temp4 = R4;
            Temp0 = R0;
            Temp1(k, :) = sum(Temp1) / (k-1);
            Temp21(k, :) = sum(Temp21) / (k-1);
            Temp22(k, :) = sum(Temp22) / (k-1);
            Temp4(k, :) = sum(Temp4) / (k-1);
            Temp0(k, :) = sum(Temp0) / (k-1);
            csvwrite("TrainedHG/SVM/Result/Portrait1F.csv", Temp1);
            csvwrite("TrainedHG/SVM/Result/Portrait2F1.csv", Temp21);
            csvwrite("TrainedHG/SVM/Result/Portrait2F2.csv", Temp22);
            csvwrite("TrainedHG/SVM/Result/Portrait4F.csv", Temp4);
            csvwrite("TrainedHG/SVM/Result/Portrait29F.csv", Temp0);
            flag = k;
        end
        
        if (i == 197)
            Temp1 = R1(flag:k-1, :);
            Temp21 = R21(flag:k-1, :);
            Temp22 = R22(flag:k-1, :);
            Temp4 = R4(flag:k-1, :);
            Temp0 = R0(flag:k-1, :);
            Temp1(k-flag+1, :) = sum(Temp1) / (k-flag);
            Temp21(k-flag+1, :) = sum(Temp21) / (k-flag);
            Temp22(k-flag+1, :) = sum(Temp22) / (k-flag);
            Temp4(k-flag+1, :) = sum(Temp4) / (k-flag);
            Temp0(k-flag+1, :) = sum(Temp0) / (k-flag);
            csvwrite("TrainedHG/SVM/Result/Landscape1F.csv", Temp1);
            csvwrite("TrainedHG/SVM/Result/Landscape2F1.csv", Temp21);
            csvwrite("TrainedHG/SVM/Result/Landscape2F2.csv", Temp22);
            csvwrite("TrainedHG/SVM/Result/Landscape4F.csv", Temp4);
            csvwrite("TrainedHG/SVM/Result/Landscape29F.csv", Temp0);
        end

    end
end

% R1(k, :) = sum(R1) / (k-1);
% R21(k, :) = sum(R21) / (k-1);
% R22(k, :) = sum(R22) / (k-1);
% R4(k, :) = sum(R4) / (k-1);
% R0(k, :) = sum(R0) / (k-1);


