%% Portrait

clc; clear;

k = 1;

F1 = [29, 24, 26, 5, 25, 15, 12, 22, 23, 21, 27];

F2 = [29, 24, 26, 5, 25, 15, 22, 12, 23, 21, 27, 2, 28];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

for i = 1 : 138

    Name1 = strcat("TrainedHH/LR/Portrait/Model11F/Model", num2str(i));
    Name2 = strcat("TrainedHH/LR/Portrait/Model13F/Model", num2str(i));
    Name0 = strcat("TrainedHH/LR/Portrait/Model29F/Model", num2str(i));
    
    ModelName1 = strcat(Name1, ".mat");
    ModelName2 = strcat(Name2, ".mat");
    ModelName0 = strcat(Name0, ".mat");
    
    if exist(ModelName1,"file")
        Model_Mat1 = load(ModelName1);
        Model_Mat2 = load(ModelName2);
        Model_Mat0 = load(ModelName0);
            
        LRModel1 = Model_Mat1.LRModel1;
        LRModel2 = Model_Mat2.LRModel2;
        LRModel0 = Model_Mat0.LRModel0;


        % Test 1
        TestName = strcat("Dataset/HH/Test1/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData1 = csvread(TestName);
        [m1,n1] = size(TestData1);
        newX11 = zeros(m1,length(F1));
        newX12 = zeros(m1,length(F2));
        newX10 = zeros(m1,length(F0));

        a = 1;
        b = 1;
        c = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                newX11(:, a) = TestData1(:, j);
                a = a + 1;
            end
            if (ismember(j,F2))
                newX12(:, b) = TestData1(:, j);
                b = b + 1;
            end
            if (ismember(j,F0))
                newX10(:, c) = TestData1(:, j);
                c = c + 1;
            end
        end
            
        % Test 2
        TestName = strcat("Dataset/HH/Test2/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData2 = csvread(TestName);
        [m2,n2] = size(TestData2);
        newX21 = zeros(m1,length(F1));
        newX22 = zeros(m1,length(F2));
        newX20 = zeros(m1,length(F0));

        a = 1;
        b = 1;
        c = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                newX21(:, a) = TestData2(:, j);
                a = a + 1;
            end
            if (ismember(j,F2))
                newX22(:, b) = TestData2(:, j);
                b = b + 1;
            end
            if (ismember(j,F0))
                newX20(:, c) = TestData2(:, j);
                c = c + 1;
            end
        end

        
        % Test 1 + Model11F
        pihat11 = mnrval(LRModel1, newX11);
        label11 = zeros();
        for j = 1 : size(pihat11)
            if(pihat11(j, 1) >= 0.5)
                label11(j, 1) = 0;
            else 
                label11(j, 1) = 1;
            end
        end
        Temp11 = [pihat11, TestData1(:,30), label11];
        [EER11, Threshold11] = calculateEER(Temp11, 2);
        CM11 = getConfusionMatrix(TestData1(:,30), label11);
        
        % Test 1 + Model13F
        pihat12 = mnrval(LRModel2, newX12);
        label12 = zeros();
        for j = 1 : size(pihat12)
            if(pihat12(j, 1) >= 0.5)
                label12(j, 1) = 0;
            else 
                label12(j, 1) = 1;
            end
        end
        Temp12 = [pihat12, TestData1(:,30), label12];
        [EER12, Threshold12] = calculateEER(Temp12, 2);
        CM12 = getConfusionMatrix(TestData1(:,30), label12);
        
        % Test 1 + Model29F
        pihat10 = mnrval(LRModel0, newX10);
        label10 = zeros();
        for j = 1 : size(pihat10)
            if(pihat10(j, 1) >= 0.5)
                label10(j, 1) = 0;
            else 
                label10(j, 1) = 1;
            end
        end
        Temp10 = [pihat10, TestData1(:,30), label10];
        [EER10, Threshold10] = calculateEER(Temp10, 2);
        CM10 = getConfusionMatrix(TestData1(:,30), label10);
        
        % Test 2 + Model11F
        pihat21 = mnrval(LRModel1, newX21);
        label21 = zeros();
        for j = 1 : size(pihat21)
            if(pihat21(j, 1) >= 0.5)
                label21(j, 1) = 0;
            else 
                label21(j, 1) = 1;
            end
        end
        Temp21 = [pihat21, TestData2(:,30), label21];
        [EER21, Threshold21] = calculateEER(Temp21, 2);
        CM21 = getConfusionMatrix(TestData2(:,30), label21);
        
        % Test 2 + Model13F
        pihat22 = mnrval(LRModel2, newX22);
        label22 = zeros();
        for j = 1 : size(pihat22)
            if(pihat22(j, 1) >= 0.5)
                label22(j, 1) = 0;
            else 
                label22(j, 1) = 1;
            end
        end
        Temp22 = [pihat22, TestData2(:,30), label22];
        [EER22, Threshold22] = calculateEER(Temp22, 2);
        CM22 = getConfusionMatrix(TestData2(:,30), label22);
        
        % Test 2 + Model29F
        pihat20 = mnrval(LRModel0, newX20);
        label20 = zeros();
        for j = 1 : size(pihat20)
            if(pihat20(j, 1) >= 0.5)
                label20(j, 1) = 0;
            else 
                label20(j, 1) = 1;
            end
        end
        Temp20 = [pihat20, TestData2(:,30), label20];
        [EER20, Threshold20] = calculateEER(Temp20, 2);
        CM20 = getConfusionMatrix(TestData2(:,30), label20);
  
        
        % Model11F
        R1(k, 1) = i;
        R1(k, 2) = CM11(1, 5);
        R1(k, 3) = EER11;
        R1(k, 4) = CM11(1, 6);
        R1(k, 5) = CM11(1, 7);
        R1(k, 6) = CM21(1, 5);
        R1(k, 7) = EER21;
        R1(k, 8) = CM21(1, 6);
        R1(k, 9) = CM21(1, 7);
            
        % Model13F
        R2(k, 1) = i;
        R2(k, 2) = CM12(1, 5);
        R2(k, 3) = EER12;
        R2(k, 4) = CM12(1, 6);
        R2(k, 5) = CM12(1, 7);
        R2(k, 6) = CM22(1, 5);
        R2(k, 7) = EER22;
        R2(k, 8) = CM22(1, 6);
        R2(k, 9) = CM22(1, 7);
        
        % Model29F
        R0(k, 1) = i;
        R0(k, 2) = CM10(1, 5);
        R0(k, 3) = EER10;
        R0(k, 4) = CM10(1, 6);
        R0(k, 5) = CM10(1, 7);
        R0(k, 6) = CM20(1, 5);
        R0(k, 7) = EER20;
        R0(k, 8) = CM20(1, 6);
        R0(k, 9) = CM20(1, 7);


        k = k + 1;

    end
end

R1(k, :) = sum(R1) / (k-1);
R2(k, :) = sum(R2) / (k-1);
R0(k, :) = sum(R0) / (k-1);

csvwrite("TrainedHH/LR/Result/Portrait11F.csv", R1);
csvwrite("TrainedHH/LR/Result/Portrait13F.csv", R2);
csvwrite("TrainedHH/LR/Result/Portrait29F.csv", R0);



%% Landscape

clc; clear;

k = 1;

F1 = [22, 21, 29, 15, 24, 3, 25, 12];

F2 = [22, 21, 23, 29, 15, 24, 3, 25, 12];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

for i = 139 : 197

    Name1 = strcat("TrainedHH/LR/Landscape/Model8F/Model", num2str(i));
    Name2 = strcat("TrainedHH/LR/Landscape/Model9F/Model", num2str(i));
    Name0 = strcat("TrainedHH/LR/Landscape/Model29F/Model", num2str(i));
    
    ModelName1 = strcat(Name1, ".mat");
    ModelName2 = strcat(Name2, ".mat");
    ModelName0 = strcat(Name0, ".mat");
    
    if exist(ModelName1,"file")
        Model_Mat1 = load(ModelName1);
        Model_Mat2 = load(ModelName2);
        Model_Mat0 = load(ModelName0);
            
        LRModel1 = Model_Mat1.LRModel1;
        LRModel2 = Model_Mat2.LRModel2;
        LRModel0 = Model_Mat0.LRModel0;


        % Test 1
        TestName = strcat("Dataset/HH/Test1/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData1 = csvread(TestName);
        [m1,n1] = size(TestData1);
        newX11 = zeros(m1,length(F1));
        newX12 = zeros(m1,length(F2));
        newX10 = zeros(m1,length(F0));

        a = 1;
        b = 1;
        c = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                newX11(:, a) = TestData1(:, j);
                a = a + 1;
            end
            if (ismember(j,F2))
                newX12(:, b) = TestData1(:, j);
                b = b + 1;
            end
            if (ismember(j,F0))
                newX10(:, c) = TestData1(:, j);
                c = c + 1;
            end
        end
            
        % Test 2
        TestName = strcat("Dataset/HH/Test2/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData2 = csvread(TestName);
        [m2,n2] = size(TestData2);
        newX21 = zeros(m1,length(F1));
        newX22 = zeros(m1,length(F2));
        newX20 = zeros(m1,length(F0));

        a = 1;
        b = 1;
        c = 1;
        for j = 1 : 29
            if (ismember(j,F1))
                newX21(:, a) = TestData2(:, j);
                a = a + 1;
            end
            if (ismember(j,F2))
                newX22(:, b) = TestData2(:, j);
                b = b + 1;
            end
            if (ismember(j,F0))
                newX20(:, c) = TestData2(:, j);
                c = c + 1;
            end
        end

        
        % Test 1 + Model11F
        pihat11 = mnrval(LRModel1, newX11);
        label11 = zeros();
        for j = 1 : size(pihat11)
            if(pihat11(j, 1) >= 0.5)
                label11(j, 1) = 0;
            else 
                label11(j, 1) = 1;
            end
        end
        Temp11 = [pihat11, TestData1(:,30), label11];
        [EER11, Threshold11] = calculateEER(Temp11, 2);
        CM11 = getConfusionMatrix(TestData1(:,30), label11);
        
        % Test 1 + Model13F
        pihat12 = mnrval(LRModel2, newX12);
        label12 = zeros();
        for j = 1 : size(pihat12)
            if(pihat12(j, 1) >= 0.5)
                label12(j, 1) = 0;
            else 
                label12(j, 1) = 1;
            end
        end
        Temp12 = [pihat12, TestData1(:,30), label12];
        [EER12, Threshold12] = calculateEER(Temp12, 2);
        CM12 = getConfusionMatrix(TestData1(:,30), label12);
        
        % Test 1 + Model29F
        pihat10 = mnrval(LRModel0, newX10);
        label10 = zeros();
        for j = 1 : size(pihat10)
            if(pihat10(j, 1) >= 0.5)
                label10(j, 1) = 0;
            else 
                label10(j, 1) = 1;
            end
        end
        Temp10 = [pihat10, TestData1(:,30), label10];
        [EER10, Threshold10] = calculateEER(Temp10, 2);
        CM10 = getConfusionMatrix(TestData1(:,30), label10);
        
        % Test 2 + Model11F
        pihat21 = mnrval(LRModel1, newX21);
        label21 = zeros();
        for j = 1 : size(pihat21)
            if(pihat21(j, 1) >= 0.5)
                label21(j, 1) = 0;
            else 
                label21(j, 1) = 1;
            end
        end
        Temp21 = [pihat21, TestData2(:,30), label21];
        [EER21, Threshold21] = calculateEER(Temp21, 2);
        CM21 = getConfusionMatrix(TestData2(:,30), label21);
        
        % Test 2 + Model13F
        pihat22 = mnrval(LRModel2, newX22);
        label22 = zeros();
        for j = 1 : size(pihat22)
            if(pihat22(j, 1) >= 0.5)
                label22(j, 1) = 0;
            else 
                label22(j, 1) = 1;
            end
        end
        Temp22 = [pihat22, TestData2(:,30), label22];
        [EER22, Threshold22] = calculateEER(Temp22, 2);
        CM22 = getConfusionMatrix(TestData2(:,30), label22);
        
        % Test 2 + Model29F
        pihat20 = mnrval(LRModel0, newX20);
        label20 = zeros();
        for j = 1 : size(pihat20)
            if(pihat20(j, 1) >= 0.5)
                label20(j, 1) = 0;
            else 
                label20(j, 1) = 1;
            end
        end
        Temp20 = [pihat20, TestData2(:,30), label20];
        [EER20, Threshold20] = calculateEER(Temp20, 2);
        CM20 = getConfusionMatrix(TestData2(:,30), label20);
        
        % Model11F
        R1(k, 1) = i;
        R1(k, 2) = CM11(1, 5);
        R1(k, 3) = EER11;
        R1(k, 4) = CM11(1, 6);
        R1(k, 5) = CM11(1, 7);
        R1(k, 6) = CM21(1, 5);
        R1(k, 7) = EER21;
        R1(k, 8) = CM21(1, 6);
        R1(k, 9) = CM21(1, 7);
            
        % Model13F
        R2(k, 1) = i;
        R2(k, 2) = CM12(1, 5);
        R2(k, 3) = EER12;
        R2(k, 4) = CM12(1, 6);
        R2(k, 5) = CM12(1, 7);
        R2(k, 6) = CM22(1, 5);
        R2(k, 7) = EER22;
        R2(k, 8) = CM22(1, 6);
        R2(k, 9) = CM22(1, 7);
        
        % Model29F
        R0(k, 1) = i;
        R0(k, 2) = CM10(1, 5);
        R0(k, 3) = EER10;
        R0(k, 4) = CM10(1, 6);
        R0(k, 5) = CM10(1, 7);
        R0(k, 6) = CM20(1, 5);
        R0(k, 7) = EER20;
        R0(k, 8) = CM20(1, 6);
        R0(k, 9) = CM20(1, 7);


        k = k + 1;

    end
end

R1(k, :) = sum(R1) / (k-1);
R2(k, :) = sum(R2) / (k-1);
R0(k, :) = sum(R0) / (k-1);

csvwrite("TrainedHH/LR/Result/Landscape8F.csv", R1);
csvwrite("TrainedHH/LR/Result/Landscape9F.csv", R2);
csvwrite("TrainedHH/LR/Result/Landscape29F.csv", R0);
