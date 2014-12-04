method = 'RandomForest'; % 'kNN' 'RandomForest'

MyStyles = {'-*';'-';':+';'--';'-.'};

%knn
if strcmp(method, 'kNN')
    load('knnResults.mat');
    n = numel(knnResults);

    X = knnResults(1).allParams;
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
    ylabel('Accuracy');
    legend(allLegends);


%rf
elseif strcmp(method, 'RandomForest')
    load('rfResults.mat');
    n = numel(rfResults);

    X = rfResults(1).allParams;
    allY = zeros(n,size(X,2));
    allLegends = cell(1,n);
    for i=1:n
        r = rfResults(i);
        allY(i,:) = r.acc;
        allLegends{i} = [r.featureMethod ' - ' r.redMethod ' ' num2str(r.nDims)  ' dims'];
    end

    set(0,'DefaultAxesColorOrder',[1 0 0; 0 0 1; 0.3 1 0.3])
    set(0,'DefaultAxesLineStyleOrder',MyStyles)
    p = plot(X,allY, 'LineWidth', 2);
    title('Random Forest Performance over 43 classes');
    xlabel('Number of Trees');
    ylabel('Accuracy');
    legend(allLegends);

end

