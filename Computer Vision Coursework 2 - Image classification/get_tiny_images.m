function [output] = get_tiny_images(data_path, size, colourSpace, norm_method)
output = zeros(length(data_path), size * size * 3);
if strcmp(colourSpace, 'gray')
    output = zeros(length(data_path), size * size);
end
for i=1:length(data_path)
    img = imread(data_path{i});
    switch lower(colourSpace)
        case 'ycbcr'
            img = rgb2ycbcr(img);
        case 'hsv'
            img = rgb2hsv(img);
        case 'lab'
            img = rgb2lab(img);
        case 'xyz'
            img = rgb2xyz(img);
        case 'gray'
            img = rgb2gray(img);
    end
    a = imresize(img, [size size]);
    img = reshape(a,[],1);
    img = double(img);
    switch lower(norm_method)
        case 'l1'
            output(i,:) = img/norm(img, 1);
        case 'l2'
            output(i,:) = img/norm(img, 2);
        otherwise
            output(i,:) = img;
    end
end
end

