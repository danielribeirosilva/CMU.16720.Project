addpath('data');

%params
CellSizes=cell(1,3);
CellSizes{1} = [14 14];
CellSizes{2} = [7 7];
CellSizes{3} = [4 4];
BlockSize = [2 2];
weights = [1 2 4];
nDims = 30;

%data
folderNums = 0:42;
allFeatures = [];
allLabels = [];
%extract data
for folder = folderNums
    folderName = getFolderName(folder);
    files = dir(['data/' folderName '/*.ppm']);
    fprintf('Processing images for class %s...\n', folderName);
    for file = files'
        if file.name(1)=='.'
            continue
        end
        filePath = ['data/' folderName '/' file.name];
        
        %standard image format
        I = imread(filePath);
        I = rgb2gray(I);
        I = imresize(I, [28 28]);

        %get features
        features = extractFeatures(I, CellSizes, BlockSize, weights);
        allFeatures = [allFeatures; features];
        allLabels = [allLabels; folder];
    end 
end

%reduce dimension
reduced_features = reduceDimension(allFeatures, nDims);

%shuffle data
perm = randperm(size(reduced_features,1));
data = reduced_features(perm,:);
labels = allLabels(perm,:);

%------------------
% CLASSIFY
%------------------

%K-NN 
m = 10;
for K=1:20
    [acc] = mFoldKnn(data, labels, K, m);
end










