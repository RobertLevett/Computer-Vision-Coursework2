function [label] = kNN(k, distType, p, train, test, train_labels)
distance = zeros(1, length(train(:, 1)));
label = cell(length(test(:,1)), 1);
for i=1:size(test)
    curHighest = [1,Inf];
    smallDist = cell(k,2);
    smallDist(:,1) = {Inf};
    for j=1:size(train)
        distance(i,j) = getDifference(train(j,:),test(i,:), distType, p);
        if distance(i,j) < curHighest(2)
            smallDist{curHighest(1),1} = distance(i,j);
            smallDist{curHighest(1),2} = train_labels{j};
        end
        [M,I] = max([smallDist{:,1}]);
        curHighest =[I,M];
    end
    y = unique(smallDist(:,2));
    n = zeros(length(y), 1);
    for iy = 1:length(y)
      n(iy) = length(find(strcmp(y{iy}, smallDist(:,2))));
    end
    [count, itemp] = max(n);
    if count > 1
        label{i} = y(itemp);
    else
        [~,idx] = max([smallDist{:,1}]);
        label{i} = y{idx};
    end
    
end
% label = label';
end