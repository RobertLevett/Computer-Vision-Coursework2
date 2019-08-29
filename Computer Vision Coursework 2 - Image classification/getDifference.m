function [difference] = getDifference(t,d,distType,p)
% difference = 0;
% for i = 1:size(t)
% difference = difference + abs(t(i)-d(i));
% end
if strcmp(distType, 'l1')
    difference = norm(t-d, 1);
elseif strcmp(distType, 'l2')
    difference = norm(t-d, 2);
elseif strcmp(distType, 'histInter')
    difference = histInter(t,d);
elseif strcmp(distType, 'minkowski')
    difference = pdist2(t,d,distType, p); 
else
    difference = pdist2(t,d,distType);
end
end
