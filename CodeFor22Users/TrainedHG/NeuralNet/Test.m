k = 1;

F1 = [27];

F21 = [27, 26];

F22 = [27, 15];

F4 = [27, 26, 15, 19];

F0 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];


M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

load("TrainedHG/NeuralNet/Threshold.mat", 'Threshold');

for i = 1 : 89
    if (ismember(i, M))

        Name1 = strcat("TrainedHG/NeuralNet/Net1F/Net", num2str(i));
        Name21 = strcat("TrainedHG/NeuralNet/Net2F1/Net", num2str(i));
        Name22 = strcat("TrainedHG/NeuralNet/Net2F2/Net", num2str(i));
        Name4 = strcat("TrainedHG/NeuralNet/Net4F/Net", num2str(i));
        Name0 = strcat("TrainedHG/NeuralNet/Net29F/Net", num2str(i));
        
        NetName1 = strcat(Name1, ".mat");
        NetName21 = strcat(Name21, ".mat");
        NetName22 = strcat(Name22, ".mat");
        NetName4 = strcat(Name4, ".mat");
        NetName0 = strcat(Name0, ".mat");
        
        Net_Mat1 = load(NetName1);
        Net_Mat21 = load(NetName21);
        Net_Mat22 = load(NetName22);
        Net_Mat4 = load(NetName4);
        Net_Mat0 = load(NetName0);
        
        Net1 = Net_Mat1.net1;
        Net21 = Net_Mat21.net21;
        Net22 = Net_Mat22.net22;
        Net4 = Net_Mat4.net4;
        Net0 = Net_Mat0.net0;

        % Test 1
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


        % Net21
        score21 = Net21(newX21');
        Temp21 = [score21', zero, TestData(:,30)];
        [EER21, Threshold21] = calculateEER(Temp21);
        label21 = predictByEER(score21',Threshold(k, 2));
        
        R21(k, 1) = i;
        R21(k, 2) = length(find(TestData(:,30) == label21)) / m1;
        R21(k, 3) = EER21;
        CM21 = getConfusionMatrix(TestData(:,30), label21);
        R21(k, 4) = CM21(1, 6);
        R21(k, 5) = CM21(1, 7);
        
        
        % Net22
        score22 = Net22(newX22');
        Temp22 = [score22', zero, TestData(:,30)];
        [EER22, Threshold22] = calculateEER(Temp22);
        label22 = predictByEER(score22',Threshold(k, 3));
        
        R22(k, 1) = i;
        R22(k, 2) = length(find(TestData(:,30) == label22)) / m1;
        R22(k, 3) = EER22;
        CM22 = getConfusionMatrix(TestData(:,30), label22);
        R22(k, 4) = CM22(1, 6);
        R22(k, 5) = CM22(1, 7);
        
        
        % Net4
        score4 = Net4(newX4');
        Temp4 = [score4', zero, TestData(:,30)];
        [EER4, Threshold4] = calculateEER(Temp4);
        label4 = predictByEER(score4',Threshold(k, 4));
        
        R4(k, 1) = i;
        R4(k, 2) = length(find(TestData(:,30) == label4)) / m1;
        R4(k, 3) = EER4;
        CM4 = getConfusionMatrix(TestData(:,30), label4);
        R4(k, 4) = CM4(1, 6);
        R4(k, 5) = CM4(1, 7);
        
        
        % Net0
        score0 = Net0(newX0');
        Temp0 = [score0', zero, TestData(:,30)];
        [EER0, Threshold0] = calculateEER(Temp0);
        label0 = predictByEER(score0',Threshold(k, 5));
        
        R0(k, 1) = i;
        R0(k, 2) = length(find(TestData(:,30) == label0)) / m1;
        R0(k, 3) = EER0;
        CM0 = getConfusionMatrix(TestData(:,30), label0);
        R0(k, 4) = CM0(1, 6);
        R0(k, 5) = CM0(1, 7);
        

        k = k + 1;

    end
end

R1(k, :) = sum(R1) / (k-1);
R21(k, :) = sum(R21) / (k-1);
R22(k, :) = sum(R22) / (k-1);
R4(k, :) = sum(R4) / (k-1);
R0(k, :) = sum(R0) / (k-1);

