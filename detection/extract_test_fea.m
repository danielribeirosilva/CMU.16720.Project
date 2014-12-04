function [ fea ] = extract_test_fea( I, leftCol, topRow, rightCol, bottomRow )
%DETECTION Summary of this function goes here
%   Detailed explanation goes here

square_size = 30;


g = rgb2gray(I);
gt_patch = g(topRow:bottomRow, leftCol:rightCol);
rescaled_gt_patch = imresize(gt_patch, [square_size square_size]);

fea = extractHOGFeatures(rescaled_gt_patch,'CellSize',[5 5]);

end

