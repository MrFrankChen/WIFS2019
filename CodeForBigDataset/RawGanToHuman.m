Num = csvread("NumberOfSwipes.csv");

for i = 1 : 197
    Name = strcat("Dataset/GAN/Raw_Data/Gan", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName, 'file')
        Data = csvread(FileName);
        Data(1,:) = [];
        Data(:,1) = [];
        m1 = find(Data(:,29) > 0);
        m2 = find(Data(:,29) < 0);
        Data(m1,29) = 1;
        Data(m2,29) = -1;



        Name = strcat("Dataset/Human/Whole/Train/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        OData = csvread(FileName);

        Data_min = min(OData);
        Data_max = max(OData);

        Data = (Data + 1) .* (Data_max / 2);

        Name = strcat("Dataset/GAN/Whole/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Data);
        
        [Train, Test] = SampleSelect(Data, Num(i, 2), Num(i, 3));
        
        Name = strcat("Dataset/GAN/Train/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Train);
        
        Name = strcat("Dataset/GAN/Test/Gan", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Test);
        

    end

end
