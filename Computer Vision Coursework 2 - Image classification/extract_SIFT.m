function [flattened_features, all_locations, heights, widths] = extract_SIFT(colour,step_size, bin_size, magnif, image_paths)

switch lower(colour)
    case 'gray'
        all_features = cell(1,1);
        all_locations = cell(1,1);
        image_process = @rgb2gray;
    case 'hsv'
        all_features = cell(1,3);
        all_locations = cell(1,3);
        image_process = @rgb2hsv;
    case 'opp'
        all_features = cell(1,3);
        all_locations = cell(1,3);
        image_process = @rgb2opp;
end

heights = [];
widths = [];


for i=1:length(image_paths)
   img = imread(image_paths{i});
   img = single(image_process(img));
   img = vl_imsmooth(img, sqrt((bin_size/magnif)^2 - .25)) ;

   widths = length(img(:,2,:));
   heights = length(img(1,:,:));

   for j=1:length(all_features)
       [locations, SIFT_features] = vl_dsift(single(img(:,:,j)),'FAST','SIZE', bin_size, 'STEP', step_size);
        all_features{j} = [all_features{j} SIFT_features];
        all_locations{j} = [all_locations{j} locations];
   end
end
flattened_features = [];
flattened_locations = [];
for i=1:length(all_features)
    flattened_features = [flattened_features; all_features{i}];
    flattened_locations = [flattened_locations; all_locations{i}];
end

end
