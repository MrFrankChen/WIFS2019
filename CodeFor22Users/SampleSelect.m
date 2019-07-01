function [Matrix1, Matrix2] = SampleSelect(M, k1, k2)

[m1,n1] = size(M);
idx1 = randperm(m1);
idx1 = idx1(1:k1);
Matrix1 = M(idx1,:);
M(idx1,:) = [];

[m2,n2] = size(M);
idx2 = randperm(m2);
idx2 = idx2(1:k2);
Matrix2 = M(idx2,:);
