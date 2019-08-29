colour_types = {"hsv"};
vocab_sizes = {10, 50, 100, 200, 300};
% vocab_sizes = {300};
vocab_step_sizes = {5};
vocab_bin_sizes = {3};
feats_step_sizes = {1,2,5,10};
feats_bin_sizes = {3, 5, 10};

fprintf("loading values...\n");
load('values.mat');
fprintf("Running vl_setup...\n");
run('/gpfs/home/zhv14ybu/computervision/cw2/vlfeat-0.9.21/toolbox/vl_setup');

fprintf("Baggining feature creation...\n");
for i=1:length(colour_types)
    for k=1:length(vocab_step_sizes)
        for l=1:length(vocab_bin_sizes)
%             [all_features,all_locations] = extract_SIFT(colour_types{i}, vocab_step_sizes{k}, vocab_bin_sizes{l}, 3, train_image_paths);
%             fprintf("BUILDING: " + '_' + colour_types{i} + '_' + vocab_step_sizes{k} + '_' + vocab_bin_sizes{l});
            for j=1:length(vocab_sizes)
%                 vocab = build_vocabulary(all_features,vocab_sizes{j});
                vocab_path = "vocab/vocab_"+vocab_sizes{j} + '_' + colour_types{i} + '_' + vocab_step_sizes{k} + '_' + vocab_bin_sizes{l};
%                 load(filename);
                for m=1:length(feats_step_sizes)
                    for n=1:length(feats_bin_sizes)
                        feat_filename = "spatial_" + vocab_sizes{j} + '_' + colour_types{i} + '_' + vocab_step_sizes{k} + '_' + vocab_bin_sizes{l} + '_' + feats_step_sizes{m} + '_' + feats_bin_sizes{n};
                        fprintf("CREATING TRAIN: " + feat_filename + "\n");
                        train_features = get_spatial_pyramid(train_image_paths, colour_types{i}, feats_step_sizes{m}, feats_bin_sizes{n}, 3, 2, vocab_path);
                        save("train/" + feat_filename, 'train_features');
                        fprintf("CREATING TEST: " + feat_filename + "\n");
                        test_features = get_spatial_pyramid(test_image_paths, colour_types{i}, feats_step_sizes{m}, feats_bin_sizes{n}, 3, 2, vocab_path);
                        save("test/" + feat_filename, 'test_features');
                    end
                end
            end
        end
    end
end