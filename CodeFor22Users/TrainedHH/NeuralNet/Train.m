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
        
        net1 = feedforwardnet([10 10]);
        net1 = configure(net1, X1', Y');
        net1 = train(net1, X1', Y');
        
        y1 = net1(X1');
        Temp1 = [y1', zero, Y];
        [EER1, Threshold1] = calculateEER(Temp1);
        Threshold(k, 1) = Threshold1;
        
        net2 = feedforwardnet([10 10]);
        net2 = configure(net2, X2', Y');
        net2 = train(net2, X2', Y');
        
        y2 = net2(X2');
        Temp2 = [y2', zero, Y];
        [EER2, Threshold2] = calculateEER(Temp2);
        Threshold(k, 2) = Threshold2;
        
        net3 = feedforwardnet([10 10]);
        net3 = configure(net3, X3', Y');
        net3 = train(net3, X3', Y');
        
        y3 = net3(X3');
        Temp3 = [y3', zero, Y];
        [EER3, Threshold3] = calculateEER(Temp3);
        Threshold(k, 3) = Threshold3;
        
        net0 = feedforwardnet([10 10]);
        net0 = configure(net0, X0', Y');
        net0 = train(net0, X0', Y');
        
        y0 = net0(X0');
        Temp0 = [y0', zero, Y];
        [EER0, Threshold0] = calculateEER(Temp0);
        Threshold(k, 4) = Threshold0;
        
        NetName1 = strcat("TrainedHH/NeuralNet/Net8F/Net", num2str(i));
        NetName2 = strcat("TrainedHH/NeuralNet/Net10F/Net", num2str(i));
        NetName3 = strcat("TrainedHH/NeuralNet/Net15F/Net", num2str(i));
        NetName0 = strcat("TrainedHH/NeuralNet/Net29F/Net", num2str(i));

        
        save(NetName1, 'net1')
        save(NetName2, 'net2')
        save(NetName3, 'net3')
        save(NetName0, 'net0')

        k = k + 1;
        
    end
end

save("TrainedHH/NeuralNet/Threshold.mat", 'Threshold');
