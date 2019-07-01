function JSD = JSDiv(P,Q)
    % Jensen-Shannon divergence of two probability distributions
    %  dist = JSD(P,Q) Kullback-Leibler divergence of two discrete probability
    %  distributions
    %  P and Q  are automatically normalised to have the sum of one on rows
    % have the length of one at each 
    % P =  n x nbins
    % Q =  1 x nbins
    % dist = n x 1

%     if size(P,2)~=size(Q,2)
%         error('the number of columns in P and Q should be the same');
%     end

    % normalizing the P and Q
%     Q = Q ./sum(Q);
%     Q = repmat(Q,[size(P,1) 1]);
%     P = P ./repmat(sum(P,2),[1 size(P,2)]);

    if (size(unique(P)) == 1 | size(unique(Q)) == 1)
        JSD = 0;
    else 

        low = min(min(P), min(Q));
        high = max(max(P), max(Q));
        step = (high - low) / 100;
        edges = low : step : high;

        Pd = discretize(P,edges);
        Qd = discretize(Q,edges);

        Pt = tabulate(Pd);
        Qt = tabulate(Qd);


        Pf = [zeros(Pt(1,1) - 1, 1); Pt(:,2); zeros(100 - Pt(end,1), 1)];
        Qf = [zeros(Qt(1,1) - 1, 1); Qt(:,2); zeros(100 - Qt(end,1), 1)];

        Pp = Pf ./ sum(Pf);
        Qp = Qf ./ sum(Qf);
        Mp = 0.5 .* (Pp + Qp);
        
        JSD = 0.5 * KLDiv(Pp, Mp) + 0.5 * KLDiv(Qp, Mp);
    end
end