M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

for i = 1 : 89
    if (ismember(i, M))
        
        Name = strcat("Dataset/Human/Training/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTraining = csvread(FileName);
        [m1, n1] = size(GenuineTraining);
        
        ImposterTraining = SelectFromOtherUser(i, 0, m1);
        
        Name = strcat("Dataset/Human/Testing/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTesting = csvread(FileName);
        [m2, n2] = size(GenuineTesting);
        if (m2 >= 100)
            num1 = 100;
        else 
            num1 = m2;
        end
        
        [GenuineTesting, Temp1] = SampleSelect(GenuineTesting, num1, 0);
        
        ImposterTesting1 = SelectFromOtherUser(i, 1, num1);
        
        GenuineTraining(:, 30) = 0;
        GenuineTesting(:, 30) = 0;
        
        ImposterTraining(:, 30) = 1;
        ImposterTesting1(:, 30) = 1;
        
        Train = [GenuineTraining; ImposterTraining];
        Test1 = [GenuineTesting; ImposterTesting1];
        
        % Test 2
        Name = strcat("Dataset/Gan/Testing/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        GanTesting = csvread(FileName);
        
        [ImposterTesting2, Temp5] = SampleSelect(GanTesting, num1, 0);
        
        ImposterTesting2(:, 30) = 1;
        
        Test2 = [GenuineTesting; ImposterTesting2];
        
        % Test 3
        Name = strcat("Dataset/Robot/Whole/Robot", num2str(i));
        FileName = strcat(Name, ".csv");
        RobotTesting = csvread(FileName);
        [m3, n3] = size(RobotTesting);
        
        if (num1 < m3)
            [ImposterTesting3, Temp9] = SampleSelect(RobotTesting, num1, 0);
            ImposterTesting3(:, 30) = 1;
            Test3 = [GenuineTesting; ImposterTesting3];
        else 
            [GenuineTesting3, Temp9] = SampleSelect(GenuineTesting, m3, 0);
            RobotTesting(:, 30) = 1;
            Test3 = [GenuineTesting3; RobotTesting];
        end
        
        
        Tempmin = min(Train);
        Tempmax = max(Train);
        
        %normalize Test1 Dataset according to Train Dataset
        for j = 1 : 28
            Test1(:,j) = (Test1(:,j) - Tempmin(1,j)) / (Tempmax(1,j) - Tempmin(1,j));
        end

        %normalize Test2 Dataset according to Train Dataset
        for j = 1 : 28
            Test2(:,j) = (Test2(:,j) - Tempmin(1,j)) / (Tempmax(1,j) - Tempmin(1,j));
        end
        
        %normalize Test3 Dataset according to Train Dataset
        for j = 1 : 28
            Test3(:,j) = (Test3(:,j) - Tempmin(1,j)) / (Tempmax(1,j) - Tempmin(1,j));
        end


        %normalize Train Dataset
        Train = mapminmax(Train', 0, 1);
        Train = Train';

        Name = strcat("Dataset/HH/Train/TrainHH", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Train);

        Name = strcat("Dataset/HH/Test1/Test", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Test1);

        Name = strcat("Dataset/HH/Test2/Test", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Test2);
        
        Name = strcat("Dataset/HH/Test3/Test", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Test3);

        
        
    end
end