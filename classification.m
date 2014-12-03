addpath('data');

%params
CellSize=cell(1,3);
CellSize{1} = [14 14];
CellSize{2} = [7 7];
CellSize{3} = [4 4];
BlockSize = [2 2];
weights = [1 2 4];

I = imread('data/00/00003.ppm');

I = rgb2gray(I);

I = imresize(I, [28 28]);

total_hog = [];
for i=1:numel(CellSize)
    [hog, ~] = extractHOGFeatures(I,'CellSize', CellSize{i}, 'BlockSize', BlockSize);
    hog = weights(i)*hog/norm(hog);
    total_hog = [total_hog hog];
end

total_hog = total_hog/norm(total_hog);

