function Matrix = SelectFromOtherUser(current, TrainOrTest, k)
% Train - 0
% Test - 1

selected = 0;
i = 1;
row = 1;

if (TrainOrTest == 0)
    
    while (selected ~= k)
        if (i >= 89)
            i = 1;
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
        
        Name = strcat("Dataset/Human/Training/Human", num2str(i));
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
        if (i >= 89)
            i = 1;
            row = row + 1;
        end
        
        if (i == current)
%             Name = strcat("Gan/Testing/Gan", num2str(i));
%             FileName = strcat(Name, ".csv");
%             Gan = csvread(FileName);
% 
%             selected = selected + 1;
%             Matrix(selected,:) = Gan(row, :);
            
            i = i + 1;
            continue;
        end
        
        Name = strcat("Dataset/Human/Testing/Human", num2str(i));
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

