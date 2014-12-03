MyStyles = {'-*';'-';':+';'--';'-.'};

%knn
load('knnResults.mat');
n = numel(knnResults);

X = knnResults(1).allK;
allY = zeros(n,size(X,2));
allLegends = cell(1,n);
for i=1:n
    r = knnResults(i);
    allY(i,:) = r.acc;
    allLegends{i} = [r.featureMethod ' - ' r.redMethod ' ' num2str(r.nDims)  ' dims'];
end

set(0,'DefaultAxesColorOrder',[1 0 0; 0 0 1; 0.3 1 0.3])
set(0,'DefaultAxesLineStyleOrder',MyStyles)
p = plot(X,allY, 'LineWidth', 2);
title('K-NN Performance over 43 classes');
xlabel('K');
ylabel('accuracy');
legend(allLegends);
