function [reduced_features] = reduceDimension(features, nDims, method, labels)
    
    %covMat = cov(features');
    %[reduced_features,~]=eigs(double(covMat),nDims);
    
    %standardized variables
    if strcmp(method, 'PCAStandarized')
        [~,scores] = princomp(zscore(features));
        reduced_features = scores(:,1:nDims);
    
    %non-standarized variables
    elseif strcmp(method, 'PCA')
        [~,scores] = princomp(features);
        reduced_features = scores(:,1:nDims);
    
    %Kernel PCA
    elseif strcmp(method, 'KPCA')
        options.KernelType = 'Gaussian';
        options.t = 1;
        options.ReducedDim = nDims;
        [eigvector, ~] = KPCA(features, options);
        reduced_features = eigvector;
    
    %LDA
    elseif strcmp(method, 'LDA')
        options = [];
       options.Fisherface = 1;
       [eigvector, ~] = LDA(labels, options, features);
       reduced_features = eigvector(:,1:nDims);
     
    else
        reduced_features = [];
        fprintf('Error: Method does not exist or not specified\n');
    end
end