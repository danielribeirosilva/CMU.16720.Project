function run( gt_train_file, gt_test_file, datapath )
% [ SVMModel ] = train( gt_train_file, data_path )
% gt_test=load(gt_test_file);
% ot = [];
% for i=1:size(gt_test,1)
%     test_file2 = sprintf('%05d.ppm', gt_test(i,1));
%     test_file = sprintf('%s/%s', data_path, test_file2);
%     I=imread(test_file);
%     fea = extract_test_fea( I, leftCol, topRow, rightCol, bottomRow );
%     [ res ] = testing(I, SVMModel, 10, gt_test(i,2),gt_test(i,3),gt_test(i,4),gt_test(i,5));
%     ot = [ot; res];
% end

%TRAIN Summary of this function goes here
%   Detailed explanation goes here
gt=load(gt_train_file);
pos_feas = [];
neg_feas = [];
for i=1:size(gt,1)
    fprintf('current training image: %i\n', i);
    filename = sprintf('%05d.ppm', gt(i,1));
    filename = sprintf('%s/%s', datapath, filename);
    I=imread(filename);
    [ pos_fea, neg_fea ] = extract_fea( I, gt(i,2), gt(i,3), gt(i,4), gt(i,5) );
    pos_feas = [pos_feas;pos_fea];
    neg_feas = [neg_feas;neg_fea];
end

test_pos_feas = [];
test_neg_feas = [];
gtest=load(gt_test_file);
for i=1:size(gtest,1)
    fprintf('current testing image: %i\n', i);
    filename = sprintf('%05d.ppm', gtest(i,1));
    filename = sprintf('%s/%s', datapath, filename);
    I=imread(filename);
    [ test_pos_fea, test_neg_fea ] = extract_fea( I, gtest(i,2), gtest(i,3), gtest(i,4), gtest(i,5) );
    test_pos_feas = [test_pos_feas;test_pos_fea];
    test_neg_feas = [test_neg_feas;test_neg_fea];
end

reduceMatrix=[pos_feas; neg_feas; test_pos_feas; test_neg_feas];
[~,scores] = princomp(reduceMatrix);
reduced_features = scores(:,1:50);
num_train_pos = size(pos_feas, 1);
num_train_neg = size(neg_feas, 1);
num_test_pos = size(test_pos_feas, 1);
num_test_neg = size(test_neg_feas, 1);
Y = zeros(num_train_pos+num_train_neg, 1);
Y(1:num_train_pos) = 1;
Yt = zeros(num_test_pos+num_test_neg, 1);
Yt(1:num_test_pos) = 1;
SVMModel = fitcsvm(reduceMatrix(1:num_train_pos+num_train_neg, :),Y,'KernelFunction','rbf');
[label,score] = predict(SVMModel,reduceMatrix(1:num_train_pos+num_train_neg, :));
trainingAcc = size(find(label==Y),1)/size(Y,1);
fprintf('training accuracy: %f\n', trainingAcc);
[label,score] = predict(SVMModel,reduceMatrix(num_train_pos+num_train_neg+1:num_train_pos+num_train_neg+num_test_pos+num_test_neg, :));
testingAcc = size(find(label==Yt),1)/size(Yt,1);
fprintf('training accuracy: %f\n', testingAcc);
end

