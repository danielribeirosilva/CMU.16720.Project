function [acc] = mFoldRandomForest(data, labels, nTrees, m)

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

        %build random forest
        B = TreeBagger(nTrees,train_data,train_label, 'Method', 'classification');

        %classify
        pred_label = B.predict(test_data);
        pred_label = str2double(pred_label);

        %store
        Pred(test_idx) = pred_label;
        TrueL(test_idx) = test_label;

        %evaluate
        accuracy = mean(pred_label==test_label);
        Accuracy(i) = accuracy;
    end

    acc = mean(Accuracy);
  

end