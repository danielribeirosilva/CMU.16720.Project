function [ res ] = testing( I, SVMModel, cut_off, leftCol, topRow, rightCol, bottomRow)
%TESTING Summary of this function goes here
%   Detailed explanation goes here
ratio = [0.8 0.9 1.0 1.1 1.2];

% 16*16 : 128 * 128
scale = 16:5:128;
g = rgb2gray(I);
[m, n] = size(g);
num_ratio = numel(ratio);
num_scale = numel(scale);

square_size = 30;
gt_patch = g(topRow:bottomRow, leftCol:rightCol);
rescaled_gt_patch = imresize(gt_patch, [square_size square_size]);

test_fea = extractHOGFeatures(rescaled_gt_patch,'CellSize',[5 5]);
[label,score] = predict(SVMModel,test_fea);
res = label;
return
res=[];
for i=1:num_ratio
    for j=1:num_scale
        win_size = [scale(j),  scale(j) * ratio(i)]; % height, width
        win_size=round(win_size);
        for p=1:m
            if p+win_size(1) > m
                continue
            end
            for q=1:n
                if q + win_size(2) > n
                    continue
                end
                patch = g(p:p+win_size(1), q:q+win_size(2));
                rescaled_patch = imresize(patch, [square_size square_size]);

                test_fea = extractHOGFeatures(rescaled_patch,'CellSize',[5 5]);
                [label,score] = predict(SVMModel,test_fea);
                if label == 0
                    continue
                end
                res=[res; score, p, q, win_size(1), win_size(2)];
            end
        end
    end
end
res = sortrows(res,1);
end

