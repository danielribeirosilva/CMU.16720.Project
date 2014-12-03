addpath('data');

%params
CellSizes=cell(1,3);
CellSizes{1} = [14 14];
CellSizes{2} = [7 7];
CellSizes{3} = [4 4];
BlockSize = [2 2];
weights = [1 2 4];

I = imread('data/00/00003.ppm');

I = rgb2gray(I);

I = imresize(I, [28 28]);

[features] = extractFeatures(I, CellSizes, BlockSize, weights);







