function [FinalFeatures, Merit] = CFS(OD)

corrMatrix = abs(corr(OD));

corrMatrix(end,:) = [];

% H = heatmap(corrMatrix);

[m, i] = max(corrMatrix(:,30));

Features = zeros(1,1);

Features(1,1) = i;
FinalFeatures = Features;
Merit = 0;

k = 1;

while(k ~= 29)
    k = k + 1;
    [F,M] = calculateMerit(corrMatrix, Features);
    Features(1,k) = F;
    if (M > Merit)
        Merit = M;
        FinalFeatures = Features;
    end
end

