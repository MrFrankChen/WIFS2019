E = [29, 67, 119, 126, 183];

for i = 1 : 197
    
    Name = strcat("Dataset/Human/Train/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    if (exist(FileName, 'file') && ~ismember(i, E))
        
        GenuineTraining = csvread(FileName);
        [m1, n1] = size(GenuineTraining);
        
        ImposterTraining = SelectFromOtherUser(i, 0, m1);
        
        Name = strcat("Dataset/Human/Test/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTesting = csvread(FileName);
        [m2, n2] = size(GenuineTesting);
        
        ImposterTesting1 = SelectFromOtherUser(i, 1, m2);
        
        GenuineTraining(:, 30) = 0;
        GenuineTesting(:, 30) = 0;
        
        ImposterTraining(:, 30) = 1;
        ImposterTesting1(:, 30) = 1;
        
        Train = [GenuineTraining; ImposterTraining];
        Test1 = [GenuineTesting; ImposterTesting1];
        
        % Test 2
        Name = strcat("Dataset/GAN/Test/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        GANTesting = csvread(FileName);
        
        GANTesting(:, 30) = 1;
        
        Test2 = [GenuineTesting; GANTesting];
        
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


    end
        
end
