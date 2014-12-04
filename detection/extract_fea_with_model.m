function [ train_fea, neg_feas ] = extract_fea_with_model( I, leftCol, topRow, rightCol, bottomRow, model )
%DETECTION Summary of this function goes here
%   Detailed explanation goes here

square_size = 30;


g = rgb2gray(I);
gt_patch = g(topRow:bottomRow, leftCol:rightCol);
rescaled_gt_patch = imresize(gt_patch, [square_size square_size]);

train_fea = extractHOGFeatures(rescaled_gt_patch,'CellSize',[5 5]);

[m, n, ~] = size(I);

patch_width = rightCol-leftCol;
patch_hight = bottomRow - topRow;

neg_feas = [];
for t=1:100
    r = randi([1, m-patch_hight-1]);
    r2 = randi([1, n-patch_width-1]);
    [ sim ] = jaccard( r2, r, r2+patch_width, r+patch_hight, leftCol, topRow, rightCol, bottomRow );
    if (sim > 0.5)
        continue
    end
    r = uint8(r);
    r2 = uint8(r2);
    patch_hight = uint8(patch_hight);
    patch_width = uint8(patch_width);
    ngt_patch = g(r:r+patch_hight, r2:r2+patch_width);
    rescaled_gt_patch = imresize(ngt_patch, [square_size square_size]);
    neg_feas = [neg_feas; extractHOGFeatures(rescaled_gt_patch,'CellSize',[5 5])];
end

end

