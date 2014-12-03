function [reduced_features] = reduceDimension(features, nDims)
    
    %covMat = cov(features');
    %[reduced_features,~]=eigs(double(covMat),nDims);
    
    %standardized variables
    %[~,scores] = princomp(zscore(features));
    
    %non-standarized variables
    [~,scores] = princomp(features);
    reduced_features = scores(:,1:nDims);
end