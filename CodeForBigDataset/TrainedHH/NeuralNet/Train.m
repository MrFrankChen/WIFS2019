%% Portrait

clc; clear;

k = 1;

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
        zero = zeros(m1, 1);
        
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
        
        net1 = feedforwardnet([10 10]);
        net1 = configure(net1, X1', Y');
        net1 = train(net1, X1', Y');
        
        y1 = net1(X1');
        Temp1 = [y1', zero, Y];
        [EER1, Threshold1] = calculateEER(Temp1, 1);
        Threshold(k, 1) = Threshold1;
        
        net2 = feedforwardnet([10 10]);
        net2 = configure(net2, X2', Y');
        net2 = train(net2, X2', Y');
        
        y2 = net2(X2');
        Temp2 = [y2', zero, Y];
        [EER2, Threshold2] = calculateEER(Temp2, 1);
        Threshold(k, 2) = Threshold2;
        
        net0 = feedforwardnet([10 10]);
        net0 = configure(net0, X0', Y');
        net0 = train(net0, X0', Y');
        
        y0 = net0(X0');
        Temp0 = [y0', zero, Y];
        [EER0, Threshold0] = calculateEER(Temp0, 1);
        Threshold(k, 3) = Threshold0;
        
        NetName1 = strcat("TrainedHH/NeuralNet/Portrait/Net11F/Net", num2str(i));
        NetName2 = strcat("TrainedHH/NeuralNet/Portrait/Net13F/Net", num2str(i));
        NetName0 = strcat("TrainedHH/NeuralNet/Portrait/Net29F/Net", num2str(i));

        save(NetName1, 'net1')
        save(NetName2, 'net2')
        save(NetName0, 'net0')

        k = k + 1;
        
    end
end

save("TrainedHH/NeuralNet/PortraitThreshold.mat", 'Threshold');


%% Landscape

clc; clear;

k = 1;

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
        zero = zeros(m1, 1);
        
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
        
        net1 = feedforwardnet([10 10]);
        net1 = configure(net1, X1', Y');
        net1 = train(net1, X1', Y');
        
        y1 = net1(X1');
        Temp1 = [y1', zero, Y];
        [EER1, Threshold1] = calculateEER(Temp1, 1);
        Threshold(k, 1) = Threshold1;
        
        net2 = feedforwardnet([10 10]);
        net2 = configure(net2, X2', Y');
        net2 = train(net2, X2', Y');
        
        y2 = net2(X2');
        Temp2 = [y2', zero, Y];
        [EER2, Threshold2] = calculateEER(Temp2, 1);
        Threshold(k, 2) = Threshold2;
        
        net0 = feedforwardnet([10 10]);
        net0 = configure(net0, X0', Y');
        net0 = train(net0, X0', Y');
        
        y0 = net0(X0');
        Temp0 = [y0', zero, Y];
        [EER0, Threshold0] = calculateEER(Temp0, 1);
        Threshold(k, 3) = Threshold0;
        
        NetName1 = strcat("TrainedHH/NeuralNet/Landscape/Net8F/Net", num2str(i));
        NetName2 = strcat("TrainedHH/NeuralNet/Landscape/Net9F/Net", num2str(i));
        NetName0 = strcat("TrainedHH/NeuralNet/Landscape/Net29F/Net", num2str(i));

        save(NetName1, 'net1')
        save(NetName2, 'net2')
        save(NetName0, 'net0')

        k = k + 1;
        
    end
end


save("TrainedHH/NeuralNet/LandscapeThreshold.mat", 'Threshold');
