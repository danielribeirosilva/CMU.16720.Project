addpath('data');

%params
CellSizes=cell(1,3);
CellSizes{1} = [14 14];
CellSizes{2} = [7 7];
CellSizes{3} = [4 4];
BlockSize = [2 2];
weights = [1 2 4];

%data
folderNums = 1:10;

for folder = folderNums
    folderName = getFolderName(folder);
    files = dir(['data/' folderName '/*.ppm']);
    for file = files'
        if file.name(1)=='.'
            continue
        end
        filePath = ['data/' folderName '/' file.name];
        I = imread(filePath);
        
        
        
    end 
end



I = rgb2gray(I);

I = imresize(I, [28 28]);

[features] = extractFeatures(I, CellSizes, BlockSize, weights);







