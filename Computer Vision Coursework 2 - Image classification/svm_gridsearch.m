function [results] = svm_gridsearch(params, train_image_paths, test_image_paths, trG, teG, filename)
vals = values(params);
set = cell(1, length(vals));
for i=1:length(vals)
    set{i} = vals{i};
end
all_combinations = cartesianProduct(set);

fprintf("ALL COMBOS: ");
fprintf("%d", length(all_combinations));
all_res = cell(length(all_combinations), 3);
for i=1:length(all_combinations)
    fprintf("\ni: ");
    fprintf("%d", i);
    fprintf("\n");
    colour_space = all_combinations(i,1);
    norm_method = all_combinations(i, 6);
    lambda = all_combinations(i, 5);
    lambda = lambda{1};
    num_iterations = all_combinations(i, 7);
    num_iterations = num_iterations{1};
    
    p = Inf;
    
    vocab_bin_size = all_combinations(i,8);
    vocab_bin_size = vocab_bin_size{1};
    vocab_step_size = all_combinations(i, 10);
    vocab_step_size = vocab_step_size{1};
    vocab_size = all_combinations(i, 9);
    vocab_size = vocab_size{1};
    feats_bin_size = all_combinations(i, 3);
    feats_bin_size = feats_bin_size{1};
    feats_step_size = all_combinations(i, 4);
    feats_step_size = feats_step_size{1};
    
    file_name = "" + vocab_size + '_' + colour_space{1} + '_' + vocab_step_size + '_' + vocab_bin_size + '_' + feats_step_size + '_' + feats_bin_size;
    
    switch char(all_combinations(i, 2))
        case 'spatial'
            load("train/spatial_" + file_name + ".mat");
            load("test/spatial_" + file_name + ".mat");

        case 'bags'
            load("train/bag_" + file_name + ".mat");
            load("test/bag_" + file_name + ".mat");
    end
    
    switch lower(char(norm_method))
        case 'l1'
            for j=1:length(train_features(:,1))
                train_features(j,:) = train_features(j,:)/norm(train_features(j,:), 1);
            end
            for j=1:length(test_features(:,1))
                test_features(j,:) = test_features(j,:)/norm(test_features(j,:),1);
            end
        case 'l2'
            for j=1:length(train_features(:,1))
                train_features(j,:) = train_features(j,:)/norm(train_features(j,:), 2);
            end
            for j=1:length(test_features(:,1))
                test_features(j,:) = test_features(j,:)/norm(test_features(j,:),2);
            end
    end
    
    labs = svm_classify(train_features, trG, test_features, lambda, num_iterations);
%     labs = fakeKnn(k, all_combinations{i,1},train, test, trG);
    acc = calAcc(labs, teG)
    all_res{i, 1} = labs;
    all_res{i, 2} = all_combinations(i, :);
    all_res{i, 3} = acc;
    save(filename, 'all_res');
   
end

results = all_res;
end

