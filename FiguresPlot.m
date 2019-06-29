%% Line Plot

load('mat/EER8F.mat');
createLineFigure(EER8F);

load('mat/EER15F.mat');
createLineFigure(EER15F);

load('mat/EER29F.mat');
createLineFigure(EER29F);


%% Box Plot
load('mat/NNEER.mat');
boxplot(NNEER, 'Widths', 0.2, 'Labels',{'F_id: 27','F_id: 27, 15', 'F_id: 27, 15, 26, 19', '29 Features'});
hold on;
xmean = sum(NNEER) / length(NNEER);
plot(xmean');


%% 
