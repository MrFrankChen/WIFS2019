%% Portrait

for i = 1 : 138
    
    if (i ~= 121)
        Name = strcat("Dataset/Human/Train/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        if exist(FileName, 'file')
            Data = csvread(FileName);

            [Genuine, Temp1] = SampleSelect(Data, 136, 0);
            Genuine(:, 30) = 0;

            Imposter = SelectFromOtherUser(i, 0, 136);
            Imposter(:, 30) = 1;

            Result = [Genuine; Imposter];

            Name = strcat("Dataset/HumanCFS/CFSHuman", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Result);
        end
        
    end

end


%% Landscape

for i = 139 : 197

    if (i ~= 169)
        Name = strcat("Dataset/Human/Train/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        if exist(FileName, 'file')
            Data = csvread(FileName);

            [Genuine, Temp1] = SampleSelect(Data, 112, 0);
            Genuine(:, 30) = 0;

            Imposter = SelectFromOtherUser(i, 0, 112);
            Imposter(:, 30) = 1;

            Result = [Genuine; Imposter];

            Name = strcat("Dataset/HumanCFS/CFSHuman", num2str(i));
            FileName = strcat(Name, ".csv");
            csvwrite(FileName, Result);
        end
        
    end

end
