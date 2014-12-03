function [acc] = mFoldKnn(data, labels, K, m)

    n = size(data, 1);
    test_size = floor(n/m);
    Accuracy = zeros(1,m);
    Pred = zeros(n,1);
    TrueL = zeros(n,1);

    for i=1:m

        %build train & test data sets
        test_idx = (1+(i-1)*test_size):(i*test_size);
        if i==m
            test_idx = (1+(i-1)*test_size):n;
        end
        train_idx = 1:n;
        train_idx(test_idx) = [];
        train_data = data(train_idx,:);
        train_label = labels(train_idx,:);
        test_data = data(test_idx,:);
        test_label = labels(test_idx,:);

        %classify
        %pred_label = knnclassify(test_data,train_data,train_label,K);
        mdl = fitcknn(train_data,train_label);
        mdl.NumNeighbors = K;
        pred_label = predict(mdl,test_data);

        %store
        Pred(test_idx) = pred_label;
        TrueL(test_idx) = test_label;

        %evaluate
        accuracy = mean(pred_label==test_label);
        Accuracy(i) = accuracy;
    end

    acc = mean(Accuracy);

end