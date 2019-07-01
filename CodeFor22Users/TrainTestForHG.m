M = [1,3,6,8,14,16,23,26,28,29,33,35,38,46,53,58,67,75,77,81,82,89];

for i = 1 : 89
    if (ismember(i, M))
        
        Name = strcat("Dataset/Human/Training/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTraining = csvread(FileName);
%         [m1, n1] = size(GenuineTraining);

        
        Name = strcat("Dataset/Human/Testing/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        GenuineTesting = csvread(FileName);
%         [m2, n2] = size(GenuineTesting);
        
        
        Name = strcat("Dataset/Gan/Training/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        ImposterTraining = csvread(FileName);
%         [m1, n1] = size(GenuineTraining);

        
        Name = strcat("Dataset/Gan/Testing/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        ImposterTesting = csvread(FileName);
%         [m2, n2] = size(GenuineTesting);
        
        
        
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