k = 1;

F1 = [27];

F21 = [27, 26];

F22 = [27, 15];

F4 = [27, 26, 15, 19];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];


M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

% M = [1,3,8,14,16,23,26,28,29,33,35,46,53,67,75,82,89];

for i = 1 : 89
    if (ismember(i, M))

        Name1 = strcat("TrainedHG/LR/Model1F/Model", num2str(i));
        Name21 = strcat("TrainedHG/LR/Model2F1/Model", num2str(i));
        Name22 = strcat("TrainedHG/LR/Model2F2/Model", num2str(i));
        Name4 = strcat("TrainedHG/LR/Model4F/Model", num2str(i));
        Name0 = strcat("TrainedHG/LR/Model29F/Model", num2str(i));
        
        ModelName1 = strcat(Name1, ".mat");
        ModelName21 = strcat(Name21, ".mat");
        ModelName22 = strcat(Name22, ".mat");
        ModelName4 = strcat(Name4, ".mat");
        ModelName0 = strcat(Name0, ".mat");
        
        Model_Mat1 = load(ModelName1);
        Model_Mat21 = load(ModelName21);
        Model_Mat22 = load(ModelName22);
        Model_Mat4 = load(ModelName4);
        Model_Mat0 = load(ModelName0);
        
        LRModel1 = Model_Mat1.LRModel1;
        LRModel21 = Model_Mat21.LRModel21;
        LRModel22 = Model_Mat22.LRModel22;
        LRModel4 = Model_Mat4.LRModel4;
        LRModel0 = Model_Mat0.LRModel0;

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
        
%         r = 1;
%         for j = 1 : 29
%             if (ismember(j,F0))
%                 newX0(:,r) = TestData(:,j);
%                 r = r + 1;
%             end
%         end
            

        pihat1 = mnrval(LRModel1, newX1);
        label1 = zeros();
        for j = 1 : size(pihat1)
            if(pihat1(j, 1) >= 0.5)
                label1(j, 1) = 0;
            else 
                label1(j, 1) = 1;
            end
        end
        Temp1 = [pihat1, TestData(:,30), label1];
        [EER1, Threshold1] = calculateEER(Temp1);
        
        R1(k, 1) = i;
        R1(k, 2) = length(find(TestData(:,30) == label1)) / m1;
        R1(k, 3) = EER1;
        CM1 = getConfusionMatrix(TestData(:,30), label1);
        R1(k, 4) = CM1(1, 6);
        R1(k, 5) = CM1(1, 7);
        R1(k, 6) = Threshold1;

        
        pihat21 = mnrval(LRModel21, newX21);
        label21 = zeros();
        for j = 1 : size(pihat21)
            if(pihat21(j, 1) >= 0.5)
                label21(j, 1) = 0;
            else 
                label21(j, 1) = 1;
            end
        end
        Temp21 = [pihat21, TestData(:,30), label21];
        [EER21, Threshold21] = calculateEER(Temp21);
        
        R21(k, 1) = i;
        R21(k, 2) = length(find(TestData(:,30) == label21)) / m1;
        R21(k, 3) = EER21;
        CM21 = getConfusionMatrix(TestData(:,30), label21);
        R21(k, 4) = CM21(1, 6);
        R21(k, 5) = CM21(1, 7);
        R21(k, 6) = Threshold21;

        
        pihat22 = mnrval(LRModel22, newX22);
        label22 = zeros();
        for j = 1 : size(pihat22)
            if(pihat22(j, 1) >= 0.5)
                label22(j, 1) = 0;
            else 
                label22(j, 1) = 1;
            end
        end
        Temp22 = [pihat22, TestData(:,30), label22];
        [EER22, Threshold22] = calculateEER(Temp22);
        
        R22(k, 1) = i;
        R22(k, 2) = length(find(TestData(:,30) == label22)) / m1;
        R22(k, 3) = EER22;
        CM22 = getConfusionMatrix(TestData(:,30), label22);
        R22(k, 4) = CM22(1, 6);
        R22(k, 5) = CM22(1, 7);
        R22(k, 6) = Threshold22;

        
        pihat4 = mnrval(LRModel4, newX4);
        label4 = zeros();
        for j = 1 : size(pihat4)
            if(pihat4(j, 1) >= 0.5)
                label4(j, 1) = 0;
            else 
                label4(j, 1) = 1;
            end
        end
        Temp4 = [pihat4, TestData(:,30), label4];
        [EER4, Threshold4] = calculateEER(Temp4);
        
        R4(k, 1) = i;
        R4(k, 2) = length(find(TestData(:,30) == label4)) / m1;
        R4(k, 3) = EER4;
        CM4 = getConfusionMatrix(TestData(:,30), label4);
        R4(k, 4) = CM4(1, 6);
        R4(k, 5) = CM4(1, 7);
        R4(k, 6) = Threshold4;


%         pihat0 = mnrval(LRModel0, newX0);
%         label0 = zeros();
%         for j = 1 : size(pihat0)
%             if(pihat0(j, 1) >= 0.5)
%                 label0(j, 1) = 0;
%             else 
%                 label0(j, 1) = 1;
%             end
%         end
%         Temp0 = [pihat0, TestData(:,30), label0];
%         [EER0, Threshold0] = calculateEER(Temp0);
%         
%         R0(k, 1) = i;
%         R0(k, 2) = length(find(TestData(:,30) == label0)) / m1;
%         R0(k, 3) = EER0;
%         CM0 = getConfusionMatrix(TestData(:,30), label0);
%         R0(k, 4) = CM0(1, 6);
%         R0(k, 5) = CM0(1, 7);
%         R0(k, 6) = Threshold0;

        
        k = k + 1;

    end
end

R1(k, :) = sum(R1) / (k-1);
R21(k, :) = sum(R21) / (k-1);
R22(k, :) = sum(R22) / (k-1);
R4(k, :) = sum(R4) / (k-1);
R0(k, :) = sum(R0) / (k-1);


