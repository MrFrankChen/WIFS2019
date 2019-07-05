E = [29, 67, 119, 126, 183];

for i = 1 : 197
    Name = strcat("Dataset/Human/Train/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    if (exist(FileName, 'file') && ~ismember(i, E))
        GenuineTraining = csvread(FileName);
        
        Name = strcat("Dataset/Human/Test/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTesting = csvread(FileName);
        
        Name = strcat("Dataset/GAN/Train/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        ImposterTraining = csvread(FileName);
        
        Name = strcat("Dataset/Gan/Test/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        ImposterTesting = csvread(FileName);
        
        
        GenuineTraining(:, 30) = 0;
        GenuineTesting(:, 30) = 0;
        
        ImposterTraining(:, 30) = 1;
        ImposterTesting(:, 30) = 1;
        
        Train = [GenuineTraining; ImposterTraining];
        Test = [GenuineTesting; ImposterTesting];

        
        Tempmin = min(Train);
        Tempmax = max(Train);
        
        %normalize Test1 Dataset according to Train Dataset
        for j = 1 : 28
            Test(:,j) = (Test(:,j) - Tempmin(1,j)) / (Tempmax(1,j) - Tempmin(1,j));
        end



        %normalize Train Dataset
        Train = mapminmax(Train', 0, 1);
        Train = Train';

        Name = strcat("Dataset/HG/Train/TrainHG", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Train);

        Name = strcat("Dataset/HG/Test/Test", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Test);

    end
end
