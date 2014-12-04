addpath('data/GTSD/FullIJCNN2013');

%general params
dataPath = 'data/GTSD/FullIJCNN2013';

%algorithm params
CellSizes=cell(1,3);
CellSizes{1} = [14 14];
CellSizes{2} = [7 7];
CellSizes{3} = [4 4];
BlockSize = [2 2];
weights = [1 2 4];
nDims = 30;
redMethod = 'KPCA';
featureMethod = 'HOG_I';


%data
folderNums = 0:42;
allFeatures = [];
allLabels = [];


%extract data
for folder = folderNums
    folderName = getFolderName(folder);
    files = dir([dataPath '/' folderName '/*.ppm']);
    fprintf('Processing images for class %s...\n', folderName);
    for file = files'
        if file.name(1)=='.'
            continue
        end
        filePath = [dataPath '/' folderName '/' file.name];
        
        %standard image size
        I = imread(filePath);
        I = imresize(I, [28 28]);

        %get features
        features = extractFeatures(I, CellSizes, BlockSize, weights, featureMethod);
        allFeatures = [allFeatures; features];
        allLabels = [allLabels; folder];
    end 
end

%reduce dimension
reduced_features = reduceDimension(allFeatures, nDims, redMethod, allLabels);

%shuffle data
perm = randperm(size(reduced_features,1));
data = reduced_features(perm,:);
labels = allLabels(perm,:);

%------------------
% CLASSIFY
%------------------

%K-NN 
m = 10;
allK = 1:20;
acc = zeros(1,numel(allK));
for i=1:numel(allK)
    K = allK(i);
    acc(i) = mFoldKnn(data, labels, K, m);
    fprintf('K-NN accuracy for K=%i: %f\n', K, acc(i));
end


%record results
result.nDims = nDims;
result.featureMethod = featureMethod;
result.redMethod = redMethod;
result.acc = acc;
result.allK = allK;






