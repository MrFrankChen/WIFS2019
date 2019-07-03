%% Train

for i = 1 : 197
    if (i == 144)
        RESULT(i, 1) = i;
        RESULT(i, 2) = 0;
    elseif (i == 170)
        RESULT(i, 1) = i;
        RESULT(i, 2) = 0;
    else 
        Name = strcat("Dataset/Human/Whole/Train/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        Data = csvread(FileName);
        [m,n] = size(Data);
        RESULT(i, 1) = i;
        RESULT(i, 2) = m;
    end
    

end


%% Test

for i = 1 : 197
    if (i == 161)
        RESULT(i, 3) = 0;
    elseif (i == 188)
        RESULT(i, 3) = 0;
    else 
        Name = strcat("Dataset/Human/Whole/Test/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        Data = csvread(FileName);
        [m,n] = size(Data);
        RESULT(i, 3) = m;
    end

end


%% Save

csvwrite("Dataset/Human/NumberOfSwipes.csv", RESULT);
