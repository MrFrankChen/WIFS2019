function Matrix = SelectFromOtherUser(current, TrainOrTest, POrL, k)
% Train - 0
% Test - 1
% Portrait - 0
% Landscape - 1

if (POrL == 0)
    m = 1;
    n = 138;
else
    m = 139;
    n = 197;
end

selected = 0;
i = m;
row = 1;

if (TrainOrTest == 0)
    
    while (selected ~= k)
        if (i >= n)
            i = m;
            row = row + 1;
        end
        
        if (i == current)
%             Name = strcat("Dataset/Gan/Training/Gan", num2str(i));
%             FileName = strcat(Name, ".csv");
%             Gan = csvread(FileName);
% 
%             selected = selected + 1;
%             Matrix(selected,:) = Gan(row, :);
                
            i = i + 1;
            continue;
        end
        
        Name = strcat("Dataset/Human/Whole/Train/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        if exist(FileName, 'file')
            Data = csvread(FileName);
            [m1, n1] = size(Data);
            if (row <= m1)
                selected = selected + 1;
                Matrix(selected,:) = Data(row, :);
            end
        end
        i = i + 1;
    end
    
else 

    while (selected ~= k)
        if (i >= n)
            i = m;
            row = row + 1;
        end
        
        if (i == current)
%             Name = strcat("Gan/Test/Gan", num2str(i));
%             FileName = strcat(Name, ".csv");
%             Gan = csvread(FileName);
% 
%             selected = selected + 1;
%             Matrix(selected,:) = Gan(row, :);
            
            i = i + 1;
            continue;
        end
        
        Name = strcat("Dataset/Human/Whole/Test/Human", num2str(i));
        FileName = strcat(Name, ".csv");
        if exist(FileName, 'file')
            Data = csvread(FileName);
            [m1, n1] = size(Data);
            if (row <= m1)
                selected = selected + 1;
                Matrix(selected,:) = Data(row, :);
            end
        end
        i = i + 1;
    end
    
end

