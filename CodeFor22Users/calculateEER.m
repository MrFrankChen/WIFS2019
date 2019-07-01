function [EER, Threshold] = calculateEER(Score)

[m,n]=find(isnan(Score)); 
Score(m,:)=[]; 
Score = sortrows(Score, -1);
% Score = sortrows(Score, -2);
% Score = unique(Score, 'row');


for i = 1 : length(Score)
    TPR(i,1) = sum(Score(1:i, 3) == 1) / sum(Score(:, 3) == 1); % FRR = 1 - TPR
    FPR(i,1) = sum(Score(1:i, 3) == 0) / sum(Score(:, 3) == 0); % FAR
end

FAR = FPR;
FRR = 1-TPR;

% plot(Score(:,1), FAR);
% hold on
% plot(Score(:,1), FRR);

for i = 1 : length(Score)-1
    if(FAR(i,1) - FRR(i,1) == 0)
        EER = FAR(i,1);
        Threshold = Score(i, 1);
        break;
    end
    if (FAR(i,1) - FRR(i,1) < 0 && FAR(i+1,1) - FRR(i+1,1) > 0)
        [Threshold,EER] = getIntersection(Score(i,1), FAR(i,1), Score(i+1,1), FAR(i+1,1), Score(i,1), FRR(i,1), Score(i+1,1), FRR(i+1,1));
        break;
    end
end




end

