%% Human Feature Extraction


for r = 1 : 89
    Name = strcat("Dataset/Raw_Data/RawHumanSwipeData/Swipe", num2str(r));
    FileName = strcat(Name, ".txt");
    if exist(FileName, 'file')
        fileID = fopen(FileName);
        C = textscan(fileID, '%32f %32f %32f %32f %32f %32f %32f', 'Delimiter', ',');
        D = cell2mat(C(1:6));


        [m,n] = size(D);
        Temp = ones(800,3);
        i = 1;
        k = 1;
        RESULT = ones(1, 29);
        
        while(i ~= m+1)
            if(D(i,1) == 0)
                pstart = i;
            elseif (D(i,1) == 1)
                pend = i;
%                 x = D(pstart:pend,4);
%                 y = D(pstart:pend,5);
%                 plot(x,y);
%                 hold on;

                for stroke = 1:pend-pstart %pstart:pend
                    distance = sqrt((D(pstart+stroke,2) - D(pstart+stroke-1,2))^2 + (D(pstart+stroke,3) - D(pstart+stroke-1,3))^2);
                    velocity = distance / (D(pstart+stroke,6) - D(pstart+stroke-1,6));
                    Temp(stroke,1) = distance;
                    Temp(stroke,2) = velocity;
                end
                
                for stroke = 1:pend-pstart-1 %pstart:pend-1
                    acceleration = Temp(stroke+1,2) - Temp(stroke,2) / ((D(pstart+stroke+1,6) - D(pstart+stroke-1,6)) / 2);
                    Temp(stroke,3) = acceleration;
                end

                % velocity
                V = Temp(1:pend-pstart,2);
                RESULT(k, 1) = mean(V);
                RESULT(k, 2) = std(V);
                Q = quantile(V,[0.25 0.50 0.75]);
                RESULT(k, 3:5) = Q;

                % acceleration
                A = Temp(1:pend-pstart-1,3);
                RESULT(k, 6) = mean(A);
                RESULT(k, 7) = std(A);
                Q = quantile(A,[0.25 0.50 0.75]);
                RESULT(k, 8:10) = Q;

                % preasure
                P = D(pstart:pend, 4);
                RESULT(k, 11) = mean(P);
                RESULT(k, 12) = std(P);
                Q = quantile(P,[0.25 0.50 0.75]);
                RESULT(k, 13:15) = Q;

                % area measurement
                AM = D(pstart:pend, 5);
                RESULT(k, 16) = mean(AM);
                RESULT(k, 17) = std(AM);
                Q = quantile(AM,[0.25 0.50 0.75]);
                RESULT(k, 18:20) = Q;

                RESULT(k, 21:22) = D(pstart, 2:3);
                RESULT(k, 23:24) = D(pend, 2:3);
                RESULT(k, 25) = sqrt((D(pstart,2) - D(pend,2))^2 + (D(pstart,3) - D(pend,3))^2);
                RESULT(k, 26) = (D(pend, 6) - D(pstart, 6));
                RESULT(k, 27) = (D(pend, 3) - D(pstart, 3)) / (D(pend, 2) - D(pstart, 2));
                RESULT(k, 28) = sum(Temp(1:pend-pstart, 1));

                if (abs(RESULT(k, 27)) >= 1)
                    RESULT(k, 29) = 1;
                else 
                    RESULT(k, 29) = 0;
                end

                k = k + 1;

            end
            i = i + 1;
        end

        [m1,n1] = find(isnan(RESULT));
        RESULT(m1,:) = [];
        [m2,n2] = find(RESULT == inf);
        RESULT(m2,:) = [];
        [m3,n3] = find(RESULT == -inf);
        RESULT(m3,:) = [];
        RESULT(all(RESULT==0,2),:) = [];
        
        Name = strcat("Dataset/Human/Whole/Human", num2str(r));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, RESULT);
        fclose(fileID);
    end
end



%% Robot Feature Extraction


