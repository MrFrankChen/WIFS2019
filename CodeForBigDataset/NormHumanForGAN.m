M = [121, 144, 161, 169, 170, 188, 195];

for i = 1 : 197
    Name = strcat("Dataset/Human/Train/Human", num2str(i));
    FileName = strcat(Name, ".csv");
    if exist(FileName, 'file')
        Data = csvread(FileName);

        Data_min = min(Data);
        Data_max = max(Data);

        Data = Data ./ (Data_max / 2) - 1;

        Name = strcat("Dataset/Human/NormTrainForGAN/NormHuman", num2str(i));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, Data);
    end
end
