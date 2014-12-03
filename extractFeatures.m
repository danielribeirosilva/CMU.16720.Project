function [features] = extractFeatures(I, CellSizes, BlockSize, weights)

total_hog = [];
for i=1:numel(CellSizes)
    [hog, ~] = extractHOGFeatures(I,'CellSize', CellSizes{i}, 'BlockSize', BlockSize);
    hog = weights(i)*hog/norm(hog);
    total_hog = [total_hog hog];
end

features = total_hog/norm(total_hog);


end