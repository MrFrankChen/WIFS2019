function createLineFigure(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 28-Jun-2019 23:52:30

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','SVM');
set(plot1(2),'DisplayName','LR');
set(plot1(3),'DisplayName','MLF');

% Create ylabel
ylabel('Mean EER (%)');

% Create xlabel
xlabel('User ID');

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 23]);
% Uncomment the following line to preserve the Y-limits of the axes
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'YGrid','on');
% Create legend
legend(axes1,'show');

