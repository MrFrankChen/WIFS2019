%% Human

for i = 1 : 89
    Name = strcat("Dataset/Human/Whole/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName, 'file')
        Data = csvread(FileName);
        [m1, m2] = size(Data);
        
        if (m1 >= 10)
            k1 = floor(m1 * 0.6);
            k2 = m1 - k1;

            [Train, Test] = SampleSelect(Data, k1, k2);

            Name = strcat("Dataset/Human/Training/Human", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Train);

            Name = strcat("Dataset/Human/Testing/Human", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Test);

        end

    end
end



%% GAN


for i = 1 : 89
    Name = strcat("Dataset/Gan/Whole/Gan", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName, 'file')
        Data = csvread(FileName);
        [m1, m2] = size(Data);
        
        if (m1 >= 10)
            k1 = floor(m1 * 0.6);
            k2 = m1 - k1;

            [Train, Test] = SampleSelect(Data, k1, k2);

            Name = strcat("Dataset/Gan/Training/Gan", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Train);

            Name = strcat("Dataset/Gan/Testing/Gan", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Test);

        end

    end
end