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
        
        net1 = feedforwardnet([10, 10]);
        net1 = configure(net1,X1',Y');
        net1 = train(net1,X1',Y');
        
        y1 = net1(X1');
        Temp1 = [y1', zero, Y];
        [EER1, Threshold1] = calculateEER(Temp1);
        Threshold(k, 1) = Threshold1;
        
        net21 = feedforwardnet([10, 10]);
        net21 = configure(net21,X21',Y');
        net21 = train(net21,X21',Y');
        
        y21 = net21(X21');
        Temp21 = [y21', zero, Y];
        [EER21, Threshold21] = calculateEER(Temp21);
        Threshold(k, 2) = Threshold21;
        
        net22 = feedforwardnet([10, 10]);
        net22 = configure(net22,X22',Y');
        net22 = train(net22,X22',Y');
        
        y22 = net22(X22');
        Temp22 = [y22', zero, Y];
        [EER22, Threshold22] = calculateEER(Temp22);
        Threshold(k, 3) = Threshold22;
        
        net4 = feedforwardnet([10, 10]);
        net4 = configure(net4,X4',Y');
        net4 = train(net4,X4',Y');
        
        y4 = net4(X4');
        Temp4 = [y4', zero, Y];
        [EER4, Threshold4] = calculateEER(Temp4);
        Threshold(k, 4) = Threshold4;
        
        net0 = feedforwardnet([10, 10]);
        net0 = configure(net0,X0',Y');
        net0 = train(net0,X0',Y');
        
        y0 = net0(X0');
        Temp0 = [y0', zero, Y];
        [EER0, Threshold0] = calculateEER(Temp0);
        Threshold(k, 5) = Threshold0;
        
        NetName1 = strcat("TrainedHG/NeuralNet/Net1F/Net", num2str(i));
        NetName21 = strcat("TrainedHG/NeuralNet/Net2F1/Net", num2str(i));
        NetName22 = strcat("TrainedHG/NeuralNet/Net2F2/Net", num2str(i));
        NetName4 = strcat("TrainedHG/NeuralNet/Net4F/Net", num2str(i));
        NetName0 = strcat("TrainedHG/NeuralNet/Net29F/Net", num2str(i));

        
        save(NetName1, 'net1')
        save(NetName21, 'net21')
        save(NetName22, 'net22')
        save(NetName4, 'net4')
        save(NetName0, 'net0')

        k = k + 1;
        
    end
end

save("TrainedHG/NeuralNet/Threshold.mat", 'Threshold');
