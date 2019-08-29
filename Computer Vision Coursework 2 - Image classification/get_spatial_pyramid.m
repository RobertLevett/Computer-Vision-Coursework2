function image_feats = get_spatial_pyramid(image_paths, colour, step_size, bin_size, magnif, max_level, file_path)
    load(file_path);
    im_feat_size = length(vocab(2,:)) * ((1/3) * ((4^(max_level+1))-1));
    image_feats = zeros(length(image_paths), im_feat_size);
    for i=1:length(image_paths)
        [flattened_features, all_locations, width, height] = extract_SIFT(colour,step_size, bin_size, magnif, { image_paths{i} });
        flattened_features = single(flattened_features);

%         max_level = 2;
        dimension = (2^max_level);
        origin_histograms = cell(dimension, dimension);
        for j=1:dimension
            for k=1:dimension
                origin_histograms{j,k} = zeros(1, length(vocab(2,:)));
            end
        end
        curX = 1;
        curY = 1;
        incrementWidth = width / dimension;
        incrementHeight = height / dimension;
        curWidth = incrementWidth;
        curHeight = incrementHeight;
        locations = all_locations{1};
        for j=1:length(locations)
            if locations(2,j) > curHeight
                curHeight = curHeight + incrementHeight;
                curY = curY + 1;
            end
            if locations(2,j) < (curHeight - incrementHeight)
                curY = 1;
                curHeight = incrementHeight;

            end
            if locations(1,j) > curWidth
                curWidth = curWidth + incrementWidth;
                curHeight = incrementHeight;
                curX = curX + 1;
                curY = 1;
            end
            
            curHighest = [1,Inf];
            for k=1:length(vocab(2,:))
                dist = vl_alldist2(vocab(:,k),flattened_features(:,j));
                if dist < curHighest(2)
                    curHighest(2) = dist;
                    curHighest(1) = k;
                end
            end
            origin_histograms{curX,curY}(curHighest(1)) = origin_histograms{curX,curY}(curHighest(1)) + 1;
        end
        
        levels = cell(1,max_level + 1);
        
        for j=1:length(levels)
            level_dim = 2^(j-1);
            levels{j} = cell(level_dim, level_dim);
            for k=1:level_dim
                for l=1:level_dim
                    levels{j}{k,l} = zeros(1, length(vocab(2,:)));
                end
            end
        end
        
        for j=1:dimension
            for k=1:dimension
                xy = [j k];
                for l=max_level:-1:1
                    xy = ceil(xy/2);
                    levels{l}{xy(1), xy(2)} = levels{l}{xy(1), xy(2)} + origin_histograms{j,k};
                end
            end
        end
        levels{max_level + 1} = origin_histograms;
        im_feat = [];
        for j=max_level:-1:0
            level_dim = 2^((j+1)-1);
            if j == 0
                weighting = 1/(2^max_level);
            else
                weighting = 1/(2^(max_level-j+1));
            end
            for k=1:level_dim
                for l=1:level_dim
                    im_feat = [im_feat levels{j+1}{k,l} * weighting];
                end
            end           
        end
        
        image_feats(i, :) = im_feat;
    end
end

