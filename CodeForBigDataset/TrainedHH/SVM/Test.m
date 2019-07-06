k = 1;

% F = [24, 16, 12, 22, 26, 17, 13, 29];

% F = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28];

% F = [24, 16, 12, 22, 26, 17, 13, 29, 21, 28, 2, 25, 3, 8, 27];

F = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29];

SCORE1 = zeros(1,4);
SCORE2 = zeros(1,4);
SCORE3 = zeros(1,4);

flag = 0;

for i = 1 : 197

%         Name = strcat("TrainedHH/SVM/Model8F/Model", num2str(i));
%         Name = strcat("TrainedHH/SVM/Model10F/Model", num2str(i));
%         Name = strcat("TrainedHH/SVM/Model15F/Model", num2str(i));
        Name = strcat("TrainedHH/SVM/Model29F/Model", num2str(i));
        ModelName = strcat(Name, ".mat");
        if exist(ModelName,"file")
            Model_Mat = load(ModelName);
%             SVMModel = Model_Mat.SVMModel1;
%             SVMModel = Model_Mat.SVMModel2;
%             SVMModel = Model_Mat.SVMModel3;
            SVMModel = Model_Mat.SVMModel0;


            % Test 1
            TestName = strcat("Dataset/HH/Test1/Test", num2str(i));
            
            TestName = strcat(TestName, ".csv");
            TestData1 = csvread(TestName);
            [m1,n1] = size(TestData1);
            newX1 = zeros(m1,length(F));

            r = 1;
            for j = 1 : 29
                if (ismember(j,F))
                    newX1(:,r) = TestData1(:,j);
                    r = r + 1;
                end
            end
            
            % Test 2
            TestName = strcat("Dataset/HH/Test2/Test", num2str(i));
            
            TestName = strcat(TestName, ".csv");
            TestData2 = csvread(TestName);
            [m2,n2] = size(TestData2);
            newX2 = zeros(m2,length(F));

            r = 1;
            for j = 1 : 29
                if (ismember(j,F))
                    newX2(:,r) = TestData2(:,j);
                    r = r + 1;
                end
            end


            [label1,score1] = predict(SVMModel,newX1);
            Temp1 = [score1, TestData1(:,30), label1];
            [EER1, Threshold1] = calculateEER(Temp1);
            
%             CM11 = getConfusionMatrix(TestData1(:,30), label1);
%             labelEER1 = predictByEER(score1, Threshold1);
%             CM12 = getConfusionMatrix(TestData1(:,30), labelEER1);
            
            
            [label2,score2] = predict(SVMModel,newX2);
            Temp2 = [score2, TestData2(:,30), label2];
            [EER2, Threshold2] = calculateEER(Temp2);
            
%             CM21 = getConfusionMatrix(TestData2(:,30), label2);
%             labelEER2 = predictByEER(score2, Threshold2);
%             CM22 = getConfusionMatrix(TestData2(:,30), labelEER2);
            
            
            RESULT(k, 1) = i;
            RESULT(k, 2) = length(find(TestData1(:,30) == label1)) / m1;
            RESULT(k, 3) = EER1;
            RESULT(k, 4) = Threshold1;
            RESULT(k, 5) = length(find(TestData2(:,30) == label2)) / m2;
            RESULT(k, 6) = EER2;
            RESULT(k, 7) = Threshold2;
            
%             B(k, 1) = i;
%             B(k, 2:3) = CM11(1, 6:7);
%             B(k, 4:5) = CM21(1, 6:7);
%             B(k, 6:7) = CM31(1, 6:7);
            


            k = k + 1;
            
            if (i == 138)
                Temp = RESULT;
                Temp(k, :) = sum(Temp) / (k-1);
%                 csvwrite("TrainedHH/SVM/Result/Portrait8F.csv", Temp);
%                 csvwrite("TrainedHH/SVM/Result/Portrait10F.csv", Temp);
%                 csvwrite("TrainedHH/SVM/Result/Portrait15F.csv", Temp);
                csvwrite("TrainedHH/SVM/Result/Portrait29F.csv", Temp);
                flag = k;
            end

            if (i == 197)
                Temp = RESULT(flag:k-1, :);
                Temp(k-flag+1, :) = sum(Temp) / (k-flag);
%                 csvwrite("TrainedHH/SVM/Result/Landscape8F.csv", Temp);
%                 csvwrite("TrainedHH/SVM/Result/Landscape10F.csv", Temp);
%                 csvwrite("TrainedHH/SVM/Result/Landscape15F.csv", Temp);
                csvwrite("TrainedHH/SVM/Result/Landscape29F.csv", Temp);
            end

        end
end





