load('values.mat');
c = containers.Map;
c('f_method') = {'bags'};
c('lr') = {1, 0.2, 0.5, 0.7, 0.01};
c('learners') = {10, 100, 200, 500};
c('norm_method') = {'l1', 'l2', 'none'};
c('vocab_size') = {10, 50, 100, 200, 300};
c('vocab_step_size') = {5};
c('vocab_bin_sizes') = {3};
c('feats_step_sizes') = {1,2,5,10};
c('feats_bin_sizes') = {3, 5, 10};
c('colour_spaces') = {'gray'};
fprintf("First grid");

res2 = ada_gridsearch(c,train_image_paths, test_image_paths, train_labels, test_labels, 'outputs/ada_gray_bag.mat');
