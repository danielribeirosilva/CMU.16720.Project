function [ r ] = jaccard( leftCol, topRow, rightCol, bottomRow, leftCol2, topRow2, rightCol2, bottomRow2 )
%JACCARD Summary of this function goes here
%   stupid way
row_min = min(topRow, topRow2);
col_min = min(leftCol, leftCol2);
row_max = max(bottomRow, bottomRow2);
col_max = max(rightCol, rightCol2);

A = [topRow, leftCol, rightCol - leftCol+1, bottomRow - topRow+1];
B = [topRow2, leftCol2, rightCol2 - leftCol2+1, bottomRow2 - topRow2+1];
area = rectint(A,B);

row_dim = row_max - row_min + 1;
col_dim = col_max - col_min + 1;

total_area = row_dim * col_dim;

r = area / total_area;
end

