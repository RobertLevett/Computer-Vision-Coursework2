function [outputArg1,outputArg2] = extract_all_features(inputArg1,inputArg2)
for i=1:length(image_paths)
   img = imread(image_paths{i});
   img = single(image_process(img));
    extract_SIFT(colour, step_size, img)
   [all_features, all_locations] = 
end
flattened_features = [];
flattened_locations = [];
for i=1:length(all_features)
    flattened_features = [flattened_features; all_features{i}];
    flattened_locations = [flattened_locations; all_locations{i}]
end
end

