function ConfusionMatrix = getConfusionMatrix(True, Predict)

    tp = sum(True(:,1) == 0 & Predict(:,1) == 0);
    fn = sum(True(:,1) == 0 & Predict(:,1) == 1);
    fp = sum(True(:,1) == 1 & Predict(:,1) == 0);
    tn = sum(True(:,1) == 1 & Predict(:,1) == 1);
    
    ConfusionMatrix(1,1) = tp;
    ConfusionMatrix(1,2) = fp;
    ConfusionMatrix(1,3) = fn;
    ConfusionMatrix(1,4) = tn;

    accuracy = (tp + tn) / length(True);
    FAR = fp / (fp + tn);
    FRR = fn / (tp + fn);
    ConfusionMatrix(1,5) = accuracy;
    ConfusionMatrix(1,6) = FAR;
    ConfusionMatrix(1,7) = FRR;
end

