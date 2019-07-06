k = 1;

F1 = [24, 16, 12, 22, 26, 17, 13, 29];

F2 = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28];

F3 = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28, 2, 25, 3, 8, 27];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

load("TrainedHH/NeuralNet/Threshold.mat", 'Threshold');

for i = 1 : 197

    Name1 = strcat("TrainedHH/NeuralNet/Net8F/Net", num2str(i));
    Name2 = strcat("TrainedHH/NeuralNet/Net10F/Net", num2str(i));
    Name3 = strcat("TrainedHH/NeuralNet/Net15F/Net", num2str(i));
    Name0 = strcat("TrainedHH/NeuralNet/Net29F/Net", num2str(i));

    NetName1 = strcat(Name1, ".mat");
    NetName2 = strcat(Name2, ".mat");
    NetName3 = strcat(Name3, ".mat");
    NetName0 = strcat(Name0, ".mat");
        
    if exist(NetName1,"file")
        Net_Mat1 = load(NetName1);
        Net_Mat2 = load(NetName2);
        Net_Mat3 = load(NetName3);
        Net_Mat0 = load(NetName0);
        
        Net1 = Net_Mat1.net1;
        Net2 = Net_Mat2.net2;
        Net3 = Net_Mat3.net3;
        Net0 = Net_Mat0.net0;

        % Test 1
%         TestName = strcat("Dataset/HH/Test1/Test", num2str(i));
        TestName = strcat("Dataset/HH/Test2/Test", num2str(i));

        TestName = strcat(TestName, ".csv");
        TestData = csvread(TestName);
        [m1,n1] = size(TestData);
        
        newX1 = zeros(m1,length(F1));
        newX2 = zeros(m1,length(F2));
        newX3 = zeros(m1,length(F3));
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
            if (ismember(j,F2))
                newX2(:,r) = TestData(:,j);
                r = r + 1;
            end
        end

        r = 1;
        for j = 1 : 29
            if (ismember(j,F3))
                newX3(:,r) = TestData(:,j);
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

        zero = zeros(m1, 1);
        
        % Net1
        score1 = Net1(newX1');
        Temp1 = [score1', zero, TestData(:,30)];
        [EER1, Threshold1] = calculateEER(Temp1);
        label1 = predictByEER(score1',Threshold(k, 1));
        
        R1(k, 1) = i;
        R1(k, 2) = length(find(TestData(:,30) == label1)) / m1;
        R1(k, 3) = EER1;
        CM1 = getConfusionMatrix(TestData(:,30), label1);
        R1(k, 4) = CM1(1, 6);
        R1(k, 5) = CM1(1, 7);


        % Net2
        score2 = Net2(newX2');
        Temp2 = [score2', zero, TestData(:,30)];
        [EER2, Threshold2] = calculateEER(Temp2);
        label2 = predictByEER(score2',Threshold(k, 2));
        
        R2(k, 1) = i;
        R2(k, 2) = length(find(TestData(:,30) == label2)) / m1;
        R2(k, 3) = EER2;
        CM2 = getConfusionMatrix(TestData(:,30), label2);
        R2(k, 4) = CM2(1, 6);
        R2(k, 5) = CM2(1, 7);
        
        
        % Net3
        score3 = Net3(newX3');
        Temp3 = [score3', zero, TestData(:,30)];
        [EER3, Threshold3] = calculateEER(Temp3);
        label3 = predictByEER(score3',Threshold(k, 3));
        
        R3(k, 1) = i;
        R3(k, 2) = length(find(TestData(:,30) == label3)) / m1;
        R3(k, 3) = EER3;
        CM3 = getConfusionMatrix(TestData(:,30), label3);
        R3(k, 4) = CM3(1, 6);
        R3(k, 5) = CM3(1, 7);
        
        
        % Net0
        score0 = Net0(newX0');
        Temp0 = [score0', zero, TestData(:,30)];
        [EER0, Threshold0] = calculateEER(Temp0);
        label0 = predictByEER(score0',Threshold(k, 4));
        
        R0(k, 1) = i;
        R0(k, 2) = length(find(TestData(:,30) == label0)) / m1;
        R0(k, 3) = EER0;
        CM0 = getConfusionMatrix(TestData(:,30), label0);
        R0(k, 4) = CM0(1, 6);
        R0(k, 5) = CM0(1, 7);
        

        k = k + 1;
        
        if (i == 138)
            Temp1 = R1;
            Temp2 = R2;
            Temp3 = R3;
            Temp0 = R0;
            Temp1(k, :) = sum(Temp1) / (k-1);
            Temp2(k, :) = sum(Temp2) / (k-1);
            Temp3(k, :) = sum(Temp3) / (k-1);
            Temp0(k, :) = sum(Temp0) / (k-1);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Portrait8F.csv", Temp1);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Portrait10F.csv", Temp2);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Portrait15F.csv", Temp3);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Portrait29F.csv", Temp0);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Portrait8F.csv", Temp1);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Portrait10F.csv", Temp2);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Portrait15F.csv", Temp3);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Portrait29F.csv", Temp0);
            flag = k;
        end
        
        if (i == 197)
            Temp1 = R1(flag:k-1, :);
            Temp2 = R2(flag:k-1, :);
            Temp3 = R3(flag:k-1, :);
            Temp0 = R0(flag:k-1, :);
            Temp1(k-flag+1, :) = sum(Temp1) / (k-flag);
            Temp2(k-flag+1, :) = sum(Temp2) / (k-flag);
            Temp3(k-flag+1, :) = sum(Temp3) / (k-flag);
            Temp0(k-flag+1, :) = sum(Temp0) / (k-flag);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Landscape8F.csv", Temp1);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Landscape10F.csv", Temp2);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Landscape15F.csv", Temp3);
%             csvwrite("TrainedHH/NeuralNet/Result/Test1/Landscape29F.csv", Temp0);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Landscape8F.csv", Temp1);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Landscape10F.csv", Temp2);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Landscape15F.csv", Temp3);
            csvwrite("TrainedHH/NeuralNet/Result/Test2/Landscape29F.csv", Temp0);
        end

    end
end

% R1(k, :) = sum(R1) / (k-1);
% R2(k, :) = sum(R2) / (k-1);
% R3(k, :) = sum(R3) / (k-1);
% R0(k, :) = sum(R0) / (k-1);