for r = 1 : 89
    Name = strcat("Dataset/Raw_Data/NAOSwipeData/Swipe", num2str(r));
    FileName = strcat(Name, ".txt");
    if exist(FileName, 'file')
        fileID = fopen(FileName);
        C = textscan(fileID, '%32f %32f %32f %32f %32f %32f %32f %32f %32f', 'Delimiter', ',');
        D = cell2mat(C(1:7));
        D(:,8) = cell2mat(C(9));


        [m,n] = size(D);
        Temp = ones(50,3);
        i = 1;
        k = 1;
        RESULT = ones(1, 29);
        while(i ~= m+1)
            if(D(i,1) == 0)
                pstart = i;
            elseif (D(i,1) == 1)
                pend = i;
%                 x = D(pstart:pend,4);
%                 y = D(pstart:pend,5);
%                 plot(x,y);
%                 hold on;

                for stroke = 1:pend-pstart %pstart:pend
                    distance = sqrt((D(pstart+stroke,4) - D(pstart+stroke-1,4))^2 + (D(pstart+stroke,5) - D(pstart+stroke-1,5))^2);
                    velocity = distance / (D(pstart+stroke,8) - D(pstart+stroke-1,8)) * 10^6;
                    Temp(stroke,1) = distance;
                    Temp(stroke,2) = velocity;
                end
                for stroke = 1:pend-pstart-1 %pstart:pend-1
                    acceleration = Temp(stroke+1,2) - Temp(stroke,2) / ((D(pstart+stroke+1,8) - D(pstart+stroke-1,8)) / 2)  * 10^6;
                    Temp(stroke,3) = acceleration;
                end

                % velocity
                V = Temp(1:pend-pstart,2);
                RESULT(k, 1) = mean(V);
                RESULT(k, 2) = std(V);
                Q = quantile(V,[0.25 0.50 0.75]);
                RESULT(k, 3:5) = Q;

                % acceleration
                A = Temp(1:pend-pstart-1,3);
                RESULT(k, 6) = mean(A);
                RESULT(k, 7) = std(A);
                Q = quantile(A,[0.25 0.50 0.75]);
                RESULT(k, 8:10) = Q;

                % preasure
                P = D(pstart:pend, 6);
                RESULT(k, 11) = mean(P);
                RESULT(k, 12) = std(P);
                Q = quantile(P,[0.25 0.50 0.75]);
                RESULT(k, 13:15) = Q;

                % area measurement
                AM = D(pstart:pend, 7);
                RESULT(k, 16) = mean(AM);
                RESULT(k, 17) = std(AM);
                Q = quantile(AM,[0.25 0.50 0.75]);
                RESULT(k, 18:20) = Q;

                RESULT(k, 21:22) = D(pstart, 4:5);
                RESULT(k, 23:24) = D(pend, 4:5);
                RESULT(k, 25) = sqrt((D(pstart,4) - D(pend,4))^2 + (D(pstart,5) - D(pend,5))^2);
                RESULT(k, 26) = (D(pend, 8) - D(pstart, 8)) / 10^6;
                RESULT(k, 27) = (D(pend, 5) - D(pstart, 5)) / (D(pend, 4) - D(pstart, 4));
                RESULT(k, 28) = sum(Temp(1:pend-pstart, 1));

                if (abs(RESULT(k, 27)) >= 1)
                    RESULT(k, 29) = 1;
                else 
                    RESULT(k, 29) = 0;
                end

                k = k + 1;

            end
            i = i + 1;
        end


        [m1,n1] = find(isnan(RESULT));
        RESULT(m1,:) = [];
        [m2,n2] = find(RESULT == inf);
        RESULT(m2,:) = [];
        [m3,n3] = find(RESULT == -inf);
        RESULT(m3,:) = [];
        RESULT(all(RESULT==0,2),:) = [];
        
        Name = strcat("Dataset/Robot/Whole/Robot", num2str(r));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, RESULT);
        
        fclose(fileID);
    end
end

