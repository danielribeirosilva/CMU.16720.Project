function [features] = extractFeatures(I, CellSizes, BlockSize, weights, method)

features = [];

% HOG + I (grayscale)
if strcmp(method, 'HOG_I')
    
    I = rgb2gray(I);
    total_hog = [];
    for i=1:numel(CellSizes)
        [hog, ~] = extractHOGFeatures(I,'CellSize', CellSizes{i}, 'BlockSize', BlockSize);
        hog = weights(i)*hog/norm(hog);
        total_hog = [total_hog hog];
    end
    features = total_hog/norm(total_hog);
   

else
    fprintf('Error: Method does not exist or not specified\n');
end


end