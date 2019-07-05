function Label = predictByEER(Score,Threshold)

    for i = 1 : length(Score)
        if (Score(i,1) <= Threshold)
            Label(i,1) = 0;
        else 
            Label(i,1) = 1;
        end
    end
            
end

