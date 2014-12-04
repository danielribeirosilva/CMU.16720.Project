function [ ot ] = run( gt_train_file, gt_test_file, data_path )
[ SVMModel ] = train( gt_train_file, data_path )
gt_test=load(gt_test_file);
ot = [];
for i=1:size(gt_test,1);
    test_file2 = sprintf('%05d.ppm', gt_test(i,1));
    test_file = sprintf('%s/%s', data_path, test_file2);
    I = imread(test_file);
    [ res ] = testing(I, SVMModel, 10, gt_test(i,2),gt_test(i,3),gt_test(i,4),gt_test(i,5));
    ot = [ot; res];
end

end

