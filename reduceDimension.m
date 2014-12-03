function [reduced_features] = reduceDimension(features, nDims)
    
    %covMat = cov(features');
    %[reduced_features,~]=eigs(double(covMat),nDims);
    
    [~,scores] = princomp(zscore(features));
    reduced_features = scores(:,1:nDims);
end