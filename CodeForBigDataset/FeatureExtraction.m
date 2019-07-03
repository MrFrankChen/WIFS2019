% D = importdata("Dataset/Raw_Data/PortraitSession1.mat");
% D = importdata("Dataset/Raw_Data/LandscapeSession1.mat"); 
% D = importdata("Dataset/Raw_Data/PortraitSession2.mat");
D = importdata("Dataset/Raw_Data/LandscapeSession2.mat");

[m,n] = size(D);
i = 1;
swipe = 1;
user = D(1,1);
pstart = 1;
pend = 1;

ustart = 1;
uend = 1;
TT = ones(30000,29);
rstart = 1;
rend = 1;

for k = 1 : m
    if (D(k,1) ~= user || k == m)
        RESULT = ones(1, 29);
        uend = k;
        swipe = 1;
        for i = ustart:uend
            if ( D(i,2) ~= swipe || i == m)
                Temp = ones(1,3);
                pend = i - 1;
%               x = D(pstart:pend,3);
%               y = D(pstart:pend,4);
%               LS1(pstart,8) = 1;
%               plot(x,y);
%               hold on;

                for stroke = 1:pend-pstart %pstart:pend
                    distance = sqrt((D(pstart+stroke,3) - D(pstart+stroke-1,3))^2 + (D(pstart+stroke,4) - D(pstart+stroke-1,4))^2);
                    velocity = distance / (D(pstart+stroke,7) - D(pstart+stroke-1,7));
                    Temp(stroke,1) = distance;
                    Temp(stroke,2) = velocity;
                end
                for stroke = 1:pend-pstart-1 %pstart:pend-1
                    acceleration = Temp(stroke+1,2) - Temp(stroke,2) / ((D(pstart+stroke+1,7) - D(pstart+stroke-1,7)) / 2) ;
                    Temp(stroke,3) = acceleration;
                end

                % velocity
                V = Temp(1:pend-pstart,2);
                RESULT(swipe, 1) = mean(V);
                RESULT(swipe, 2) = std(V);
                Q = quantile(V,[0.25 0.50 0.75]);
                RESULT(swipe, 3:5) = Q;

                % acceleration
                A = Temp(1:pend-pstart-1,3);
                RESULT(swipe, 6) = mean(A);
                RESULT(swipe, 7) = std(A);
                Q = quantile(A,[0.25 0.50 0.75]);
                RESULT(swipe, 8:10) = Q;

                % preasure
                P = D(pstart:pend, 5);
                RESULT(swipe, 11) = mean(P);
                RESULT(swipe, 12) = std(P);
                Q = quantile(P,[0.25 0.50 0.75]);
                RESULT(swipe, 13:15) = Q;

                % area measurement
                AM = D(pstart:pend, 6);
                RESULT(swipe, 16) = mean(AM);
                RESULT(swipe, 17) = std(AM);
                Q = quantile(AM,[0.25 0.50 0.75]);
                RESULT(swipe, 18:20) = Q;

                RESULT(swipe, 21:22) = D(pstart, 3:4);
                RESULT(swipe, 23:24) = D(pend, 3:4);
                RESULT(swipe, 25) = sqrt((D(pstart,3) - D(pend,3))^2 + (D(pstart,4) - D(pend,4))^2);
                RESULT(swipe, 26) = D(pend, 7) - D(pstart, 7);
                RESULT(swipe, 27) = (D(pend, 4) - D(pstart, 4)) / (D(pend, 3) - D(pstart, 3));
                RESULT(swipe, 28) = sum(Temp(1:pend-pstart, 1));

                if (abs(RESULT(swipe, 27)) >= 1)
                    RESULT(swipe, 29) = 1;
                else 
                    RESULT(swipe, 29) = 0;
                end

                pstart = i;
                swipe = swipe + 1;
            end
        end
        
        
        [m1,n1] = find(isnan(RESULT));
        RESULT(m1,:) = [];
        [m2,n2] = find(RESULT == inf);
        RESULT(m2,:) = [];
        [m3,n3] = find(RESULT == -inf);
        RESULT(m3,:) = [];
        RESULT(all(RESULT==0,2),:) = [];
        
        h = leverage(RESULT);
%         plot(h);
        m4 = find(h >= 0.5);
        RESULT(m4,:) = [];
        
%         Name = strcat("Dataset/Human/Whole/Train/Human", num2str(user));
        Name = strcat("Dataset/Human/Whole/Test/Human", num2str(user));
        FileName = strcat(Name, ".csv");
        csvwrite(FileName, RESULT);

        ustart = uend;
        user = D(ustart, 1);
    end  
end

