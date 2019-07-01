% HH model
% Score = importdata("LR/LR2/Scores/F8Test1.mat");
% Score = importdata("LR/LR2/Scores/F8Test2.mat");
% Score = importdata("LR/LR2/Scores/F8Test3.mat");

% Score = importdata("LR/LR2/Scores/F10Test1.mat");
% Score = importdata("LR/LR2/Scores/F10Test2.mat");
% Score = importdata("LR/LR2/Scores/F10Test3.mat");

% Score = importdata("LR/LR2/Scores/F15Test1.mat");
% Score = importdata("LR/LR2/Scores/F15Test2.mat");
% Score = importdata("LR/LR2/Scores/F15Test3.mat");

% Score = importdata("LR/LR2/Scores/F29Test1.mat");
% Score = importdata("LR/LR2/Scores/F29Test2.mat");
% Score = importdata("LR/LR2/Scores/F29Test3.mat");


[m,n]=find(isnan(Score)); 
Score(m,:)=[]; 
Score = sortrows(Score, 1);
Score = unique(Score, 'row');




for i = 1 : length(Score)
    TPR(i,1) = sum(Score(1:i, 3) == 1) / sum(Score(:, 3) == 1); % FRR = 1 - TPR
    FPR(i,1) = sum(Score(1:i, 3) == 0) / sum(Score(:, 3) == 0); % FAR
end

FAR = FPR;
FRR = 1-TPR;

for i = 1 : length(Score)
    if (abs(FAR(i,1) - FRR(i,1)) <= 0.001)
        point = i;
        EER = FAR(i,1);
        break;
    end
end
far = sum(FAR) / length(FAR);
frr = sum(FRR) / length(FRR);

% plot(Score(:,1), FAR);
% hold on
% plot(Score(:,1), FRR);

% scatter(Score(:,1), FPR);
% hold on
% scatter(Score(:,1), 1-TPR);

