function [ SVMModel ] = train( gt_file, datapath )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
gt=load(gt_file);
pos_feas = [];
neg_feas = [];
for i=1:size(gt,1)
    filename = sprintf('%05d.ppm', gt(i,1));
    filename = sprintf('%s/%s', datapath, filename);
    I=imread(filename);
    [ pos_fea, neg_fea ] = extract_fea( I, gt(i,2), gt(i,3), gt(i,4), gt(i,5) );
    pos_feas = [pos_feas;pos_fea];
    neg_feas = [neg_feas;neg_fea];
end
[pos_num,~] = size(pos_feas);
[neg_num, ~] = size(neg_feas);
Y=zeros(pos_num+neg_num, 1);
Y(1:pos_num,:)=1;
SVMModel = fitcsvm([pos_feas;neg_feas],Y,'KernelFunction','rbf');
[label,score] = predict(SVMModel,[pos_feas; neg_feas]);
size(find(label==Y),1)/size(Y,1)
end

